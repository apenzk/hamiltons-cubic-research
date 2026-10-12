# REVIEW r227 -- Gate 2, the dimension-free route (claims 3, 4, 5)

Reviewer 227, brief `brief19.md`, claims 3/4/5. Reviewer 226 holds claims 1 and 2.

Primary source read directly: [paper.pdf](https://arxiv.org/abs/2307.04230) (Levin & Chandrasekaran, *Dimension-Free Descriptions of Convex Sets*, arXiv:2307.04230v3). Section and theorem numbers below are the paper's own. [notes.md](../references/levin-chandrasekaran-dimension-free/notes.md) was read only afterwards, to grade it.

## Verdict table

| # | Claim as the record has it | Verdict |
|---|---|---|
| 3 | The gate $n\ge d+k$ lands "near 24", pending a computation of $d$ and $k$ by Theorem 2.11 | **REFUTED, and the route is closed harder than the record thinks.** Theorem 2.11's Tensors and Sym clauses -- the only ones that reach $\mathrm{Sym}^3(\mathcal W_n)$ -- are hypothesised on $G_n\in\{S_n,B_n,D_n\}$, and Remark 2.13 says they fail otherwise. The presentation degree $k$ is **not defined at all** for $G_n=O_n$. And $n\ge d+k$ is Theorem 5.1's gate, not Theorem 3.5's, which asks only $n_0\ge k$. The number 24 has no referent |
| 4a | Theorem 1.11 / 5.1 covers only $S_n$, $B_n$, $D_n$ | **CONFIRMED**, and it extends further than the record says: Theorem 2.16, Proposition 2.18, Corollary 2.19, Corollary 5.2 and Theorem 1.12 carry the same restriction |
| 4b | Theorem 3.5 is general | **CONFIRMED as stated**, and so are Theorem 3.4, Proposition 3.2 and Proposition 2.9 -- but see 4c: its hypotheses are unsatisfiable for $O(n)$ |
| 4c | $O(n)$ genuinely carries the consistent-sequence structure their theorems need | **REFUTED.** $\{\mathbb R^n\}$ is a consistent sequence of $\{O_n\}$-representations (Example 2.8) and its **generation** degree is defined. Its **presentation** degree is not, for any nonzero module, because Definition 2.6's induction is applied "only when $H$ has finite index in $G$" (Section 1.3) and $O(d)\times O(n-d)$ has infinite index in $O(n)$ |
| 5 | Surviving one-dimension-settles-all-$n$ overreach in FINDINGS.md, findings/, response.md | **CLEAN.** No surviving instance. Both places that state the consequence already carry the correction; response.md does not carry the route at all |

Scripts: [r227_index_test.py](../scripts/reviewers/r227/r227_index_test.py), [r227_cubic_invariants.py](../scripts/reviewers/r227/r227_cubic_invariants.py), [r227_sweep.sh](../scripts/reviewers/r227/r227_sweep.sh). Log: [gate2_227.log](../agent_logs/gate2_227.log).

---

## Claim 4 -- scope. The witness that decides claims 3 and 4 together

### 4a. Theorem 5.1 is finite-Weyl-group only, and so is most of Section 2

Theorem 5.1 opens *"Let $\mathcal V_0=\{\mathbb R^n\}$ with $G_n=B_n,D_n$, or $S_n$ as in Example 1.5"*. That is a literal hypothesis, and the record's reading of it is right. Two things the record does not say:

- The restriction is **not** an artefact of the real-type step in the proof. $O(n)$'s real irreducibles are also of real type, so Schur's lemma would go through. What the proof actually needs from the restriction is Theorem 2.16, which is itself stated only for $B_n,D_n,S_n$, and the input degrees $d,k$, which only Theorem 2.11 supplies.
- The same restriction runs through Theorem 2.16, Proposition 2.18, Corollary 2.19, Corollary 5.2 and Theorem 1.12. Proposition 5.4 (relative entropy) *is* stated for a general $\{G_n\}$, but it needs a permutation module, which $\mathrm{Sym}^3(\mathcal W_n)$ is not.

### 4b. Theorem 3.5 is general in form

Theorem 3.5 opens *"Let $\mathcal V_0$ be a consistent sequence of $\{G_n\}$ representations"*. Confirmed. Theorem 3.4, Proposition 3.2 and Proposition 2.9 are likewise general. So is Proposition 2.3, which matters below: its proof uses only finite sums $u=\sum_i g_i\varphi_n(u_i)$ and never touches an induced representation.

### 4c. The witness: the presentation degree does not exist for $O(n)$

Section 1.3, defining induction:

> $\mathrm{Ind}^{\mathcal G}_{\mathcal H}(\mathcal V)=\mathbb R[\mathcal G]\otimes_{\mathbb R[\mathcal H]}\mathcal V$. We have $\dim\mathrm{Ind}^{\mathcal G}_{\mathcal H}(\mathcal V)=|\mathcal G/\mathcal H|\dim\mathcal V$, **and we apply this notion only when $\mathcal H$ has finite index in $\mathcal G$.**

Definition 2.6 builds algebraically free $\mathcal V$-modules **only** out of $\mathrm{Ind}^{G_n}_{G_dH_{n,d}}\mathcal W$. Definition 2.7 defines "presented in degree $k$" **only** through a surjection from such a free module. Proposition B.2 constructs the free cover the same way.

For $\mathcal V_0=\{\mathbb R^n\}$ with $G_n=O_n$, Example 2.8 states the centralizing subgroups: $H_{n,d}$ is the group of orthogonal matrices fixing the first $d$ coordinates, i.e. $H_{n,d}\cong O(n-d)$, so $G_dH_{n,d}=O(d)\times O(n-d)$. The coset space $O(n)/(O(d)\times O(n-d))$ is the real Grassmannian $\mathrm{Gr}(d,n)$, of dimension $d(n-d)>0$ for $0<d<n$. **The index is infinite.**

Consequently, for $\{G_n\}=\{O_n\}$ there is **no nonzero finite-dimensional algebraically free $\mathcal V_0$-module**, hence **no nonzero $\mathcal V_0$-module has a finite presentation degree**. Theorem 3.4 and Theorem 3.5 both open "fix $n_0\ge k$". That hypothesis is unsatisfiable. Theorem 3.5 is general in form and empty in substance for our group.

**The obstruction is base-independent.** It is not an artefact of choosing $\mathcal V_0=\{\mathbb R^n\}$. For the base the authors themselves use in their $O_n$ example, $\mathcal V_0=\{\mathbb S^n\}$ under conjugation, the centralizing subgroup is $H_{n,d}=\{\pm I_d\}\times O(n-d)$ and $G_dH_{n,d}$ still has infinite index in $O(n)$. Any base sequence on which $O(n)$ acts with positive-dimensional orbits gives the same failure.

**Discriminator (the planted violation).** The same index computation must *pass* for the three groups for which the paper does state presentation degrees. [r227_index_test.py](../scripts/reviewers/r227/r227_index_test.py) computes $[G_n:G_dH_{n,d}]$ for all four sequences:

| $n$ | $d$ | $S_n$ | $B_n$ | $D_n$ | $O_n$ | $\dim\mathrm{Gr}(d,n)$ |
|---|---|---|---|---|---|---|
| 12 | 1 | 12 | 12 | 12 | $\infty$ | 11 |
| 12 | 2 | 66 | 66 | 66 | $\infty$ | 20 |
| 12 | 4 | 495 | 495 | 495 | $\infty$ | 32 |

Finite for $S_n,B_n,D_n$; infinite for $O_n$. The test fires exactly where the paper's own silence is.

### 4d. The authors say this themselves, twice

Two passages the record's notes missed, and they are decisive:

1. **Section 7, Future Work.** *"(Lie groups) Can we extend our calculus for presentation degrees in Theorem 2.11 to Lie groups such as $G_n=O_n$?"* -- an open problem, in their own list.
2. **Section 6, their own $O_n$ worked example.** *"Without a calculus for presentation degrees for $G_n=O_n$, our theory does not guarantee the existence of an $O_n$-invariant extension of our learned description. Our theory does however guarantee a unique $B_n$-invariant extension, and in practice we observe that the extension is, in fact, $O_n$-invariant."*

They hit exactly the wall this programme would hit, at $n_0=4$, and their workaround was to drop to $B_n$ and *observe* the $O_n$-invariance rather than prove it.

### 4e. Two errors in the record's notes

- [notes.md](../references/levin-chandrasekaran-dimension-free/notes.md) says *"The orthogonal group is one of its consistent sequences, listed as $O_n=\{g:g^\top g=I_n\}$"*, citing Table 1. **Table 1 is a notation glossary** -- its caption is "Commonly-used groups and vector spaces" -- not a register of consistent sequences. The conclusion happens to be true, but the correct citation is Example 2.8, and the inference drawn from it ("so the framework covers our setting") is what fails.
- The notes say Appendix B, Proposition B.1(b) condition (32) is "where the presentation degree is computed". It is where the presentation degree is *motivated*; nothing there computes one, and nothing there escapes the finite-index requirement.

---

## Claim 3 -- the $d+k$ estimate

### The gate is misattributed

$n\ge d+k$ is **Theorem 5.1's** gate, for constant-sized descriptions under $S_n/B_n/D_n$. **Theorem 3.5** -- the theorem the programme actually wants, the one that extends a fixed-dimension description upward -- requires only $n_0\ge k$. Section 3.2's preamble is more demanding in a different direction: $n_0$ must exceed the presentation degrees of $\mathcal W$, $\mathcal U$, $\mathcal V\otimes\mathcal U$ **and** $\mathcal W\otimes\mathcal U$. Those tensor products need Theorem 2.11's Tensors clause, which is again $S_n/B_n/D_n$ only.

So the record's "$n\ge d+k\approx24$" imports a gate from the theorem it cannot use into the theorem it wants, and computes it with a calculus neither theorem makes available here.

### The chain "$4\to12\to24$" uses the unavailable clause twice

Theorem 2.11 has four clauses. Sums and Images/kernels hold for any $\{G_n\}$. **Tensors** and **Sym/$\Lambda$** are prefaced *"If $\mathcal V=\{\mathbb R^n\}$ with $G_n=B_n,D_n$, or $S_n$"*, and Remark 2.13 states outright that *"the last two conclusions in Theorem 2.11 fail without the restriction"*, with an explicit counterexample ($G_n=\mathrm{Cyc}_{2^n}$, generated in degree 1, with $\mathcal V^{\otimes2}$ not finitely generated). The record's step $d_{\mathcal W}\approx4\Rightarrow d_{\mathrm{Sym}^3}\approx12$ is the Sym clause; the step $k\ge d$ then doubling to 24 rides on it. Neither is available.

### What *is* computable for $O(n)$, and what it says

The generation degree survives for $O_n$: Definition 2.2 and Proposition 2.3 use no induction. Two things follow.

**1. $\{\mathcal W_n\}$ is generated in degree exactly 4 over $\{O_n\}$.** $\mathcal W_n$ is the $O(n)$-irreducible $[2,2]$, so any nonzero submodule is everything; the zero-padding of $\mathcal W_4$ into $\mathcal W_n$ is trace-free and Bianchi-closed, hence nonzero, and $\dim\mathcal W_4=10$. So $\mathbb R[O_n]\mathcal W_4=\mathcal W_n$ for all $n\ge4$. And $\dim\mathcal W_3=0$, so degree 3 fails. **Exactly 4, not "about 4"** -- but by irreducibility, not by the calculus.

**2. $\{\mathrm{Sym}^3(\mathcal W_n)\}$ is generated in degree $\ge6$, and nothing on the record pushes it to 12.** Proposition 2.3 gives, for $n\ge d$, that $\dim U_n^{G_n}$ is non-increasing. Contrapositive: a strict increase at $n\to n+1$ forces $d>n$. [r227_cubic_invariants.py](../scripts/reviewers/r227/r227_cubic_invariants.py) builds $\mathcal W_n$ from scratch (Bianchi kernel inside $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$, then the kernel of the Ricci contraction; dimensions reproduce $10,35,84,168,300$ exactly) and measures the rank of the two classical cubic contractions $W_{abcd}W^{cdef}W_{ef}{}^{ab}$ and $W_{abcd}W^{aecf}W^b{}_e{}^d{}_f$ on it:

| $n$ | $\dim\mathcal W_n$ | $\dim\mathrm{Sym}^3(\mathcal W_n)^{O(n)}$ | $I_2/I_1$ spread over 60 samples |
|---|---|---|---|
| 4 | 10 | 1 | $4.6\times10^{-14}$ |
| 5 | 35 | 1 | $8.3\times10^{-14}$ |
| 6 | 84 | **2** | $6.8$ |
| 7 | 168 | 2 | $13.8$ |
| 8 | 300 | 2 | $39.6$ |

The jump at $n=5\to6$ is real (the two invariants are proportional to 14 digits below it and manifestly independent above), it reproduces the record's own $1$-versus-$2$ at [sym3-blocks.md](../findings/sym3-blocks.md) line 140 by an independent route, and it forces $d\ge6$. Above $n=6$ this module gives no further obstruction; nor does $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_n)^{O(n)}$, whose dimension the record measures as $493$ at $n=10$ and $477$ at $n\ge12$ -- **decreasing**, exactly as Proposition 2.3 permits above the generation degree.

**So the only rigorous statement available is $6\le d<\infty$ with $k$ undefined.** No evidence on the record forces $d$ anywhere near 12, and the "near 24" is a guess built on a calculus clause the paper disowns for this group.

### Verdict on claim 3

**REFUTED.** Not "the estimate is loose and needs a computation" -- the computation the brief asks for cannot be performed, because Theorem 2.11 supplies no clause that reaches $\mathrm{Sym}^3$ over $O(n)$ and Definition 2.7 supplies no $k$ at all. The correct entry for the record is: *there is no $n_0$ that Levin--Chandrasekaran certifies for $\{O_n\}$, at 12, at 24, or anywhere.*

### What would reopen it

Three routes, in increasing cost:

1. **Drop to $B_n\subset O(n)$**, as the authors do in their own example. $B_n$-invariance of the target is automatic (the target is $O(n)$-invariant), the presentation degrees are then computable by Theorem 2.11 from Example 2.8's $k=1$, and one gets a unique $B_n$-invariant freely-described extension. The gap is then exactly the gap they leave open: whether that extension is $O(n)$-invariant. That is a *smaller* gap than the one the programme now faces, and it is the first thing to try.
2. **Prove an effective Proposition 2.9 for $O_n$ directly.** Proposition 2.3 already gives that $\dim U_n^{O_n}$ is eventually constant; what is missing is a threshold. Define $k_{\mathrm{eff}}$ as the least $n$ from which $P_{U_n}$ is an isomorphism on invariants, and prove Theorems 3.4 and 3.5 from that instead of from a free presentation. Their proofs currently construct the extension through $\mathrm{Ind}$, so this is a reproving job, not a citation.
3. **Solve their open problem** and build the presentation-degree calculus for $G_n=O_n$.

---

## Claim 5 -- the sweep

[r227_sweep.sh](../scripts/reviewers/r227/r227_sweep.sh). Two-stage grep over FINDINGS.md, response.md and findings/ (52 candidate lines mentioning a certificate, a transfer, the block table, stability, or the Levin--Chandrasekaran machinery), then read.

**Result: clean. No surviving statement that a certificate at one dimension settles Conjecture A for all even $n\ge12$.** The two places that state the consequence already carry the correction, in the strongest possible form:

- [findings/INDEX.md](../findings/INDEX.md) line 39: *"What it fixes is the certificate problem's SHAPE, not its constraint data -- an actual certificate does not transfer upward without a further argument, and none exists."*
- [sym3-stability.md](../findings/sym3-stability.md) lines 40--42: a dedicated "Scope: what the theorem does not give" section, ending *"So a certificate built at $n=12$ settles Conjecture A at $n=12$. Transferring it upward is a separate question, and the programme has no route to it."*

[response.md](../response.md) does not carry the SOS/$\mathrm{Sym}^3$ route at all -- its $n\ge12$ statements are Lemma L20 (the $\mathbb{CP}^2$ tube) and Lemma L29 (the two-negative stratum), both genuinely uniform in $n$ and unrelated. [sym3-blocks.md](../findings/sym3-blocks.md) is $n=5$ throughout and line 140 states the non-liftability outright.

**Planted violation.** A file containing *"A certificate built at $n=12$ settles Conjecture A for all even $n\ge12$"* was dropped into a scratch tree and the sweep pattern was re-run against it: **caught**. The sweep is not returning clean because it is blind.

**One thing the sweep should change.** [findings/INDEX.md](../findings/INDEX.md) line 39 and [sym3-stability.md](../findings/sym3-stability.md) both say the transfer "needs a further argument, and none exists". After this review that is too soft in one direction and too hard in another: Levin--Chandrasekaran is not merely "not yet applied", it is **inapplicable as written** to $\{O_n\}$; and the $B_n$ fallback in route 1 above is a concrete argument that does not yet exist on the record. *That is a record edit, not a correction to a claim, and I have not made it -- files under review are not mine to touch.*

---

## Summary for the record

1. **The dimension-free route is closed at a lower level than the record supposes.** It fails not at an arithmetic threshold ($12$ versus $24$) but at Definition 2.7: over $\{O_n\}$ the presentation degree is undefined, because Definition 2.6's induction is declared only for finite-index subgroups and $O(d)\times O(n-d)$ has infinite index in $O(n)$.
2. **The number 24 should be struck, not refined.** It comes from Theorem 2.11's Sym clause, which Remark 2.13 disowns outside $S_n/B_n/D_n$, and it is attached to Theorem 5.1's gate rather than Theorem 3.5's.
3. **The authors flag this exact gap as open**, in Section 7, and hit it themselves in their own $O_n$ example in Section 6, where they fall back to $B_n$.
4. **What survives for $O(n)$:** generation degrees. $\{\mathcal W_n\}$ is generated in degree exactly 4; $\{\mathrm{Sym}^3(\mathcal W_n)\}$ in degree at least 6, with no evidence forcing it higher.
5. **The most promising repair is the authors' own workaround** -- run Theorem 3.5 over $\{B_n\}$, where every degree is computable, and treat "is the unique $B_n$-invariant extension $O(n)$-invariant?" as the single remaining question.
6. **Claim 5 is clean**, with the sweep's blindness ruled out by a planted violation.
