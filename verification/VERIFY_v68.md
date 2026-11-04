# v68, Lemma L62's sampling squeeze: is the number the pipeline computes the rank the conclusion is about?

*The brief was cold, the step at [results.md:631](../results.md) arrived with no verdict attached, and I derived the identification from the sources before opening anything in [verification/](.). **I ran nothing**: no script, no Sage, no numerics, and I wrote none; the pipeline was read as text, and every value quoted below is exact and taken from the record or derived by hand. Two disclosures. First, one non-mathematical execution: I parsed the four stored row dumps for their key names and array lengths (no arithmetic on their contents, no rank, the equivalent of a `wc` on a JSON file) and it is reported below as a shape check, never as evidence. Second, after finishing the derivation I read the opening of [VERIFY_v67.md](VERIFY_v67.md) for house format and saw that a sibling reached the same verdict on the same question; nothing below is taken from it. Log: [agent_logs/verify-L62-v68.log](../agent_logs/verify-L62-v68.log).*

## Verdict

**`VALID AS WRITTEN`**, on four identifications the sentence does not make.

The number the pipeline computes is **not** $\mathop{\mathrm{rank}}(\mu_K)$. It is $\mathop{\mathrm{rank}}_{\mathbb F_p}\big(\mathrm{ev}_{40}\circ\tilde\mu_K\big)$, the rank, modulo a prime, of evaluation at $40$ points composed with multiplication restricted to $K$ and extended from the $36$ real invariant Grams to the $47$ real dimensions of invariant *Hermitian* forms on $K$. Every one of those three differences, mod $p$ against $\mathbb Q$, $40$ points against the whole sextic, Hermitian $47$ against symmetric $36$, moves the number in a direction the step can afford, and the step's own sentence is the assertion that they do. The first two lose rank; the third changes it not at all. So the chain

$$13=\mathop{\mathrm{rank}}_{\mathbb F_p}(\mathrm{ev}_{40}\circ\tilde\mu_K)\ \le\ \mathop{\mathrm{rank}}_{\mathbb Q}(\mathrm{ev}_{40}\circ\tilde\mu_K)\ \le\ \mathop{\mathrm{rank}}(\tilde\mu_K)\ =\ \mathop{\mathrm{rank}}(\mu_K)\ \le\ 13$$

closes, and with it $\dim\mathrm{ANN}=14-13=1$. The identification the step needs is an *inequality* identification, and it holds at every link.

The four things it needs and does not say are named in [What the sentence does not say](#what-the-sentence-does-not-say). One is a genuine hole in the written record: the equality $\mathop{\mathrm{rank}}(\tilde\mu_K)=\mathop{\mathrm{rank}}(\mu_K)$ (the step from the pipeline's $47$ columns to the $36$ unknowns the conclusion is about), is stated in the record only for the *unrestricted* $89=65+24$, never for the restricted $47=36+11$ that the matrix actually has. I supply the restricted proof below; it is two lines and it holds.

## The matrix, read as text

The number appears twice in one run of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py), from one matrix. `RROWS = [herm_row(g, TR) for g in GSAMP]` is formed at line 1181; `rk_A = rank_mod_p([r[:-1] for r in AUG])` at line 1232 and `rr = rank_mod_p(RROWS)` at line 1268 are the rank of that same matrix, the first with the $F_5$ column stripped off again. Line 1235 asserts the value is $13$, and line 1272 asserts it is at most $13$.

| | what it is |
| --- | --- |
| rows | $40$, one per sample point, random **real** rational Weyl tensors from `rand_weyl_tensor` under the fixed seed `20260829`, entries drawn from $\{-4,\dots,4\}$ against the $35$-dimensional module basis. Nothing here samples $K$. |
| columns | $47$, one per real coordinate of an $O(5)$-invariant **Hermitian** form on $K$: per surviving block, $\mathop{\mathrm{Re}}H_{aa}$ and then $(\mathop{\mathrm{Re}}H_{ab},\mathop{\mathrm{Im}}H_{ab})$ for $a<b$, blocks walked in the order $(-m_\lambda,\lambda)$. |
| entries | elements of $\mathbb F_p$, $p\equiv1\bmod 4$, arrived at through $\mathbb Z[i]/p$ pair arithmetic. |
| ring | $\mathbb F_p$ throughout; `rank_mod_p` is textbook Gaussian elimination on the transpose, exercised on planted ranks $0,1,7,13,14$ at line 974. |

The restricted shape $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$ that the dumps carry gives $\sum m'=25$, $\sum m'^2=47$, $\sum\binom{m'+1}{2}=36$ and $\sum\binom{m'}{2}=11$, the multiplicities, the Hermitian dimension, the real symmetric dimension and the real antisymmetric dimension of the record's own count.

## Link 1, the row is $\mu_K^*(\mathrm{ev}_W)$

