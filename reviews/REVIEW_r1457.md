# REVIEW r1457: L50's converse in Lean, commit fb869ac7: R4_diagOp, sum_R4_diagOp, alphaW_diagOp, betaW_diagOp, g6, wS, L50_converse, and the citing text in lean/INDEX.md, findings/bispectral.md, results.md and report Lemma 51

Log [agent_logs/r1457.log](../agent_logs/r1457.log). One reviewer, working cold, statement fidelity and hypothesis use against the record. Analysis-only: `lake build HamiltonsCubic.Results.L50Converse` (clean, one style info from the flexible-`simp` linter at [L50Converse.lean:83](../lean/HamiltonsCubic/Results/L50Converse.lean)), and one scratch file in the session scratchpad (outside the repository) carrying `#print axioms` for three names and `#check @L50_converse`. The witness's sums were recomputed by hand. No screen was run.

**Standfirst.** The record's claim, quoted from [bispectral.md:121](../findings/bispectral.md): "On $\mathrm{Weyl}_n$ for $n\le5$, and only there, $\beta=\tfrac12\alpha$, equivalently $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ and $\theta=3\mathop{\mathrm{tr}}(W^3)$". Its negation above five is one $W\in\mathrm{Weyl}_n$ at each $n\ge6$ where the collapse fails, and `L50_converse` gives exactly that, for both equivalent forms, on the standard three axioms. The diagonal formulas $\alpha=4\sum w_{ij}^3$ and $\beta=\sum w_{ij}w_{im}w_{jm}$ are right, and the witness's numbers ($\sum w^3=180$, $\mathop{\mathrm{tr}}w^3=1620$, $P=900$, $\mathop{\mathrm{tr}}M^3=90$, $\langle M^\#,M\rangle=810$) all come out by hand. The one gap is a sentence the commit left behind: the report's certificate still says the failures at $n=6,7$ are "what confines it".

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Statement fidelity | CONFIRMED | "Only there" asserts that the identity fails on $\mathrm{Weyl}_n$ for each $n\ge6$, and one failing $W$ per $n$ refutes it both pointwise and as an identity of cubic (hence polarised trilinear) forms. `L50_converse` gives, for every `n ≥ 6`, an `R` with `IsWeylOp R` (linear, skew-preserving, self-adjoint, Bianchi, Ricci-flat), `Pcubic R ≠ 3 * trCube R` and `sharpPair R ≠ 2 * trCube R`, so both "equivalently" forms fail. Both sides are homogeneous of degree $3$, so rescaling to $\lVert M\rVert_F=1$ keeps $P\ne3\mathop{\mathrm{tr}}M^3$ and the unnormalised form suffices. |
| B. The formulas | CONFIRMED | From $W_{ijkl}=w_{ij}(\delta_{ik}\delta_{jl}-\delta_{jk}\delta_{il})$: for $i\ne j$, $(k,l)$ and $(m,n)$ each range over $(i,j),(j,i)$ with signs that cancel in pairs, giving $4w_{ij}^3$, so $\alpha=4\sum_{\text{ordered}}w^3=8\sum_{i<j}w^3=8\mathop{\mathrm{tr}}M^3$. For $\beta$, $(k,l)=(i,j)$ forces $n=m$ and leaves $w_{ij}w_{im}w_{jm}$, while $(k,l)=(j,i)$ forces $m=j$ and kills the last factor. Both match the Lean statements and the record's $\alpha=8\mathop{\mathrm{tr}}M^3$ with ordered-pair doubling. |
| C. The witness | CONFIRMED | `g6` is $3$ in-block, $-2$ across, $0$ on the diagonal and beyond index $5$, proportional to the Weyl weight of $S^3\times S^3$ ($0.6$ and $-0.4$ at unit round factors). Row sums are $6-6=0$, and padded rows are zero, so `IsWeight` holds at every $n\ge6$ (`wS_isWeight`). By hand $\sum w^3=12\cdot27-18\cdot8=180$ and $\mathop{\mathrm{tr}}w^3=12^3-4\cdot27=1620$, so $\alpha=720$, $\beta=1620$, $P=90+810=900$, $3\mathop{\mathrm{tr}}M^3=270$, $\langle M^\#,M\rangle=810\ne180$. `isLinOp_diagOp` and `diagOp_isWeyl` sit under `L50_converse`'s axiom set, which carries no `sorryAx`. |
| D. Axioms | CONFIRMED | `L50_converse`, `alphaW_diagOp`, `betaW_diagOp`: each `[propext, Classical.choice, Quot.sound]`. No `native_decide`, `sorry` or `axiom` in L50Converse.lean. |
| E. Record text | CONFIRMED | The L50 row's **proved** holds: the trace form, both spectral forms, the norm relation, links (a) and (b) and now the converse are all kernel-checked. The one untyped step, the $S^2_0$ spectrum read off the block form, is disclosed in the same row, which is the repair r1439 accepted. The bispectral.md, results.md and report replacements are accurate to the numbers, carry no em dash, and their semicolons sit in lists whose items carry commas. The report sentence is status language. |
| F. Downstream | CONFIRMED WITH GAP | No file in findings/, results.md, report/, lean/INDEX.md, plan.md, STATUS.md or findings/fence-posts.md still calls "only there" unargued or the display owed. Gap: [06b-bispectral.tex:55](../report/sections/06b-bispectral.tex), the certificate's last sentence, "It fails at $n=6,7$, which is what confines it", now contradicts the proof two lines above, which confines it at every $n\ge6$ by the witness. |

**One-line summary.** The collapse's failure at every $n\ge6$ is proved in Lean exactly as the record's "only there" needs, on the standard three axioms, and the one gap is a stale certificate sentence in the report. **CONFIRMED WITH GAP**

## A. Statement fidelity

`#check @L50_converse` returns `∀ (n : ℕ), 6 ≤ n → ∃ R, IsWeylOp R ∧ Pcubic R ≠ 3 * trCube R ∧ sharpPair R ≠ 2 * trCube R`.

**What the record means.** [bispectral.md:121](../findings/bispectral.md) states the collapse on $\mathrm{Weyl}_n$ "for $n\le5$, and only there", and [results.md:340](../results.md) reads "It collapses to one spectrum for $n\le5$ as an identity of trilinear forms, and fails at every $n\ge6$." The positive half is an identity (a universally quantified statement over $\mathrm{Weyl}_n$). Its failure at $n$ is the existence of one $W\in\mathrm{Weyl}_n$ violating it. A stronger reading, that the identity "fails as an identity of trilinear forms", is implied: a pointwise failure of the cubic is a failure on the diagonal of the polarised form. No reading of the record asks for failure at every $W$, which would be false anyway, since results.md:340 itself notes padded $W_{\mathbb{CP}^2}$ collapsing at every $n$.

**Both forms.** The record lists $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}W^3$ and $\theta=3\mathop{\mathrm{tr}}W^3$ as equivalent. The Lean refutes each separately, so neither reading is left open.

