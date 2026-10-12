# Review r232, the transfer theorem

Gate 2, reviewer 232. Brief: `brief22.md`, claim 1 (reviewer 233 runs claims 2–5 concurrently). Commit under review: 054e1e2, [run_bn_transfer_theorem.py](scripts/runs/run_bn_transfer_theorem.py). Scripts: [scripts/reviewers/r232/](scripts/reviewers/r232/).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1a | Padding-collapse: no complete-contraction diagram carries a free delta-loop, so every $q_D$ restricts | **CONFIRMED**, the diagram grammar forbids it, and 105/105 degree-2 and 200 degree-3 diagrams are literally $n$-independent |
| 1b | The FFT for $O(n)$ **spans** at every dimension; only independence needs a stable range | **CONFIRMED**, exact at $n=1,2,3$ for $2m=2,4,6$; independence fails below the stable range exactly as stated |
| 1c | The theorem's quantifier, "any polynomial-functor module of the standard representation" | **WRONG GENERALITY**, $\mathcal W_n$ is not a polynomial functor of $\mathbb R^n$; the statement is true but does not cover its own application. Repairable, and the repair is one lemma |
| 1d | $k_B$ is finite by Theorem 2.11, and the owed check $n_0=12\ge k_B$ | **REFUTED**, Theorem 2.11 reaches neither $\{\mathcal W_n\}$ nor $\{\mathrm{Sym}^6(\mathcal W_n^*)\}$, and $k_B(\mathrm{Sym}^6\mathcal W)\ge24>12$ unconditionally. The owed check **cannot** be discharged |
| 1e | Step (2): Proposition 2.9 forces the unique $B_n$-invariant extension to be the diagram lift | **CONFIRMED**, the logic is sound and matches the paper's Proposition 2.9 verbatim |

**Bottom line.** The mathematics of the two steps is right, I attacked the load-bearing padding-collapse step directly and could not break it, and the FFT spanning claim is correct as stated. What fails is the hypothesis. The theorem is a true conditional whose antecedent $n_0\ge k_B$ is **unsatisfiable at $n_0=12$**, the only dimension it is wanted, because the generation degree of $\mathrm{Sym}^6(\mathcal W_n)$ over $B_n$ is $24$. "CLOSED: the invariance half of the transfer route" therefore overstates the commit: nothing is closed at $n=12$, and the word SUPERSEDED applied to [run_bn_generates_on.py](scripts/runs/run_bn_generates_on.py) should come off until $k_B$ is settled.

---

## 1a, the padding-collapse step. I tried to break it and could not

The claim under attack, from the file: *"evaluating $q_D^{(n)}$ on a padded tensor collapses every contraction sum to the $n_0$ range, because each index is attached to a $W$-factor that vanishes there and the perfect matching leaves no free delta-loop to contribute a factor of $n$."*

**No such diagram can be constructed, and the reason is grammatical rather than accidental.** A degree-$d$ complete-contraction diagram on $\mathrm{Sym}^d(\mathcal W_n^*)$ has exactly $4d$ index *slots* (four per Weyl factor) and $D$ is a perfect matching **of those slots**. Every matched pair is a delta whose two endpoints both sit on a $W$-factor. A free delta-loop is a cycle of delta edges touching no $W$-vertex; it would need an edge joining two endpoints of the same delta, i.e. a slot belonging to no tensor. There is no such slot, so there is no such cycle, for any $d$ and any $D$.

**Where the factor of $n$ actually lives, so the boundary is visible.** A free loop is precisely the degree-**zero** diagram $\delta^a_a=n$. It is excluded from the degree-$d$ generators because those have all $4d$ slots occupied and no spare delta. The programme meets that factor elsewhere and it is fatal there, [run_theta_free_description.py](scripts/runs/run_theta_free_description.py)'s $\delta^a_a$ repair dies on exactly this, which is the same fact seen from the other side.

**Witness, since a grammar argument deserves one.** [r232_padding_collapse.py](scripts/reviewers/r232/r232_padding_collapse.py) builds an integer Weyl tensor on $\mathbb R^4$ (Ricci exactly zero), pads it into $n=4,5,6,8,12$, and evaluates diagrams exactly in integer arithmetic:

- **all 105** perfect matchings at $d=2$: value constant in $n$, zero exceptions;
- **200 of the 10 395** matchings at $d=3$: value constant in $n$, zero exceptions;
- the control: the same contraction with one delta *detached* from the $W$'s scales as $46416\cdot n$, so the claim is not vacuous.

