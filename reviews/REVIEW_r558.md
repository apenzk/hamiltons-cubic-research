# Review r558, Lemma L44 ($n\ge12$ is necessary, not merely sufficient)

Reviewer r558, independent adversarial audit of `Lemma L44` at [problem.md:194](../findings/problem.md#L194), with its statement copies at [results.md:102](../results.md#L102) and [results.md:280](../results.md#L280) and its report form at [05-landscape.tex:71](../report/sections/05-landscape.tex#L71). Worked from [conventions.md](../findings/conventions.md) and the definitions, on the analysis-only footing: no run of any kind was made, and nothing below rests on one. The other reviewer's report on this brief was not opened.

**Overall verdict: CONFIRMED, with four repairs to the block's prose and one withdrawal.** The mathematics is right, the range $4\le n\le11$ is right, the single polynomial $n^2-12n+8$ is right at *both* parities, and every attribution checks out against the stored full texts. What fails is the block's wording in four places, one of which ("$W_{\mathbb{CP}^2}$ … lies on $\partial\Omega_0$"), is false as literally written and is contradicted by the record's own reference notes.

## Verdicts

| # | item | verdict |
| --- | --- | --- |
| 1 | the parity worry: is $n^2-12n+8$ the even-$n$ criterion only? | **REFUTED**, the criterion demands $\theta_0(n)$ at every parity; $\Theta_n$ never enters |
| 2 | "exactly when" as two implications | **CONFIRMED**, it is an iff *about the witness point*, and the direction necessity needs is the one exhibited |
| 3 | necessity for the problem or for the method | **CONFIRMED**, and overdetermined, the cone framing is honest but carries no weight the elementary witness lacks |
| 4a | padding preserves $\theta$, unit norm, criticality | **CONFIRMED**, rebuilt by hand from the structure constants |
| 4b | "lies on $\partial\Omega_0$" | **REFUTED**, a Weyl tensor is where $F$ blows up; the boundary point is $cI+W$ |
| 5 | the block cites its own load-bearing lemma | **DEFECT**, L43 is never named in the block |
| 6 | the attribution (Beitz, Xu, Huisken) | **CONFIRMED** verbatim against the stored PDFs' text |
| 7 | "the witness … [is] new here" | **REFUTED**, withdrawn twice elsewhere in the record, credited to Nienhaus |
| 8 | agreement with [Lemma L2](../findings/problem.md#L160) | **CONFIRMED**, same polynomial, same root, and L2 already carries the parity-correct companion |

---

## 1. The criterion compares against $\theta_0(n)$ at both parities, REFUTED (the worry, not the block)

The brief asks whether the block states an even-$n$ criterion and applies it everywhere, since at odd $n$ the diagonal maximum is $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ rather than $\theta_0(n)$. **It does not, and the substitution would be a category error.** $\Theta_n$ is what the *diagonal locus attains*; the cone criterion fixes what a competitor must *not exceed*, and that number is parity-free.

Rebuilt from Beitz's definition rather than from the block. With $\Omega_a=\{(\tfrac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}(R)\rVert^2,\ \mathrm{scal}>0\}$ and $\lVert\mathrm{ric}(R)\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$, the coefficients of the three blocks come out $\tfrac{4a-n}4$, $a$, $\tfrac{n-2}4+a$, reproducing the p. 96 display quoted at [problem.md:44](../findings/problem.md#L44) exactly. At $a=0$ on the slice $R=cI+W$, $\lVert W\rVert=1$:

$$\tfrac{n-2}n=c^2\lVert I\rVert^2=c^2\tfrac{n(n-1)}2\quad\Longrightarrow\quad c^2=\frac{2(n-2)}{n^2(n-1)} .$$

I then ran the criterion out in full rather than quoting the collapse. With $\Phi(I)=(n-1)I$, $\Phi(I,W)=0$, $Q(W)$ Weyl and $\lVert\mathrm{ric}(I)\rVert^2=\tfrac{n-1}2\lVert I\rVert^2$, the criterion $\langle R,\Phi(R)\rangle\le F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$ at $F=\tfrac4{n-2}$ becomes

$$\theta\ \le\ c^3\lVert I\rVert^2(n-1)\Big(\frac{2(n-1)}{n-2}-1\Big)=c^3\lVert I\rVert^2\frac{n(n-1)}{n-2}=c(n-1)=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

Every quantity in that chain is a rational function of $n$. **No parity anywhere.** So the comparison the block makes, $\sqrt{3/2}$ against $\theta_0(n)$, is the right one at odd $n$ as well as even, and

$$\theta_0(n)^2<\tfrac32\iff4(n-1)(n-2)<3n^2\iff n^2-12n+8<0,\qquad\text{roots }6\pm2\sqrt7,\ \text{upper }11.2915,$$

giving exactly $4\le n\le11$. The block is right and needs no second polynomial.

**Why the worry is worth recording anyway.** [conventions.md](../findings/conventions.md) glosses $\theta_0(n)$ as "the value at the balanced sphere product". At odd $n$ there is no balanced sphere product, so at odd $n$ $\theta_0(n)$ is a *formula*, and only the formula is what L43 produces. A reader who takes the gloss as the definition has no odd-$n$ object to compare against and reaches for $\Theta_n$, which is how the brief's question arose. One clause in the conventions row would close it.

*Screen, reported as a screen and not as evidence:* had the diagonal maximum been the demanded bound, $\Theta_n^2<\tfrac32$ reads $n^2-13n+18<0$, roots $\tfrac{13\pm\sqrt{97}}2$, upper $11.4244$, and the integer answer would still be $n\ge12$, $\Theta_{11}^2=\tfrac{160}{108}$, $\Theta_{13}^2=\tfrac{240}{154}$, straddling $\tfrac32$. The conclusion is insensitive to the mistake. [Lemma L2](../findings/problem.md#L160) already records that companion polynomial and its root, so the record holds the parity-correct form where it belongs.

## 2. "Exactly when", CONFIRMED, and the heading is safe

"The invariance criterion fails **there** exactly when $\theta_0(n)<\sqrt{3/2}$" quantifies over one point, not over $\partial\Omega_0$. At that point the criterion *is* the scalar inequality $\sqrt{3/2}\le\theta_0(n)$, so the biconditional is correct and needs no statement about the rest of the boundary.

The conclusion drawn is one-directional and is the direction necessity requires. Necessity of $n\ge12$ is the contrapositive of "$n\le11\Rightarrow\Omega_0$ non-invariant", and that is what a single failing boundary point gives: $G(R_0)>0$ with $F(R_0)$ at the threshold makes $F$ strictly increase, so the solution of $\dot R=\Phi(R)$ leaves $\Omega_0$ immediately. $\mathrm{scal}>0$ is open and survives, and $6+2\sqrt7$ is irrational so the inequality is strict at every integer. **Sufficiency is nowhere claimed and is the conjecture itself.**

One asymmetry the block hides. Both [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4 and [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) (3.3), *"to prove the main Theorem 1.1, we only need to verify $dF_R(Q(R))\le0$"*, supply the criterion in the **sufficiency** direction. L44 consumes the **necessity** direction, which is the record's own step. It is elementary, and [problem.md:70](../findings/problem.md#L70) discloses it, 120 lines above a block headed *canonical statement and proof*. [results.md:282](../results.md#L282) is the better statement of the two: it closes with *"It says nothing about whether the cone is invariant at $n\ge12$, which is the conjecture itself"*, a guard the canonical block lacks.

## 3. Necessary for the problem, CONFIRMED, and the cone carries no weight the witness lacks

The conjecture under audit is [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Remark 6.3.15 (*"for $n\ge12$ the cones $\Omega_a$ are invariant"*) and her notes record that the threshold is **stated with the conjecture, not derived in the thesis**. So $n\ge12$ was, in the source, an unexplained hypothesis, and L44 answers exactly the question its "Why it was needed" paragraph poses. That is necessity for the problem as posed.

But the cone route is not doing the work the heading implies. Two things must be separated:

- **The cone reading**: $\Omega_0$ is non-invariant for $4\le n\le11$. This needs L43's collapse and the necessity direction of the criterion. It is a statement about Ricci flow, and it is L44's genuine content.
- **The elementary reading**: Conjecture A's conclusion $\theta\le\theta_0(n)$ is *false* for $4\le n\le11$, padded $W_{\mathbb{CP}^2}$ being the witness, with no cone theory at all. This is one line, and the record already holds it as [Lemma L2](../findings/problem.md#L160).

Necessity of $n\ge12$ for **Conjecture A** follows from the second alone. The cone adds nothing to it; what it adds is the first statement, which is strictly about the wider cone conjecture. [results.md:37](../results.md#L37) already splits the two correctly (L2 for the crossing, L44 for the non-invariance) so the record's summary is more careful than the block. [r505](REVIEW_r505.md) reached the same place from the other side, calling this the polynomial's "fifth appearance" and showing the appearances are not independent. **No consumer misreads necessity-for-the-method as necessity-for-the-problem**: [01-introduction.tex:49](../report/sections/01-introduction.tex#L49), [09-status.tex:68](../report/sections/09-status.tex#L68), [results.md:37](../results.md#L37), [results.md:102](../results.md#L102) and [results.md:280](../results.md#L280) all state the conclusion as cone non-invariance.

## 4. The witness, the value CONFIRMED by hand, the boundary claim REFUTED

**$\theta=\sqrt{3/2}$, rebuilt from the structure constants.** Take $W_{\mathbb{CP}^2}=\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4$, the anti-self-dual block zero. Under the record's half-trace pairing $\{\varphi_{ab}\}_{a<b}$ is orthonormal, so $v_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, $v_2=(\varphi_{13}-\varphi_{24})/\sqrt2$, $v_3=(\varphi_{14}+\varphi_{23})/\sqrt2$ is an orthonormal basis of $\mathfrak{su}(2)_+$, and expanding $[v_1,v_2]$ from $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ gives $[v_1,v_2]=-\sqrt2\,v_3$, so $c^2=2$ on that factor. Calibrating $\#$ against $I^\#=(n-2)I$ ([BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.1) fixes $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\beta\gamma}c_{\alpha\beta\gamma}^2\lambda_\beta\lambda_\gamma$, which at $n=4$ reproduces the record's $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)=4$ from my own brackets. Then

$$W^\#=\big(2\lambda_2\lambda_3,\,2\lambda_1\lambda_3,\,2\lambda_1\lambda_2\big)=\big(-\tfrac23,-\tfrac23,\tfrac13\big),\qquad W^2=\big(\tfrac16,\tfrac16,\tfrac46\big),$$
$$Q(W)=\big(-\tfrac12,-\tfrac12,1\big)=\tfrac{\sqrt6}2\cdot\frac{(-1,-1,2)}{\sqrt6}=\sqrt{\tfrac32}\,W .$$

So $\lVert W\rVert^2=\tfrac{1+1+4}6=1$, $Q(W)=\sqrt{3/2}\,W$, $\theta=\langle W,Q(W)\rangle=\sqrt{3/2}$. **The witness is critical, not merely of the right value.**

**Padding.** $\mathfrak{so}(4)\subset\mathfrak{so}(n)$ is a subalgebra, so $c_{\alpha\beta\gamma}=0$ whenever $\beta,\gamma\in\Lambda^2\mathbb R^4$ and $\alpha\notin$; hence $\#$ sees nothing outside the block and $(W_{\mathrm{pad}})^\#=(W^\#)_{\mathrm{pad}}$. The norm is unchanged, so $\theta=\sqrt{3/2}$ and $Q(W_{\mathrm{pad}})=\sqrt{3/2}\,W_{\mathrm{pad}}$ **at every $n\ge4$**. Ricci-flatness padding trivially, since $\mathrm{Ric}_{ij}=\sum_kW_{ikjk}$ vanishes on the block by Weyl-ness in dimension $4$ and componentwise off it. This matches [conventions.md](../findings/conventions.md)'s *"padding commutes with $Q$, and preserves both the norm and $\theta$"*, reached here independently of it.

**Consequence for the ledger.** [LEDGER.md:539](../findings/LEDGER.md#L539) still reads *"One item is referred and unrun … [Lemma L44](../findings/problem.md) may [depend on it], since it uses that point as a critical witness"*, while the same file six lines below closes the item analytically and [problem.md:149](../findings/problem.md#L149) item 4 has already been corrected to *"an idempotent at every $n\ge4$"*. The referral is stale twice over. **And L44 never needed it**: the argument uses only $\theta(W_{\mathrm{pad}})=\sqrt{3/2}$ and membership of $\partial\Omega_0$, and criticality of the witness is nowhere consumed. [r506](REVIEW_r506.md)'s *"L44 uses the padded point as a critical witness"* overstates the dependency; [results.md:282](../results.md#L282) inherits the overstatement by opening *"Zero-padded $W_{\mathbb{CP}^2}$ is a critical point"* where the criterion asks only for its value.

**"lies on $\partial\Omega_0$", REFUTED as written.** A Weyl tensor has $\mathrm{ric}=0$, so $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ is undefined at it and $W\notin\mathrm{scal}^+$, on which $F$ and $\Omega_a$ are defined at all. The record's own [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) say it outright: *"A Weyl tensor has $\mathrm{ric}=0$, which is where $F$ blows up: Weyl tensors are the extremal directions of the cone family."* And [Lemma L43](../results.md#L274) says the same from the other end, at $c=0$ the boundary forces $\lVert W\rVert=0$. The object on $\partial\Omega_0$ is $R=cI+W$ with $c=\tfrac1n\sqrt{2(n-2)/(n-1)}>0$, which does satisfy $\mathrm{scal}>0$ and $F=\tfrac4{n-2}$. **The error is in three places**, [problem.md:200](../findings/problem.md#L200), [problem.md:66](../findings/problem.md#L66) and [05-landscape.tex:73](../report/sections/05-landscape.tex#L73), and **[results.md:282](../results.md#L282) has it right**: *"the curvature operator $cI+W$ it defines lies on $\partial\Omega_0$"*. The canonical block should take that sentence.

## 5. The block does not cite the lemma it runs on, DEFECT

The step *"the invariance criterion fails there exactly when $\theta_0(n)<\sqrt{3/2}$"* is the whole of L44, and it is available only through [Lemma L43](../results.md#L274)'s collapse of the criterion to $\theta\le\theta_0(n)$. The block names Beitz, Xu and Huisken and **never names L43**. [results.md:282](../results.md#L282) does cite it; the block headed *canonical statement and proof* does not. Two sentences and a $\square$ that lean on an uncited neighbour is the pattern [r477](REVIEW_r477.md) flagged for L18 in the same file.

## 6. Attribution, CONFIRMED verbatim

Checked against the stored full texts rather than the notes, since the notes are silent on the Xu equation numbers.

| claim | verified |
| --- | --- |
| Beitz (6.24) defines $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ on $\mathrm{scal}^+$ | [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) line 5501 |
| Beitz (6.25) gives $dF_R(S)$ | line 5521 |
| Beitz Lemma 6.3.16 opens on $G:R\mapsto dF_R(\Phi(R))$ | line 5631 |
| Beitz Remark 6.3.15 states the conjecture with $n\ge12$, $a\in[0,\tfrac n4]$ | line 5626 |
| Beitz $\Omega_a=F^{-1}((-\infty,\tfrac4{n-2+4a}])$ | line 5512, stated there for $a>0$ |
| Xu (3.1)–(3.4): $dF_R(S)$, $dF_R(Q(R))$, the criterion on $\partial\Omega(a)$, the expansion | [xu-2412.13633.txt](https://arxiv.org/abs/2412.13633) lines 817, 823, 829, 834 |
| Xu calls it "the main task" | line 832, verbatim |
| Xu Lemma 2.8 = (2.34), the five-term expansion, credited to Huisken's proof of his Theorem 3.3 | lines 516–523 |

Two notes. Xu's $\partial\Omega(a)$ is the level set $F^{-1}(\tfrac1{n-2+4a})$ against Beitz's $\tfrac4{n-2+4a}$, the factor $4$ from Xu's $\mathrm{Ric}$ being twice Beitz's $\mathrm{ric}$, which [problem.md:98](../findings/problem.md#L98) already records and which does not touch L44. And the [Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) do not carry (3.1)–(3.4) at all, so a reader following the record's own "read the notes first" rule cannot check this citation without the PDF; one row in that file would fix it.

## 7. "The witness … [is] new here", REFUTED, and already withdrawn twice

[problem.md:202](../findings/problem.md#L202) closes *"The witness and the conclusion drawn from it are new here."* The same file at [problem.md:66](../findings/problem.md#L66) says the opposite (*"notes the witness is Nienhaus's rather than new here"*) and [05-landscape.tex:77](../report/sections/05-landscape.tex#L77) agrees, *"the witness is Nienhaus's"*, with [problem.md:233](../findings/problem.md#L233) identifying it as Nienhaus arXiv:2311.02404 p. 33. The conclusion may stand as the record's own; the witness does not. **Strike the four words.**

## 8. Agreement with Lemma L2, CONFIRMED

Both reduce to $\theta_0(n)^2-\tfrac32=\tfrac{n^2-12n+8}{2n^2}$, root $6+2\sqrt7$, numerator $-3$ at $n=11$ and $+8$ at $n=12$. I get the same by the independent route of §1, which reaches $\theta_0(n)$ from the cone constraint with no sphere product in it, and the same $\sqrt{3/2}$ from the brackets in §4. L2 also already carries the parity companion $n^2-13n+18$ with root $\tfrac{13+\sqrt{97}}2=11.4244$ and the observation that the integer threshold survives at both parities, which is precisely what §1 says L44 does not need. **The two agree and L2 supplies the parity-correct form.**

## Quantifier and exceptional cases

$\dim\mathcal W_n=\tfrac{n(n-3)(n+1)(n+2)}{12}$ vanishes for $n\le3$, so there is nothing to pad and no witness; $\Omega_a$ itself is posed for $n\ge4$. The block's range $4\le n\le11$ is therefore the full set of dimensions at which the statement has content, and $n=4$ is included legitimately, the witness is native there rather than padded. **No exceptional case is missing.**

## Repairs owed

1. **[problem.md:200](../findings/problem.md#L200)**, replace *"the zero-padded $W_{\mathbb{CP}^2}$ … lies on $\partial\Omega_0$"* with [results.md:282](../results.md#L282)'s *"the curvature operator $cI+W$ it defines lies on $\partial\Omega_0$"*. Same at [problem.md:66](../findings/problem.md#L66) and [05-landscape.tex:73](../report/sections/05-landscape.tex#L73).
2. **[problem.md:200](../findings/problem.md#L200)**, cite [Lemma L43](../results.md#L274) for the collapse, and name the necessity direction of the criterion as the block's own step, since Beitz and Xu supply only the converse.
3. **[problem.md:202](../findings/problem.md#L202)**, strike *"The witness … [is] new here"*; it is Nienhaus's, per [problem.md:66](../findings/problem.md#L66).
4. **[problem.md:194](../findings/problem.md#L194)**, carry [results.md:282](../results.md#L282)'s closing guard, *"It says nothing about whether the cone is invariant at $n\ge12$"*, into the canonical block.
5. **[LEDGER.md:539](../findings/LEDGER.md#L539)**, the referral is discharged six lines below in the same file and at [problem.md:149](../findings/problem.md#L149); and L44 consumes only the witness's *value*, so the "may depend on it" clause is wrong in both halves.
6. **[conventions.md](../findings/conventions.md)**, say in the $\theta_0(n)$ row that at odd $n$ it is the formula, unattained, since that is what L43 produces and what L44 compares against.
7. **[INDEX-results.md:59](../findings/INDEX-results.md#L59)**, the title is malformed, *"$n\ge12$ is necessary, not merely sufficient) · (D"*, with unbalanced brackets carried in from the heading.
8. **[Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md)**, add (3.1)–(3.4) so the citation is checkable from the notes.

## Method and scope

Everything above is by hand. The three loads, the cone constraint giving $c$, the criterion collapsing to $c(n-1)=\theta_0(n)$, and $Q(W_{\mathbb{CP}^2})=\sqrt{3/2}\,W$, were rebuilt from Beitz's cone definition and from $\mathfrak{so}(4)$ brackets respectively, sharing no step with the block, which quotes both. **No computation was run.** The one arithmetic aside in §1 is labelled a screen and is not offered as evidence for anything positive. Not audited here: L43 itself beyond the collapse I reproduced, and Beitz's Lemma 2.3.4 beyond its direction.