**Normalisation.** L50's statement normalises $\lVert M\rVert_F=1$ and writes $\theta$. `Pcubic`, `trCube` and `sharpPair` are cubic in `R` (`IsLinOp` holds), so replacing the witness by $t\cdot$`wS` with $t=1/\lVert M\rVert_F>0$ scales both sides by $t^3$ and keeps the inequality. The unnormalised statement is enough.

**Type.** `IsWeylOp` is `IsLinOp R ∧ IsWeyl R`, with `IsWeyl` the four clauses of [WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean) (skew to skew, self-adjoint on bivectors, first Bianchi, zero Ricci). That is the layer's $\mathcal W_n$, the same predicate `Pcubic_collapse` consumes (r1456 item A), so the two halves of "only there" speak about one set.

## B. The formulas

`R4 R i j k l = inner2 (R (phi i j)) (phi k l)` and `diagOp w` multiplies entrywise, so $R\varphi_{ij}=w_{ij}\varphi_{ij}$ and $W_{ijkl}=w_{ij}\langle\varphi_{ij},\varphi_{kl}\rangle=w_{ij}(\delta_{ik}\delta_{jl}-\delta_{jk}\delta_{il})$ at the layer's `inner2_phi_phi`. That is `R4_diagOp`. `sum_R4_diagOp` contracts the second pair: $\sum_{m,n}W_{ijmn}f(m,n)=w_{ij}(f(i,j)-f(j,i))$, immediate from the two Kronecker terms.