**One step is used but not stated.** The FFT is a theorem about the *ambient* tensor space; $\mathcal W_{n_0}$ is a trace-free subspace. Getting the diagram expansion of $u_{n_0}$ needs $u_{n_0}$ pulled back along the $O(n_0)$-equivariant projector $\pi_{n_0}$ onto $\mathcal W_{n_0}$, which exists because $\mathcal W_{n_0}$ is an orthogonal summand. This is harmless ($\pi$ is used only at level $n_0$, and its $n$-dependence never enters $w_n$) but the file writes "$u_{n_0}=\sum_D c_D q_D^{(n_0)}$" as if the FFT applied to $\mathcal W$ directly. Worth a sentence.

## 1b, spanning at every dimension. Correct

[r232_fft_span.py](scripts/reviewers/r232/r232_fft_span.py) computes the true $O(n)$-invariant subspace of $(\mathbb R^n)^{\otimes 2m}$ exactly, as $\ker(\mathfrak{so}(n)) \cap \mathrm{fix}(\text{a reflection})$ over $\mathbb F_p$, and compares it with the span of the $(2m-1)!!$ matchings:

| $n$ | $2m$ | matchings | rank of span | dim invariants | spans | independent |
|---|---|---|---|---|---|---|
| 1 | 4 | 3 | 1 | 1 | yes | no |
| 2 | 4 | 3 | 3 | 3 | yes | yes |
| 1 | 6 | 15 | 1 | 1 | yes | no |
| 2 | 6 | 15 | 10 | 10 | yes | no |
| 3 | 6 | 15 | 15 | 15 | yes | yes |

Spanning holds at every dimension tested, including well below the stable range; independence is what fails there. **The file's asymmetric statement is exactly right**, and it matters, because it is what lets step (1) run at small $n_0$ with no stability hypothesis.

## 1c, the quantifier is the wrong generality

The theorem is stated for "$U_n = \mathrm{Sym}^d(\mathcal W_n^*)$, or any polynomial-functor module of the standard representation". **$\mathcal W_n$ is not a polynomial functor of $\mathbb R^n$.** A polynomial functor of $\mathbb R^n$ is a $GL(n)$-subrepresentation of a tensor power; $\mathcal W_n$ is cut out of $S_{(2,2)}(\mathbb R^n)$ by the trace-free condition, which uses the metric and is not $GL$-equivariant. Witness in [r232_quantifier.py](scripts/reviewers/r232/r232_quantifier.py): pushing a Weyl tensor forward by $g=\mathrm{diag}(1,1,1,2)\in GL(4)$ gives $\max|\mathrm{Ric}|=864$.

So the clause reads as covering the application and does the opposite, the application is the one case outside it.

**The repair is one lemma, and it holds.** What step (1) actually needs is that the padding $\mathcal W_{n_0}\to\mathcal W_n$ *is* zero-padding inside $(\mathbb R^n)^{\otimes4}$, which requires zero-padded Weyl to be Weyl. It is: verified exactly in [r232_weyl_padding.py](scripts/reviewers/r232/r232_weyl_padding.py) for $(n_0,n) = (4,5),(4,6),(5,6),(5,7),(6,8),(4,12)$, every basis element, all curvature symmetries plus first Bianchi plus trace-free. So the honest hypothesis is "$U_n=\mathrm{Sym}^d(F_n^*)$ for any consistent sequence $\{F_n\}$ embedded $O(n)$-orthogonally and padding-compatibly in a tensor power", which covers polynomial functors **and** $\mathcal W_n$.

## 1d, the hypothesis $n_0 \ge k_B$ cannot be met at $n_0 = 12$

This is the finding that changes the record. Three parts, each independent.

**(i) Theorem 2.11 does not reach $\{\mathcal W_n\}$ through its kernel clause.** The clause reads "if the sequence of their adjoints $\mathcal A^*$ is a morphism $\mathcal U\to\mathcal W$, then $\mathrm{im}\,\mathcal A$ and $\ker\mathcal A$ are generated in degree $d_W$ and presented in degree $k_W$." Pairing against $T\in\mathcal C_{n+1}$ turns that hypothesis into: **$\mathrm{Ric}$ commutes with truncation.** It does not, truncating first loses the terms $T_{i,n+1,j,n+1}$. Checked directly: 10 of the first 50 basis elements of $\mathcal C_5$ disagree, 6 of 80 in $\mathcal C_6$. ($\mathrm{Ric}$ commutes with *padding*, which is why $\mathcal A$ itself is a morphism; the asymmetry is the whole point.)

**(ii) Nor through its sums clause.** $\mathcal C_n=\mathcal W_n\oplus\{h\odot g_n\}$ orthogonally over $O(n)$, but the Ricci part is not a consistent subsequence: $\mathrm{pad}(h\odot g_{n_0})$ lands back in the Ricci part only when $h\propto I$. Verified at $(4,5),(5,6),(6,7)$. **Note the trap**: the round sphere *is* that exceptional case, so testing with $S^{n_0}$ alone shows the opposite of the truth.

