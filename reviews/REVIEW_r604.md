# REVIEW r604, Lemma L63, the $n=12$ block table

Reviewer r604, independent adversarial audit, cold from the definitions in [conventions.md](../findings/conventions.md). Target: `Lemma L63, the $n=12$ block table`, [sym3-stability.md:44](../findings/sym3-stability.md#L44), together with [*"The argument"*](../findings/sym3-stability.md#L7) and [*"Separating the $71$ $O(12)$ blocks"*](../findings/sym3-stability.md#L56).

**Analysis only.** Nothing was recomputed. The one machine act was a screen: three closed-form evaluations (Weyl's dimension formula for $D_6$ at $(2,2,0,0,0,0)$, $\binom{1640}3$, and $p_{12}(\rho)$), on objects built for that purpose. No plethysm, no decomposition, no sweep. The screen is reported as a screen.

## Verdict

**GAP.** *The counts are right as far as any hand check can reach, and every internal identity among them holds. What fails is the label and the pointer: `Lemma` is carried on a machine census, and the block's provenance note sends the reader to a section that proves a different theorem.*

| # | finding | verdict |
| --- | --- | --- |
| D1 | The provenance pointer is false: *"The argument"* proves stability, not the block table | **REFUTED** (the pointer) |
| D2 | $77/191/71/184$ rest on a decomposition run, so the label is `Observation` at $n=12$ | **CONFIRMED** |
| D3 | The number sits on the wrong statement, the file's *proved* theorem is unnumbered | **CONFIRMED** |
| D4 | $\dim\mathcal W_{12}=1638$ and the weight $(2,2,0,0,0,0)$ | **CONFIRMED**, derivable, re-derived two ways |
| D5 | Every internal identity among the counts holds, and $2,1,1,1,1,1$ is *forced* | **CONFIRMED** |
| D6 | The $\mathrm{Pf}^2$ correction is right, and independent of the other five | **CONFIRMED**, re-derived cold |
| D7 | [sym3-stability.md:34](../findings/sym3-stability.md#L34) asserts $10=n$ where $n=4$ | **REFUTED** (as printed) |
| D8 | The multiplicity list and the label list are in opposite orders across two lines | hazard, not an error |
| D9 | All pointers resolve, [fence-posts.md](../findings/fence-posts.md) F32/L64, the script, r177/r178/r179/r224/r225 | **CONFIRMED** |

---

## 1. The pointer, where the argument actually lives

The block's note reads: *"the mathematics has always been in this file … **the argument is in this file under "The argument"**"*.

**That section does not prove the block's statement.** Read end to end, [*"The argument"*](../findings/sym3-stability.md#L7) has four steps and they establish exactly one thing: **that the $O(n)$ table is the same for every $n\ge12$, and that $12$ is the threshold.** Step 1 bounds the row count by Newell–Littlewood; step 2 states the $O(n)$ labelling condition $\lambda'_1+\lambda'_2\le n$; step 3 takes $\max(\lambda'_1+\lambda'_2)=12$ **over the constituents**, that is, it *reads* the census rather than producing it; step 4 is Koike–Terada, carrying stability of the label set to stability of the multiplicities.

Nowhere in those eleven lines do the numbers $1638$, $77$, $191$, $71$ or $184$ appear, and nor does the weight $(2,2,0,0,0,0)$. The block's five assertions are five things that section never states.

**Where they actually live.**

| claim | actually established at |
| --- | --- |
| $\dim\mathcal W_{12}=1638$ | [conventions.md](../findings/conventions.md)'s object table, as the closed form $n(n-3)(n+1)(n+2)/12$ |
| highest weight $(2,2,0,0,0,0)$ | *"The argument"* step 1, in the $O(n)$ form "$(2,2)$"; the $D_6$ padding is nowhere stated |
| $77$ constituents, $191$ multiplicities | [*"Verification"*](../findings/sym3-stability.md#L23), a machine census, plus two reviewer routes |
| six chiral pairs at $2,1,1,1,1,1$ | [*"Separating the $71$ blocks"*](../findings/sym3-stability.md#L63), from reviewer 177's list |
| $71$ blocks, $184$ multiplicities | the same census, fused; the fusion *rule* is standard and derivable, the *inputs* are not |

**Git archaeology.** The block was created by commit `86621751` `docs(findings): number the 24 results that only the report had numbered` (2026-08-31), whose note read *"the argument is the surrounding material in this file"*, vague but true. Twenty-eight minutes later commit `bbfa159b` `docs(findings): the 24 numbered-from-the-report blocks name their proof` narrowed it to *"under 'The argument'"*, and its own commit body says the sections were *"located by searching each lemma's own distinctive content rather than by title similarity"*. **On this block the search matched the title, not the content**: the block is called "the $n=12$ block table" and the section is called "The argument", and the content the block asserts is in *"Verification"* two sections further down. The narrowing turned a vague-but-true note into a precise-and-false one.

**The first clause of the note fares better than the note's own precedent suggests.** The file was created 2026-08-30 by commit `8e88af4b`, and `git show 8e88af4b:findings/sym3-stability.md` already carries $77/191$ at its line 30 and $71/184$ at its line 5. So *"the mathematics has always been in this file"* is true of the counts (the file is one day older than the numbering) and false of $\dim\mathcal W_{12}=1638$ and the $D_6$ weight, which entered the file only with the block itself. **Half true, and the false half is the half a reader would check first.**

**L64's pointer resolves.** [fence-posts.md:227](../findings/fence-posts.md#L227) carries `#### Lemma L64, the transfer mechanism` under [post F32](../findings/fence-posts.md#L215). Not audited here.

## 2. What is derivable, and what is a machine census

### Derivable, and re-derived here

**$\dim\mathcal W_{12}=1638$.** Two independent routes agree.

- The record's closed form: $\tfrac{12\cdot9\cdot13\cdot14}{12}=9\cdot13\cdot14=1638$.
- Weyl's dimension formula for $D_6$ at $\lambda=(2,2,0,0,0,0)$. With $\rho=(5,4,3,2,1,0)$ and $\ell=\lambda+\rho=(7,6,3,2,1,0)$, the positive roots being $e_i\pm e_j$,
  $$\dim=\prod_{i<j}\frac{(\ell_i-\ell_j)(\ell_i+\ell_j)}{(\rho_i-\rho_j)(\rho_i+\rho_j)}=1638 .$$
  *Screen: evaluated exactly over $\mathbb Q$; the two routes were not fitted to each other.*

So the two do **not** disagree, and the weight label is right: $(2,2)$ as an $O(12)$ partition pads to the $D_6$ dominant weight $(2,2,0,0,0,0)$, and $\ell(\lambda)=2<6$ means it restricts irreducibly to $SO(12)$, so the same label serves both groups.

**$\binom{1640}3=733\,813\,080$**, and $1640=\dim\mathcal W_{12}+2$, so $\binom{1640}3=\dim\mathrm{Sym}^3(\mathcal W_{12})$. Both confirmed by screen.

**The row bound $\ell(\lambda)\le6$ is genuinely proved**, and step 1 is sound. $NL_{\lambda\mu}^\nu=\sum_{\alpha\beta\gamma}c^\lambda_{\alpha\beta}c^\mu_{\alpha\gamma}c^\nu_{\beta\gamma}$, so every $\nu$ arises from $c^\nu_{\beta\gamma}$ with $\beta\subseteq\lambda$, $\gamma\subseteq\mu$, giving $\ell(\nu)\le\ell(\beta)+\ell(\gamma)\le\ell(\lambda)+\ell(\mu)$. Three factors of $(2,2)$ then give $\ell\le6$.

**Step 3's "maximum is $12$" is stronger than the file makes it look, and needs no census.** From $\ell(\lambda)\le6$ we get $\lambda'_1\le6$ and $\lambda'_2\le\lambda'_1\le6$, hence $\lambda'_1+\lambda'_2\le12$ *automatically*. Attainment is also forced without a census: $\lambda'_2=6$ means six parts of size $\ge2$, so $|\lambda|\ge12$; and $|\lambda|\le12$ since $\mathrm{Sym}^3$ of a degree-4 tensor has degree $12$ and contractions only lower it. Hence $\lambda=(2,2,2,2,2,2)$ is the unique attaining label. **This is the one place the file says "over the constituents" and did not need to**, the derivation is two lines and the file should carry it, because as printed step 3 makes the stability theorem look like it consumes the census it is meant to be independent of.

### A machine census

**$77$, $191$, and hence $71$, $184$.** These are the output of a decomposition run. [run_n12_stability.py](../scripts/runs/run_n12_stability.py) does not compute them: it opens `scripts/runs/n12_sym3_blocks.pkl` and asserts

```
assert len(MULT) == 77 and sum(MULT.values()) == 191
```

The pickle is produced by [run_n12_sym3.py](../scripts/runs/run_n12_sym3.py). So the named script *checks the table's shape against steps 1 and 3*, which is what its docstring says it does; the table itself is upstream.

**The corroboration is strong and is not a proof.** [scripts/reviewers/r224/out_dimcheck.txt](../scripts/reviewers/r224/out_dimcheck.txt) records $\sum m_\lambda d_\lambda=\binom{\dim\mathcal W_n+2}3$ matching at $n=12,13,14,16,18$ and *firing* at $n=10$ unless King's rule is applied. I spot-checked two of its rows by hand: $\dim\mathcal W_{13}=2275$ gives $\binom{2277}3=1\,965\,013\,050$ ✓; $\dim\mathcal W_{14}=3080$ gives $\binom{3082}3=4\,874\,429\,560$ ✓. That is a genuinely sharp screen (it is sensitive to any multiplicity drift and it fires where it should), **but it is one linear equation on the table, and one equation does not determine $77$ labels.**

**Consequence for the label.** [INDEX-results.md](../findings/INDEX-results.md) row 63 already reads *"Gate 2: no verdict on the record"*, and the record's rule is literal: *"**Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** is verified numerically at the dimensions stated."* **The counts are correct and the label is wrong.** L63 is an `Observation` at $n=12$. The precedent is exact, [L5](../findings/graded-half.md) was downgraded on the same grounds four days ago, and [L22](../findings/route-a.md) two days ago on "a result inherits the status of its weakest input".

### And the number is on the wrong statement

**This is the finding I would fix first.** `#### Lemma L63` is the **only** numbered block in [sym3-stability.md](../findings/sym3-stability.md), and it carries the census. The file's title, its *"What is claimed"*, its four-step argument, its three-mechanism $n=10$ analysis and its scope section are all one theorem (*the block table is stable from $n=12$, and $12$ is the threshold*) and that theorem **has no number anywhere on the record**. So the file's proved content is unnumbered and its unproved content wears the `Lemma`.

**What is owed, and it is reachable.** Split the block. `Lemma L63` becomes the stability theorem, whose proof genuinely is *"The argument"* and which the pointer would then name correctly; the $n=12$ counts become an `Observation` at $n=12$ with the census named, its script and pickle cited, and r224's dimension identity carried as the corroboration it is. Nothing new has to be proved for that split, the material is already in the file, just filed against the wrong heading.

## 3. Internal consistency, every identity holds

Working from the reported numbers alone, with no recomputation.

**Constituents.** An $O(12)$ label with $\ell(\lambda)\le5$ restricts irreducibly to $SO(12)$; one with $\ell(\lambda)=6$ is self-associate (the associate of a $6$-row label at $n=12$ has first column $12-6=6$, so $\lambda^*=\lambda$) and restricts as $\lambda_+\oplus\lambda_-$ with $\lambda_6\mapsto\pm\lambda_6$. Writing $b$ for the $\le5$-row blocks and $6$ for the chiral ones,
$$77=b+2\cdot6\ \Rightarrow\ b=65,\qquad 71=b+6=65+6\ \checkmark$$
and $77-6=71$ ✓. **The "$65+\dots$" figure at [line 63](../findings/sym3-stability.md#L63) reconciles exactly**: $65+2\cdot6=77$ and $65+6=71$, $65$ being the non-chiral constituent count. *(It is unrelated to the $65$ invariant symmetric forms of [Lemma L59](../findings/sym3-blocks.md), which is an $n=5$ object. A coincidence of integers, worth a word in the file so a later reader does not fuse them.)*

**Multiplicities.** The orientation-reversing element of $O(12)$ acts on $\mathrm{Sym}^3(\mathcal W_{12})$ and permutes $SO(12)$ isotypic components by $\lambda\leftrightarrow\lambda^*$, so **$\lambda_+$ and $\lambda_-$ carry equal multiplicity**, this is forced, not observed. Hence with $s$ the sum of the six pair multiplicities,
$$191=(184-s)+2s\ \Rightarrow\ s=7,\qquad 191-7=184\ \checkmark$$

**And $2,1,1,1,1,1$ is *forced*, not an extra datum.** $s=7$ distributed over six pairs each of multiplicity $\ge1$ has exactly one solution as a multiset: $\{2,1,1,1,1,1\}$. So the block's multiplicity list is a consequence of $191$ and $184$, and cannot be an independent transcription error. **Given $(77,191)$ and "six chiral pairs", every other number in the block is determined.** The irreducible census inputs are two.

**The six labels are legal and consistently degreed.** Taking absolute values, $(2,2,2,2,2,2)$, $(3,3,2,2,1,1)$, $(4,4,1,1,1,1)$, $(3,2,2,1,1,1)$, $(4,2,1,1,1,1)$, $(2,2,1,1,1,1)$ have $|\lambda|=12,12,12,10,10,8$, all even and all $\le12$, as $\mathrm{Sym}^3$ of a degree-$4$ tensor with even-order contractions requires. All six have exactly six rows with $\lambda_6\ge1$, as chirality requires. Column sums $\lambda'_1+\lambda'_2$ are $12,10,8,9,8,8$, all $\le12$ ✓, with the maximum at $(2,2,2,2,2,2)$ as step 3 says.

**The one worked corroboration of the boundary is right and misprinted.** [Line 34](../findings/sym3-stability.md#L34) pins the labelling condition on $\mathcal W_n=[2,2]$ itself, where $\lambda'_1+\lambda'_2=4$: at $n=3$ that is $n+1$ and $\dim\mathcal W_3=\tfrac{3\cdot0\cdot4\cdot5}{12}=0$ ✓; at $n=4$ it is $n$ and $\dim\mathcal W_4=\tfrac{4\cdot1\cdot5\cdot6}{12}=10$ ✓. The check is sound and pretty. **But it is printed as "$\dim\mathcal W_4=10=n$", which asserts $n=10$ where $n=4$**, $10$ is the dimension and $4$ is the column sum. Two distinct quantities chained by one equals sign. Fix to *"$\dim\mathcal W_4=10\ne0$ at $\lambda'_1+\lambda'_2=n$"*.

**One presentational hazard.** [Line 48](../findings/sym3-stability.md#L48) gives the multiplicities as "$2,1,1,1,1,1$" with no labels attached; [line 63](../findings/sym3-stability.md#L63) gives the labels with the multiplicity-$2$ one **last**. A reader aligning the two lists positionally assigns multiplicity $2$ to $(2,2,2,2,2,\pm2)$, which contradicts step 3's *"attained at $(2,2,2,2,2,2)$ … with multiplicity $1$"*. No claim is actually wrong (line 48 states a multiset) but the two orders should be made to agree, or line 48 should name the label carrying the $2$.

## 4. The separation claim, re-derived cold

I did not read reviewer 178's reasoning before doing this; the derivation below is independent and agrees with the corrected statement.

**Setup.** $O(12)$-isotypic blocks are separated by the joint spectrum of central elements of $U(\mathfrak{so}(12))$ that survive conjugation by an orientation-reversing element. Under Harish-Chandra the centre of $U(\mathfrak{so}(12))$ is $\mathbb Q[\ell]^{W(D_6)}$ in $\ell=\lambda+\rho$; the extra $O(12)/SO(12)$ element acts on the Cartan by $\ell_6\mapsto-\ell_6$, so the $O(12)$-relevant ring is $\mathbb Q[\ell]^{W(B_6)}$.

**Reviewer 178's count is right.** $p_2,p_4,p_6,p_8,p_{10}$ in $\ell$ are $p_1,\dots,p_5$ in $y_i=\ell_i^2$. Newton's identities in characteristic $0$ convert $p_1,\dots,p_k$ into $e_1,\dots,e_k$ and no further, so five power sums fix $e_1,\dots,e_5$ of a **six**-element multiset and leave a one-parameter family. **The old "five Casimirs" claim was therefore not merely weak but false as a separation statement.**

**The correction is right.** Adjoining $p_{12}=p_6(y)$ closes it: Newton gives $p_6=e_1p_5-e_2p_4+e_3p_3-e_4p_2+e_5p_1-6e_6$, so $\mathbb Q[p_1,\dots,p_6](y)=\mathbb Q[e_1,\dots,e_6](y)$, and the multiset $\{\ell_i^2\}$ is recovered outright.

**And $\mathrm{Pf}^2$ genuinely is a legitimate sixth, genuinely independent.** $\mathrm{Pf}=\prod_i\ell_i$ is the Harish-Chandra image of the Pfaffian element of $Z(U(\mathfrak{so}(12)))$, and $\mathrm{Pf}^2=\prod_i\ell_i^2=e_6(\ell^2)$. Since $e_1,\dots,e_6$ are algebraically independent and $e_1,\dots,e_5$ are already in $\mathbb Q[p_2,\dots,p_{10}]$, **$e_6$ is transcendental over that ring**, so $\mathrm{Pf}^2$ is independent of the other five. By the Newton relation above, $\mathbb Q[p_2,\dots,p_{10}][p_{12}]=\mathbb Q[p_2,\dots,p_{10}][\mathrm{Pf}^2]$, the file's *"generate the same extension"* is exactly right, and its refusal to say they are *equal* is right too. **Screen, confirming reviewer 179's witness**: at $\ell=\rho=(5,4,3,2,1,0)$, $\mathrm{Pf}^2=0$ while $p_{12}=5^{12}+4^{12}+3^{12}+2^{12}+1=261\,453\,379$, the file's figure, reproduced.

**$\mathrm{Pf}$ must be excluded, and excluding it costs nothing.** $\mathrm{Pf}$ is odd under $\ell_6\mapsto-\ell_6$, so it is central in $U(\mathfrak{so}(12))$ but not $O(12)$-invariant, and it separates $\lambda_+$ from $\lambda_-$, it would split the six blocks the record needs fused. $\mathrm{Pf}^2$ is even, hence $O(12)$-invariant, and is blind to exactly that sign. **This is the whole content of the section and it is correct.**

**Injectivity, done properly.** From $\{\ell_i^2\}$ one recovers $|\ell|$ sorted. Dominance gives $\lambda_1\ge\dots\ge\lambda_5\ge|\lambda_6|$ and $\rho$ is strictly decreasing, so $\ell_1>\ell_2>\dots>\ell_5>|\ell_6|\ge0$ (strict, hence the sort is unambiguous) and $\rho_6=0$ gives $\ell_6=\lambda_6$ exactly. So $\lambda_1,\dots,\lambda_5$ and $|\lambda_6|$ are recovered and only $\mathop{\mathrm{sgn}}\lambda_6$ is lost. **That is precisely the chirality, so the six invariants separate the $71$ $O(12)$ blocks and no more.** The file's stated hypothesis (every constituent has at most six rows, so no $\det$-twist of a $\lambda_6=0$ label is in play), **is necessary and is discharged** by the row bound of §2 above.

**"Separate points" versus "generate the ring": both hold, and only the first is needed.** A separation argument needs injectivity of $\lambda\mapsto(p_2,\dots,p_{12})(\lambda+\rho)$ on the $71$ labels, which is what the paragraph above proves; simultaneous diagonalisation of the six commuting operators then splits $\mathrm{Sym}^3$ into exactly $71$ joint eigenspaces. The stronger reading also happens to be true here, by Chevalley: $W(B_6)$ has basic degrees $2,4,6,8,10,12$, so $p_2,\dots,p_{12}$ generate the full invariant ring. **The file's degree bookkeeping is correct**, including the $D_6$ coincidence it states without comment, the $W(D_6)$ degrees are $\{2,4,6,6,8,10\}$, with $6$ appearing both as $2m-2\cdot3$ in the $e(y)$ series and as the Pfaffian's degree $m=6$. **So the ambiguity the brief flags does not bite: both readings are true, and the one the argument uses is established.** The file would still read better if it said which it means.

## 5. Stability, what L63 claims about $n>12$

**L63 as written is about $n=12$ alone.** Every number in it ($1638$, $D_6$, $77$, $191$, $71$, $184$, $\binom{1640}3$), is an $n=12$ quantity, and the block contains no quantifier over $n$.

**What carries the $O(12)$ half upward is the file's unnumbered theorem, not L63.** [Line 5](../findings/sym3-stability.md#L5) states $71/184/477$ for every $n\ge12$, and *"The argument"* proves it. So the record's stable-range claim is real and proved, and it is **not** what the `Lemma L63` label is attached to. This is the same defect as D3 seen from the other side.

**The scope section is honest and should be preserved through any relabelling.** *"It fixes the **shape** … it does not make the constraint data $n$-independent … a certificate built at $n=12$ settles Conjecture A at $n=12$. Transferring it upward is a separate question, and the programme has no route to it."* That is the correct reading and it contradicts [run_n12_stability.py](../scripts/runs/run_n12_stability.py)'s opening docstring, which still says the stability claim *"turns the SOS route from a result at ONE dimension into a proof of Conjecture A for every even $n\ge12$, the load-bearing step of the whole programme."* **The script's own later paragraph retracts this**, so the file is self-correcting; the opening paragraph is stale and overreaches where the findings file does not.

## 6. Hedges and pointers

**Hedging clauses, each checked.**

| clause | where | verdict |
| --- | --- | --- |
| *"has always been in this file"* | [L63 note](../findings/sym3-stability.md#L46) | **half false**, true of $77/191/71/184$, false of $1638$ and the $D_6$ weight (§1) |
| *"the argument is in this file under 'The argument'"* | same | **false** (§1) |
| *"under a hypothesis worth stating"* | [line 61](../findings/sym3-stability.md#L61) | **clean**, the hypothesis is named, and discharged by the row bound |
| *"would only give well-definedness"* | line 61 | **clean and correct**, injectivity is the right target and is proved |
| *"either $p_{12}$ or $\mathrm{Pf}^2$ may serve"* | [line 63](../findings/sym3-stability.md#L63) | **clean**, proved above by Newton |
| *"they are not equal"* | line 63 | **clean**, and the witness reproduces |
| *"no room for an off-by-one in either direction"* | [line 34](../findings/sym3-stability.md#L34) | **sound argument, misprinted** (D7) |
| *"zero mismatches"* | [line 30](../findings/sym3-stability.md#L30) | **census language**, it reports agreement between two runs, which is what §2 says it is |

**Every pointer resolves.** [fence-posts.md](../findings/fence-posts.md) F32 (line 215) and `Lemma L64` (line 227) both exist; [run_n12_stability.py](../scripts/runs/run_n12_stability.py) exists and its pickle is on disk; [REVIEW_r224.md](REVIEW_r224.md), [REVIEW_r225.md](REVIEW_r225.md), [REVIEW_r177.md](REVIEW_r177.md), [REVIEW_r178.md](REVIEW_r178.md), [REVIEW_r179.md](REVIEW_r179.md) all exist; [sym3-blocks.md](../findings/sym3-blocks.md), the re-filing source, exists. **No dead pointer in or around this block.**

**One cosmetic defect.** The block writes `\dim\Weyl_{12}`, and `\Weyl` is defined nowhere in [findings/](../findings/) (there is no macro file) so it renders as literal `\Weyl` in the record. Its own file uses $\mathcal W_n$ in every other line, and [conventions.md](../findings/conventions.md) tables the object as $\mathcal W_n$. Repo-wide the macro leaks into four files ([bispectral.md](../findings/bispectral.md), [sym3-blocks.md](../findings/sym3-blocks.md), [sym3-stability.md](../findings/sym3-stability.md), [target.md](../findings/target.md)), so it is not L63's alone, but the fix here is one substitution.

## 7. What would settle what remains

**Everything left open is one computation, and it is the one the standing rule forbids without approval.**

**The run.** Recompute the $SO(12)$ decomposition of $\mathrm{Sym}^3(V_{(2,2,0,0,0,0)})$ from scratch (a plethysm in the $D_6$ character ring, or a weight-multiplicity count), sharing no code with [run_n12_sym3.py](../scripts/runs/run_n12_sym3.py) and reading nothing from `n12_sym3_blocks.pkl`.

**What each outcome means.**

- **It returns $77$ labels totalling $191$**, with six six-row labels: L63's counts stand and the only defect is the label and the pointer. This is what §3 leads me to expect, the table already satisfies a sharp linear identity at five dimensions and fails it at $n=10$, and every internal identity among the reported numbers closes.
- **It returns a different table satisfying $\sum m_\lambda d_\lambda=\binom{1640}3$**: the census is wrong and the dimension identity was too weak to catch it, which would also retire that identity as this programme's standard check.
- **It fails the dimension identity**: the run is wrong, not the record.

**Note what the run would *not* touch.** $\dim\mathcal W_{12}=1638$, the weight, the fusion arithmetic $77-6=71$ and $191-7=184$, the forcing of $2,1,1,1,1,1$, and the whole $\mathrm{Pf}^2$ separation argument are settled above by hand and do not depend on it.

## 8. What I would change in the record

*Recorded as a proposal; this review edits nothing outside itself.*

1. **Split the block.** `Lemma L63` becomes *the block table is stable from $n\ge12$, and $12$ is the threshold*, the theorem the file actually proves, whose pointer to *"The argument"* would then be true.
2. **The $n=12$ counts become an `Observation` at $n=12$**, naming the census, its script and its pickle, with r224's dimension identity carried as corroboration. The index row already reads "Gate 2: no verdict on the record", so no label is being taken away that was earned.
3. **Paste the two-line derivation of step 3**, $\lambda'_1+\lambda'_2\le12$ follows from $\ell(\lambda)\le6$, and $(2,2,2,2,2,2)$ is forced by $|\lambda|\le12$, so the stability theorem visibly does not consume the census.
4. **Fix "$\dim\mathcal W_4=10=n$"**, align the two multiplicity orderings, and replace `\Weyl` with $\mathcal W$.
5. **Number the separation result or fold it into the block**; as it stands it is unnumbered material carrying a correction from three reviewers.

---

*Reviewer r604. Analysis only; the sole machine act was a three-line closed-form screen, reported as a screen. Working from [conventions.md](../findings/conventions.md), the block, and the two sections it points at, cold.*