**$\alpha$.** `alphaW` is $\sum W_{ijkl}W_{ijmn}W_{klmn}$. At $i=j$ every term has $w_{ii}=0$. At $i\ne j$, write $s(k,l)=\pm1$ for $(k,l)=(i,j),(j,i)$. The product is $s(k,l)w_{ij}\cdot s(m,n)w_{ij}\cdot s(k,l)s(m,n)w_{ij}=w_{ij}^3$ over four choices, so $\alpha=4\sum_{i\ne j}w_{ij}^3$. With $M$'s eigenvalues $w_{ij}$ on the unordered pairs, $\mathop{\mathrm{tr}}M^3=\sum_{i<j}w_{ij}^3=\tfrac12\sum_{\text{ordered}}w^3$, and $\alpha=8\mathop{\mathrm{tr}}M^3$, matching `trCube_eq_alpha` and the record's convention.

**$\beta$.** `betaW` is $\sum W_{ijkl}W_{imkn}W_{jmln}$. At $(k,l)=(i,j)$: $W_{imin}\ne0$ needs $n=m\ne i$ and gives $w_{im}$, then $W_{jmjm}=w_{jm}$. At $(k,l)=(j,i)$: $W_{imjn}\ne0$ needs $\{j,n\}=\{i,m\}$, so $m=j$, and then $W_{jj\cdot\cdot}=0$. So $\beta=\sum_{i,j,m}w_{ij}w_{im}w_{jm}=\mathop{\mathrm{tr}}(w^3)$, with hollowness killing the degenerate terms. `betaW_diagOp` states exactly this. As a cross-check, $\langle M^\#,M\rangle=\sum_{i<j}w_{ij}\sum_m w_{im}w_{jm}=\tfrac12\mathop{\mathrm{tr}}w^3=\beta/2$, which is `sharpPair_eq_beta`.

The hypotheses `hw` (symmetric) and `hh` (hollow) are what the derivations use, and the proofs split on `i = j` and on the summation index hitting `i` or `j` exactly where the hand derivation does.

## C. The witness

`g6 i j = 0` when `i = j` or either index is at least $6$, else $3$ when both lie on the same side of $3$ and $-2$ otherwise. The Weyl weight of $S^3(1)\times S^3(1)$ is $K_{ij}-(P_{ii}+P_{jj})$ with Schouten $P=\frac1{4}(2-\frac{12}{10})=0.2$, giving $0.6$ in-block and $-0.4$ across, ratio $3:-2$. So `g6` on the first six indices is that weight times $5$.

**Zero row sums.** A row in the first block has two in-block entries ($+6$) and three cross entries ($-6$). Rows beyond $5$ are zero. `wS_isWeight` proves `symm`, `hollow` and `rowSum` for every `n ≥ 6` by reducing to `range 6` with `sum_fin_six`, so padding preserves `IsWeight` at every such $n$.

**The sums by hand.** $\sum w^3$ over ordered pairs: $12$ in-block pairs at $27$ and $18$ cross pairs at $-8$, total $324-144=180$. Spectrum of `w`: the block-sign vector $(1,1,1,-1,-1,-1)$ has eigenvalue $6+6=12$, the all-ones vector $0$, and the four block-internal zero-sum vectors $-3$ (the in-block part $3(J-I)$ contributes $-3$, the cross part $0$). The trace is $12-12+0=0$, consistent with hollowness. $\mathop{\mathrm{tr}}w^3=1728-108=1620$. So $\alpha=720$, $\beta=1620$, $\mathop{\mathrm{tr}}M^3=90$, $P=\alpha/8+\beta/2=900$, $3\mathop{\mathrm{tr}}M^3=270$, $\langle M^\#,M\rangle=810$, $2\mathop{\mathrm{tr}}M^3=180$, and $P-3\mathop{\mathrm{tr}}M^3=630=(\beta-\alpha/2)/2$, as the file's docstring says.