`sample_row` expands $W^3$ weight by weight in the adapted basis, producing per block the multiplicity-indexed coordinate vectors $x^i(W)$ in the abstract $V_\lambda$, and returns $G^\lambda_{ij}(W)=\sum_{t,s}x^\lambda_{i,t}\overline{x^\lambda_{j,s}}\,Q^\lambda_{ts}$. Pairing that against the coordinate vector of a Hermitian $q$ as `herm_row` lays it out gives

$$\sum_a q_{aa}H_{aa}+\sum_{a<b}\big(\mathop{\mathrm{Re}}q_{ab}\mathop{\mathrm{Re}}H_{ab}+\mathop{\mathrm{Im}}q_{ab}\mathop{\mathrm{Im}}H_{ab}\big),$$

which is $\mathop{\mathrm{tr}}(qH)$ with the off-diagonal terms carrying half their weight, a fixed positive rescaling of the off-diagonal coordinates, invisible to a rank. And $\mathop{\mathrm{tr}}(qH)$ is $h(W^3,W^3)$ for the invariant Hermitian form $h$ on $\mathrm{Sym}^3(\mathcal W_5)\otimes\mathbb C$ built from $q$ and $Q^\lambda$ by Schur, up to the automorphism $q\mapsto\bar q$ of the Hermitian space. So each row is the coordinate vector of the functional $h\mapsto\big(\text{the sextic }\tilde\mu(h)\big)(W)$, which is $\tilde\mu^*(\mathrm{ev}_W)$ precomposed with one fixed $\mathbb R$-linear automorphism of the domain. Rank sees neither the rescaling nor the automorphism.

**This is the link that carries a hypothesis rather than a proof.** The identity $\mathop{\mathrm{tr}}(qH)=h(W^3,W^3)$ needs the copies of each block to be identified *equivariantly* (the same abstract $V_\lambda$, the same position list, in every copy) or $G_{ij}$ is not an invariant pairing and the row is not $\tilde\mu^*(\mathrm{ev}_W)$ at all. The pipeline says so at line 720, crediting reviewer 209's $S_3$-on-$\mathbb R^3$ counterexample where a per-copy position list yields sampled rank $10$ against a cap of $7$, and it names the multi-probe Schur test at line 501 as the guard: $\langle R_{i,t},R_{j,t}\rangle/\langle R_{0,t},R_{0,t}\rangle$ must be independent of $t$, tested at *every* position of every multiplicity block, `dis == 0` with `skipped == 0` asserted. That test is necessary, not sufficient. It is upstream of the step and the step does not mention it.

## Link 2, $\mathop{\mathrm{rank}}(\tilde\mu_K)=\mathop{\mathrm{rank}}(\mu_K)$, which the record proves only unrestricted

The pipeline's domain is $47$-dimensional and $\mathop{\mathrm{rank}}(\mu_K)$ is about a $36$-dimensional one. The two ranks agree, and here is why, restricted:

Let $h$ be an invariant Hermitian form on $K\otimes\mathbb C$ and $v\in K$ real. Restricting $h$ to the real $K$ splits it as $h=S+iA$ with $S$ real symmetric and $A$ real antisymmetric, because $h(u,v)=\overline{h(v,u)}$. Then $h(v,v)=S(v,v)$, since $A(v,v)=0$. So the sextic attached to $h$ depends on $S$ alone; every invariant real symmetric $S$ arises from some $h$; hence $\mathop{\mathrm{image}}(\tilde\mu_K)=\mathop{\mathrm{image}}(\mu_K)$ and the ranks are equal, with $\ker\tilde\mu_K\supseteq$ an $11$-dimensional space. The sample points are real Weyl tensors, which is what makes $v=W^3$ real and the argument available.

The record states the unrestricted version of exactly this at [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) line 582, "An antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic, so they lie in the kernel", for $89=65+24$. The restricted $47=36+11$ appears in [findings/sym3-blocks.md](../findings/sym3-blocks.md) as an arithmetic identity in a reviewer note, transported through L86's parity rule and L87's rank-one step, with no statement that the extra $11$ die. **The step needs the restricted version and the record does not carry it.** It is true, and above.

One trap worth marking, because it is the same trap reviewer 204 sprang on the unrestricted count: the $11$-dimensional kernel is *not* the eleven `Im` coordinates that `herm_row` emits. In a basis real for the real structure it would be; the adapted basis is measurably not that basis, $h$ being non-real on $\lambda=(2,0)$. The dimension is right and the labelling is wrong, and rank cares only about the dimension.

## Link 3, the restriction $T$ really is $K$, and its unconjugated condition is the right one