So the parenthetical "(finite: $B_n$ is one of Levin–Chandrasekaran's classical Weyl-group sequences, Theorem 2.11)" is unsupported. Finiteness of $k_B$ is not refuted, it is simply not delivered by the theorem cited for it.

**(iii) And the numerical check fails regardless of how $k_B$ is obtained.** A lower bound needs no calculus:

- $\{\mathcal W_n\}$ is generated in degree **exactly 4** over $B_n$. Lower bound: $\mathcal W_3=0$. Upper bound, computed: $\sum_{|S|=4}\iota_S(\mathcal W_4)$ has rank $35, 84, 168$ at $n=5,6,7$, matching $\dim\mathcal W_n$ on the nose.
- $R[B_n]\,\mathrm{Sym}^\ell(\mathcal W_d)$ consists of sums of tensors each of whose nonzero **coordinates** has index-support inside a set of size $d$, because $B_n$ signs and permutes coordinates and $\iota_S(\mathcal W_d)$ is supported in $S$.
- $\mathcal W_4$ contains a tensor with $W_{1234}\neq0$ (checked), so $\ell$ Weyl tensors on **disjoint** 4-subsets give a product with a coordinate of support $4\ell$, unreachable from any $d<4\ell$.
- Hence $\mathrm{Sym}^\ell(\mathcal W_n)$ is generated in degree exactly $4\ell$, and the presentation degree is at least the generation degree (Levin–Chandrasekaran, note after Definition 2.7).

$$k_B(\mathrm{Sym}^6\mathcal W)\ \ge\ 24\ >\ 12 = n_0, \qquad k_B(\mathrm{Sym}^3\mathcal W)\ \ge\ 12 .$$

**So the OWED item ("$k_B$ for $\mathrm{Sym}^6(\mathcal W_n^*)$, and the check $n_0=12\ge k_B$"), cannot be discharged.** Even the cubic module is knife-edge: $n_0=12$ would need $k_B(\mathrm{Sym}^3\mathcal W)=12$ *exactly*, i.e. relations appearing no later than generators, which nothing argues.

This partly re-derives what [levin-chandrasekaran-dimension-free/notes.md](references/levin-chandrasekaran-dimension-free/notes.md) estimated as "$n\ge24$" and what [run_theta_free_description.py](scripts/runs/run_theta_free_description.py) struck as having no referent for $O(n)$. The strike was right for $O(n)$ and wrong to carry over: over $B_n$, which is where this theorem runs, the chain $4\to4\ell$ is a theorem with a proof, not an estimate.

## 1e, step (2) is sound

Proposition 2.9 in the paper says exactly what the file uses: for $\mathcal U$ a $\mathcal V$-module presented in degree $k$, $P_{U_n}:U_{n+1}^{G_{n+1}}\to U_n^{G_n}$ is an isomorphism for all $n\ge k$; iterating gives $U_n^{B_n}\cong U_{n_0}^{B_{n_0}}$ for $n\ge n_0\ge k_B$. $B_n\subset O(n)$, so $w_n$ is $B_n$-invariant; $O(n_0)\supset B_{n_0}$, so $u_{n_0}$ is $B_{n_0}$-invariant; injectivity closes it. I also confirmed the two structural preconditions the file passes over: $P=\varphi_n^*$ is the orthogonal projection, which on $\mathrm{Sym}^d$ with the apolar inner product **is** restriction of the polynomial to padded arguments; and $\{\mathrm{Sym}^d(\mathcal W_n^*)\}$ is a $\mathcal V$-module in the sense of Definition 2.5, since $H_{n,d}$ acts only on coordinates beyond $[d]$ and fixes tensors supported in $[d]$.

## What should change in the record

1. **Strike "CLOSED"** from the commit's first line and from the file's summary. The correct statement is: *conditional on $n_0\ge k_B$, which does not hold at $n_0=12$.*
2. **Strike "SUPERSEDED"** on [run_bn_generates_on.py](scripts/runs/run_bn_generates_on.py). Its lemma is unconditional; the theorem that supersedes it is not.
3. **Fix the quantifier** to the padding-compatible-orthogonal-summand form, and record the trace-free padding lemma explicitly, it is the fact the whole step rests on and it is currently invisible.
4. **Record $k_B\ge24$** as settled, replacing the OWED item with the negative answer.
5. **The one route left inside the framework**: apply Proposition 2.9 to a *smaller* $\mathcal V$-module containing the target rather than all of $\mathrm{Sym}^6(\mathcal W_n^*)$, since $k_B$ is a property of the module chosen. That is not free, the consistent-sequence embedding $\varphi$ is the adjoint of restriction, and $\varphi(A_{n_0})\neq A_n$ in general, so the span of $A_n,B_n,C_n$ is not obviously a subsequence, but it is where the degree bound could come down, and nothing in the record has tried it.

Steps (1) and (2) themselves stand. The theorem is true; it is the dimension it is invoked at that is not.