**Sorry-freedom.** `isLinOp_diagOp` ([SharpDiag.lean:291](../lean/HamiltonsCubic/Base/SharpDiag.lean)) is `diagOp_add` and `diagOp_smul_arg`. `diagOp_isWeyl` ([Families.lean:266](../lean/HamiltonsCubic/Base/Families.lean)) is four clauses from `diagOp_skew`, `diagOp_selfAdjoint`, `diagOp_bianchi` and `diagOp_ric`. SharpDiag.lean does carry a `sorry` elsewhere (`sharpOp_diagOp`, per Families.lean's docstring), but `L50_converse`'s axiom list below shows that none of it reaches this proof.

## D. Axioms

From the scratch file:

- `L50_converse`: `[propext, Classical.choice, Quot.sound]`
- `alphaW_diagOp`: `[propext, Classical.choice, Quot.sound]`
- `betaW_diagOp`: `[propext, Classical.choice, Quot.sound]`

`#print axioms` walks the whole dependency tree, so `wS_cube`, `wS_tri`, `wS_isWeight`, `isLinOp_diagOp`, `diagOp_isWeyl`, `Pcubic_eq_alpha_beta`, `trCube_eq_alpha` and `sharpPair_eq_beta` are covered. The closing numerals are `simp`/`norm_num` over `range 6`, with no `native_decide` and no `decide` on reals.

## E. Record text

**The L50 row ([lean/INDEX.md:376](../lean/INDEX.md)).** State **proved**, ending "Nothing owed". Everything L50's block states is covered: the trace form (`L50_bispectral`), the norm relation (`L50_norm`, `sum_omega_sq`, `sum_mu_sq`), the $\mu$ and $\omega$ spectral forms (`L50_mu_spectral`, `L50_spectral`), Ricci-flat tracelessness (`sum_mu_zero`, `sum_omega_zero`), links (a) and (b), and now the converse.

*Candidate considered and withdrawn: "Nothing owed" beside the disclosed $S^2_0$ reading.* The statement's $\omega$ is the spectrum on $S^2_0$ ([bispectral.md:135](../findings/bispectral.md)), and the Lean works on $S^2$ with one extra $0$, the identification being "by reading" and "the restriction to $S^2_0$ is not formed as an operator" in the same row. The opposite case holds: $\omega$ enters L50 only through $p_1,p_2,p_3$, which an added $0$ leaves unchanged, and `Bmat_compress` with `Bmat_mulVec_g` make the block form a two-line reading. r1439's gap 1 asked the record to "either say so, or type it", and the row says so. The row is honest on the record's own standard.

**bispectral.md:139.** The new sentences state the diagonal tensor, the two formulas, the witness, zero row sums, $\alpha=720$, $\beta=1620$, $\beta-\alpha/2=1260$, $P=900$ against $270$, and name `L50_converse`. All match item C.

**results.md:340.** "It collapses to one spectrum for $n\le5$ as an identity of trilinear forms, and fails at every $n\ge6$", then both links "proved ... and kernel-checked", and "The failure at $n\ge6$ is the padded $S^3\times S^3$ weight, with $\beta-\tfrac\alpha2=1260$." Accurate. The old "no argument above $n=9$" and "One link is owed" are gone.

**Report Lemma 51's proof ([06b-bispectral.tex:51](../report/sections/06b-bispectral.tex)).** "The clause *only there* is one witness per dimension ... with $\beta-\tfrac\alpha2=1620-360\ne0$, also kernel-checked." Correct and in status language. This closes r1456's gap on the proof side.

**Punctuation.** No em dash in any added line of the five files. Every semicolon in the added text sits in the L50 row's list of named lemmas, whose items carry commas, which is the permitted use. "Dai–Fu" carries an en dash, which is a name range and fine.

## F. Downstream

Grepped findings/, results.md, report/sections/, lean/INDEX.md, plan.md, plan-lean.md, STATUS.md and findings/fence-posts.md for "only there", "no argument", "unargued", "owed" near the display or converse, "n=6,7", and $n\ge6$ near the collapse.

- No live sentence calls "only there" unargued or the display owed.
- [fence-posts.md:123](../findings/fence-posts.md) repeats "and only there" and "is not from $n=6$" without citing the witness. It claims nothing unproved and is true, so it is not a defect.
- [INDEX-results.md:65](../findings/INDEX-results.md) and STATUS.md's regenerated block agree with the row's new state.

**Gap.** [report/sections/06b-bispectral.tex:55](../report/sections/06b-bispectral.tex), the certificate under Lemma 51, ends: "It fails at $n=6,7$, which is what confines it." After this commit the proof two lines above confines the collapse at every $n\ge6$ by the kernel-checked witness, so the certificate names the wrong support for the confinement, the same defect r1456 flagged in the proof paragraph, surviving one block lower. The opposite case: a certificate records computations, and "it fails at $n=6,7$" is true as a screen. But the relative clause "which is what confines it" is a claim about what establishes the result, and it now contradicts the proof. The commit's `Searched:` trailer grepped for "only there" and "no argument", which miss this sentence. The same text is in report.pdf.

## Gaps

1. [report/sections/06b-bispectral.tex:55](../report/sections/06b-bispectral.tex): "It fails at $n=6,7$, which is what confines it" should say that the failures at $n=6,7$ are screens and that the witness in the proof confines the collapse at every $n\ge6$, or drop the relative clause. Rebuild report.pdf.