$K$ is the record's span of cubics vanishing on $O(5)\cdot W_0$: a submodule, hence $\bigoplus_\lambda V_\lambda\otimes U_\lambda$ with $U_\lambda=\ker(\mathrm{ev}_\lambda)$ of codimension $1$ in the $\lambda_2$-even blocks and everything in the odd ones, codimension one because $\dim V_\lambda^H\le1$ (L86) and the evaluation rank is exactly $1$ (L87). The pipeline builds $T$ with $m-1$ rows annihilating the vector $u_\lambda$ read off $W_0^3$'s block expansion, asserts $Ta=0$ directly at line 1096, and the resulting surviving shape reproduces $25$ multiplicities across $16$ blocks.

**The choice of $u_\lambda$ deserves the scrutiny the file gives it, and it is right.** The file's own comment at line 980 says the expansion coefficients are the *wrong* vector ("$A^{-1}b$, not $\langle W_0^3,R\rangle$, the two differ by the $\mathrm{Sym}^3$ metric") and then the shipped code reads $u$ off `XW0`, which is the expansion coefficients. The two comments cannot both be right, and the shipped choice is the correct one, for a reason neither comment gives:

Under $\mathfrak G=cc^*$ the cubic being squared is $f=\sum_i c_i\,x^i$, where $x^i$ is the *coordinate functional* (the cubic whose value at $W$ is the $i$-th expansion coefficient of $W^3$) and not $R_i$ itself. Those two bases are dual, not equal. At $W_0$ the block expansion is rank one, $x_{i,t}(W_0)=a_ib_t$, so $f(W_0)=b_t\sum_ic_ia_i$, and $f\in K$ reads $c\cdot a=0$ with **no conjugate and no metric factor**. That is precisely `TR`. The Gram condition it induces is $\mathfrak G\bar a=0$ in the docstring's convention, which is what `herm_row`'s $\mathop{\mathrm{tr}}(qH)$ pairing delivers after the conjugation twist of Link 1, the two conjugations cancel, which is why the shipped restriction attains the cap while the file's two earlier attempts, each carrying one of them, came out at $14$ against a cap of $13$.

So the pipeline's restricted domain is exactly $\{\mathfrak G\ \text{Hermitian}:\mathfrak G\ \text{supported on }K\}$, of real dimension $\sum(m_\lambda-1)^2+\sum_{\text{odd}}m_\lambda^2=47$.

## Link 4, mod $p$ is a reduction, not an approximation

For "reduction modulo a prime can only lower it" to apply, the entries must be the reductions of the rational entries, and that is not automatic when the whole coordinate expansion is done mod $p$. It holds here, for a reason the file arranges rather than assumes. `invert_weight` inverts each weight block once over $\mathbb Z[i]/p$; the pivot must be a **unit**, which `gpinv` enforces with `assert den` on the norm $a^2+b^2$. Since $p\equiv1\bmod4$ the ring $\mathbb Z[i]/p\cong\mathbb F_p\times\mathbb F_p$ has zero divisors, so a nonzero non-unit pivot is possible, and it aborts the run rather than corrupting it. When the elimination completes, every operation was an invertible ring operation, the block is a unit mod $p$ hence nonsingular over $\mathbb Q(i)$, and the computed inverse is the reduction of the rational inverse. Reduction is a ring homomorphism, so every downstream row is the reduction of the exact row, and $\mathop{\mathrm{rank}}_{\mathbb F_p}\le\mathop{\mathrm{rank}}_{\mathbb Q}$ as the step says.

## The cap, and where the squeeze closes

The upper end is a theorem and not in dispute: $\lVert W\rVert^6$ is an invariant sextic with value $1$ at $W_0$, so evaluation at $W_0$ is a nonzero functional on the $14$; every product of two cubics of $K$ vanishes at $W_0$; so $\mathop{\mathrm{image}}(\mu_K)$ lies in a $13$-dimensional subspace. [run_n5_order2.py](../scripts/runs/run_n5_order2.py) carries it, together with reviewer 203's observation that order $1$ is what does the work and order $2$ is free. The pipeline realises the same cap concretely: $H(W_0)=c\,qq^*$ with $q=Ta=0$, so the restricted row at $W_0$ is identically zero and every sextic in the image vanishes there.

Both ends therefore describe $\mathop{\mathrm{rank}}(\mu_K)$, the cap from above and the sampled mod-$p$ rank from below, and the sample and the reduction both under-count. Attainment closes it. The step's own final sentence ("the argument is exact, the sampling being a lower bound rather than a numerical estimate"), is an accurate description of what it did.

## "It equals $13$ at four primes"

The four primes are $1099511627873$, $1099511627917$, $1099511627933$ and $1099511627953$, all $\equiv1\bmod4$ as the pipeline requires, all near $2^{40}$. They were chosen for the CRT lift of the rows to $\mathbb Q$, not for a four-prime study of the rank, and [findings/sym3-blocks.md](../findings/sym3-blocks.md) carries a reviewer note under L90 saying the "four primes" attribution belongs to that lift; L90's own body reports the restricted rank at $p=1000033$ with an independent reproduction by reviewer 209 at $p=1000003$.

**The claim survives anyway, and for a reason the note does not consider.** `assert rk_A == 13` at line 1235 sits *above* the dump at line 1249 in the same code path, unconditionally. A stored dump at prime $p$ is therefore a run that passed the rank assert at $p$. Four dumps exist, each $40$ rows by $47$ columns, all four carrying the identical block order and shape, so the four runs did each establish $13$. What they do not supply is independence: four runs of one code path at four primes test the prime and nothing else.

**And the count is logically free.** One prime suffices: $\mathop{\mathrm{rank}}_{\mathbb F_p}=13$ already forces equality all the way up the chain. Additional primes buy robustness against implementation error, not inferential strength. So even read as the misattribution the note calls it, "four primes" cannot damage the step.

A related worry that turns out not to reach the rank at all: the column-ordering defect reviewers 211 and 212 found (the dump walked blocks by $\lambda$ while `herm_row` walked them by $(-m,\lambda)$), is a permutation of columns. It broke the psd point, whose minimum eigenvalue went to $-1440$ under the true partition; it cannot move a rank.

## What the sentence does not say

| needed | said in L62 | on the record elsewhere |
| --- | --- | --- |
| the row is $\mu_K^*(\mathrm{ev}_W)$, which needs the copies identified equivariantly | no | yes, [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) line 720, guarded by the multi-probe Schur test at line 501, and flagged in [findings/sym3-blocks.md](../findings/sym3-blocks.md) as load-bearing and previously undeclared |
| $\mathop{\mathrm{rank}}(\tilde\mu_K)=\mathop{\mathrm{rank}}(\mu_K)$, the $47$ Hermitian columns against the $36$ unknowns | no | **only unrestricted**; the restricted $47=36+11$ appears as arithmetic in a reviewer note, with no statement that the extra $11$ lie in the kernel. Proved above |
| $T$'s row space is $K$'s multiplicity space | no | yes, [run_n5_order2.py](../scripts/runs/run_n5_order2.py), reviewer 210's submodule argument, and the $q=Ta$ assert |
| the mod-$p$ entries are reductions of the rational ones | half, the sentence asserts the inequality without the hypothesis | the pivot asserts arrange it; nothing states it |

Two defects of description, neither of which touches the logic:

- **"A rank computed from a sample of $K$" mis-names what is sampled.** The sample is $40$ evaluation points in $\mathcal W_5$; $K$ enters exactly, as an exact linear restriction. The sentence survives the mis-naming because both readings of "sample" (a sample of points, or a sample of the domain), produce a lower bound, so the direction the argument needs holds either way.
- **"The restricted rank" is never named as $\mathop{\mathrm{rank}}(\mu_K)$ in the block itself**, an omission already booked against L91 in [findings/sym3-blocks.md](../findings/sym3-blocks.md). The reader must import it from L59.

## The strongest defence, including the part that goes beyond the text

The step is exposed at exactly one place: attainment on a cap is invisible to a defect, as [findings/sym3-blocks.md](../findings/sym3-blocks.md) itself warns. The three wrong restrictions this stage went through were caught only by coming out *above* $13$; a fourth wrong one landing *on* $13$ would pass every assert the file ships.

The record has an answer to that and does not use it here. The same run performs a consistency test the rank argument never invokes: $\mathop{\mathrm{rank}}[A\mid F_5]=\mathop{\mathrm{rank}}(A)=13$ at line 1233, where the $40$ right-hand values come from `F5_of`, an independent evaluator that contracts the rank-$4$ tensor directly and shares no code with the row pipeline. A rank-$13$ column space inside $\mathbb F_p^{40}$ is a codimension-$27$ subspace. For an unrelated vector to land inside it is a $p^{-27}$ coincidence, with $p\approx2^{40}$. So the consistency check is a $27$-condition a posteriori certificate that the rows really are the functionals $\mu_K^*(\mathrm{ev}_W)$ and not some near-miss, precisely the hypothesis of Link 1, which no theorem in the record supplies. It is evidence rather than proof, since a *different* but still invariant row map whose image contains $F_5$ would also pass; but it is far stronger evidence than the attainment itself, and it is available for free in the same run.

Two further pieces of the same defence, both structural: the restricted row at $W_0$ is asserted zero on all $47$ coordinates through $q=Ta$ rather than through $q\bar q$, which reviewer 210 showed can vanish spuriously when $p\equiv1\bmod4$; and $F_5(W_0)=0$ is asserted mod $p$ against a value that is exactly zero over $\mathbb Z$. Together with the derivation in Links 1–4, that is as much support as a step of this shape can carry without a proof of unisolvence, and unisolvence is not needed, because the step never claims the sampled rank equals the true one except at the moment the cap forces it.
