# Gate 2 adversarial review 181, the coset formula for $O(n)$ invariants, and the exact PSD verifier

Reviewer 181. Brief: claims 1–5 of the $n=5$ certificate pipeline and the $O(12)=89$ recovery, with claims 1 and 4 prioritised. Scripts under [scripts/reviewers/r181/](../scripts/reviewers/r181/), log at [agent_logs/gate2_181.log](../agent_logs/gate2_181.log).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | The coset formula for $O(n)$ invariants at even $n$; $O(12)$ degree 6 $=89$ | **Formula upheld**, re-derived from definitions. **Number upheld**, and now carried to $n=14$ and $n=16$. |
| 1b | The $n=8$ validation licenses the $n=12$ use | **Inadequate as a licence.** It is one scalar, at a lower rank and a lower degree, inside the already-stable regime. The number survives a much stronger battery built here. |
| 2 | The three structural facts behind the dictionary stage | Not examined, the brief directed effort to 1 and 4, and commit 6fb01f4 rewrote [run_n5_dictionary.py](../scripts/runs/run_n5_dictionary.py) mid-run. |
| 3 | The echelon fix in [run_n5_copies.py](../scripts/runs/run_n5_copies.py) | Not examined. |
| 4 | The exact PSD verifier is sound | **Refuted, with witnesses.** Independently confirmed reviewer 182's finding by a different oracle and a 15× larger census; the committed fix is clean over 400 000 random matrices. |
| 5 | $\langle v_i,v_j\rangle$ needs the copies | Settled by reviewer 182 during this run, in commit 6fb01f4 on [run_n5_dictionary.py](../scripts/runs/run_n5_dictionary.py). |

## Claim 4, the exact PSD verifier accepts indefinite matrices

Found independently, before seeing that reviewer 182 had filed the same defect; the two accounts agree on the mechanism and on the fix, and I record mine as confirmation rather than as a new finding.

**The witness.** $M=\begin{pmatrix}-1&0\\0&0\end{pmatrix}$ is reported PSD. So is $\begin{pmatrix}-1&2&0\\2&-1&0\\0&0&0\end{pmatrix}$, which is genuinely indefinite with eigenvalues $1$ and $-3$, and so is $\begin{pmatrix}1&1&0\\1&0&0\\0&0&0\end{pmatrix}$, whose input diagonal is non-negative and whose defect only appears in the Schur complement after one honest pivot.

**The mechanism.** At step $k$ the routine takes $p=\arg\max_{i\ge k}A_{ii}$ and returns `False` when $A_{pp}<0$. That test fires only at the maximum. When the maximum is $0$ and Python's `max` returns the first index attaining it, $p>k$ means $A_{kk}<0$, already a proof that the form is not PSD. The zero branch then checked only row $p$, appended a zero pivot and did `continue` **without swapping $p$ into slot $k$**. The next iteration scans `range(k+1, n)`, so index $k$ (the one carrying the negative diagonal), is dropped and never examined again. Repeating, the whole leading block $[k,p)$ is discarded silently whenever its diagonal is negative and some later row vanishes.

**Scope.** Every error is one-sided: a non-PSD matrix reported PSD, which is the dangerous direction for a certificate. Over 300 000 random rational symmetric matrices of order 2–5 with entries in $\{-2,\dots,2\}$, 7780 (2.59%) were misclassified, all false positives. The rank-deficient blocks an SDP Gram naturally produces are exactly the inputs that trigger it.

**Oracle.** The reference test shares no code with LDL: a rational symmetric $M$ is PSD iff every coefficient of $\det(xI+M)$ is non-negative, the coefficients coming from Faddeev–LeVerrier over $\mathbb{Q}$. No square roots, no floating point, no eigenvalues.

**The fix** (the same one now committed), replaces the row check with two block checks: reject if any remaining diagonal entry is negative, then reject if any entry of the remaining block is non-zero, and otherwise finish with zero pivots. Rerunning the committed [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py) against the oracle over 400 000 random matrices of order 2–6 gives 0 misclassifications, and the original self-test still passes.

Scripts: [psd_witness.py](../scripts/reviewers/r181/psd_witness.py), [psd_fix.py](../scripts/reviewers/r181/psd_fix.py).

## Claim 1, the coset formula, re-derived

### The derivation

Write $n=2r$, $m=r-1$, $G=O(n)$, $G^-$ the non-identity component with Haar measure normalised to total mass 1 on each component. For any representation,

$$\dim V^{O(n)}=\tfrac12\Big(\int_{SO(n)}\chi_V+\int_{G^-}\chi_V\Big),\qquad \dim\mathop{\mathrm{Hom}}_{O(n)}(V,\det)=\tfrac12\Big(\int_{SO(n)}\chi_V-\int_{G^-}\chi_V\Big),$$

since $\det=-1$ on $G^-$. That is the "(SO count + coset integral)/2" of the record.

**The coset torus.** A real orthogonal $g$ with $\det g=-1$ has eigenvalue $-1$ with odd multiplicity, hence $+1$ with odd multiplicity as well, so the generic element of $O(2r)^-$ is $SO(2r)$-conjugate to $\sigma t$ with $\sigma=\mathop{\mathrm{diag}}(I_{2r-2},1,-1)$ and $t$ in the maximal torus $T'$ of the $SO(2r-2)$ block. Its eigenvalues on $\mathbb{C}^{2r}$ are $t_1^{\pm1},\dots,t_m^{\pm1}$ together with $+1$ and $-1$.

**The density.** $\mathop{\mathrm{Ad}}$ acts on $\mathfrak{so}(2r)=\Lambda^2\mathbb{C}^{2r}$, so its eigenvalues at $\sigma t$ are the products of distinct pairs: $t^{\pm e_i\pm e_j}$ (the $D_m$ roots), $1$ with multiplicity $m$ (this is $\mathfrak{t}'$), $\pm t_i^{\pm1}$, and $-1$. Deleting the $\mathfrak{t}'$ part,

$$\det\big(1-\mathop{\mathrm{Ad}}(\sigma t)\big)\Big|_{\mathfrak g/\mathfrak t'}=2\prod_{\alpha\in D_m}(1-t^\alpha)\prod_{i=1}^m(1-t_i^2)(1-t_i^{-2})=2\prod_{\alpha\in C_m}(1-t^\alpha),$$

because $(1-t_i)(1+t_i)=1-t_i^2$, and $C_m$ is exactly $D_m$ together with the long roots $\pm2e_i$. This is the docstring's assertion, and it is right.

**The group.** $n=\mathop{\mathrm{diag}}(h,-1,1)$ with $h\in O(2r-2)$, $\det h=-1$, lies in $SO(2r)$, fixes $\sigma$, and normalises $T'$; letting $h$ range over the torus normaliser of $O(2r-2)$ realises the full signed-permutation group. So the twisted Weyl group is $W(B_m)=W(C_m)$, of order $2^mm!$.

**The normalisation.** Weyl's formula gives $\int_{T'}\prod_{\alpha\in C_m}(1-t^\alpha)\,dt=|W(C_m)|$, so requiring $\int_{G^-}1=1$ fixes

$$\int_{G^-}f=\frac{1}{|W(C_m)|}\int_{T'}f(\sigma t)\prod_{\alpha\in C_m}(1-t^\alpha)\,dt .$$

**The alternating sum.** $\chi_V$ restricted to $\sigma T'$ is a $W(C_m)$-invariant Laurent polynomial $F$, and $\prod_{\alpha\in C_m}(1-t^\alpha)=|\Delta_C|^2$ with $\Delta_C=\sum_w\det(w)\,t^{w\rho_C}$, so expanding both denominators and using invariance collapses the double sum to

$$\int_{G^-}\chi_V=\sum_{w\in W(C_m)}\det(w)\,F\big[\rho_C-w\rho_C\big],\qquad \rho_C=(m,m-1,\dots,1).$$

That is the coset integral as coded. As a hand check, the defining representation gives $0$ and $V\otimes V$ gives exactly $1$ by the alternating sum, matching $\dim(V\otimes V)^{O(n)}=1$ with no chiral part.

### The implementation

Everything below is exact integer arithmetic except the two character checks, which are float traces agreeing to $10^{-13}$.

| Test | What it pins down | Result |
|---|---|---|
| $\chi_{\mathcal W}$ on the coset torus against explicit matrices, $n=8$ and $n=12$ | the only $\mathcal W$-specific input, at the rank actually used | agrees, $\dim\mathcal W_{12}=1638$ recovered |
| $\chi_{\mathcal W}$ on the $SO$ torus against explicit matrices, $n=8$ and $n=12$ | the $SO$ half's character | agrees |
| $V$, $\mathop{\mathrm{Sym}}^2V$, $\Lambda^2V$ against their classical invariant rings, $n=4$ to $n=12$, degrees 1–6 | the whole coset pipeline at ranks $m=1{\dots}5$, both the untwisted and the twisted output | agrees everywhere |
| $\mathcal W_4$ against a closed-form Hilbert series, degrees 1–14 | the actual Weyl module, in the degree direction, far past degree 6 | agrees in $SO$, $O$ and twisted counts |
| brute full-character route against the dominant-weight recursion, $n=8$ and $n=10$ | the dominance folding and the truncation | identical |
| truncation bound widened from $4k$ to $6k$ at $n=12$ | the one place mass could be lost at higher rank | identical: $O$ still $89$, twisted still $3$ |
| negative controls: $\rho_B$ for $\rho_C$, $W(D_m)$ for $W(C_m)$, an identity-component element | that the battery has teeth | all three break the $\Lambda^2$ ground truth, two of them into non-integers |

Two of these deserve emphasis. The $\Lambda^2$ family is a theorem, $\mathbb{C}[\mathfrak{so}(2r)]^{O(2r)}$ is free on $\mathop{\mathrm{tr}}X^2,\dots,\mathop{\mathrm{tr}}X^{2r}$, so the count is the number of partitions into even parts at most $n$, while the $SO$ ring adds the Pfaffian, which is $\det$-odd. At $n=12$, degree 6, the machinery has to report $4$ $SO$-invariants splitting as $3$ untwisted and exactly $1$ twisted, and it does. That is the coset integral being tested for both magnitude and sign at exactly the rank in dispute. The $n=4$ family is a second theorem, $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ with $SO(4)$ acting as $SO(3)\times SO(3)$ and the reflection swapping the summands, giving Hilbert series $\tfrac12\big[(1-q^2)^{-2}(1-q^3)^{-2}\pm(1-q^4)^{-1}(1-q^6)^{-1}\big]$ for the untwisted and twisted parts. It matches in all 14 degrees.

The $4k$ truncation is also provable, not merely tested: every weight of $\mathcal W$ on either torus has $\ell_1$-norm at most $4$, since $\mathcal W\subset\mathop{\mathrm{Sym}}^2\Lambda^2V$ and every $\Lambda^2$ weight has $\ell_1$-norm at most $2$; lookups outside the stored range return zero, which is the correct value.

Scripts: [coset_char_matrix.py](../scripts/reviewers/r181/coset_char_matrix.py), [gt_families.py](../scripts/reviewers/r181/gt_families.py), [n4_weyl_gt.py](../scripts/reviewers/r181/n4_weyl_gt.py), [full_route.py](../scripts/reviewers/r181/full_route.py), [bound_stress.py](../scripts/reviewers/r181/bound_stress.py), [negative_control.py](../scripts/reviewers/r181/negative_control.py), [n16.py](../scripts/reviewers/r181/n16.py).

### The numbers, extended

Degree 6, computed here for every even $n$ from 4 to 16:

| $n$ | 4 | 6 | 8 | 10 | 12 | 14 | 16 |
|---|---|---|---|---|---|---|---|
| $SO(n)$ | 7 | 50 | 122 | 88 | **92** | 89 | 89 |
| coset | 1 | 40 | 42 | 88 | **86** | 89 | 89 |
| $O(n)$ | 4 | 45 | 82 | 88 | **89** | 89 | 89 |
| $\det$-twisted | 3 | 5 | 40 | 0 | **3** | 0 | 0 |

The $O(n)$ row is non-decreasing, as the first fundamental theorem requires: a Weyl tensor on $\mathbb{R}^n$ extended by zero is a Weyl tensor on $\mathbb{R}^{n'}$ for $n'>n$, so every linear relation among contraction schemes valid at $n'$ is valid at $n$, and the relation space can only shrink as $n$ grows. That monotonicity is a genuine independent constraint and it was used as a prediction: $SO(14)=89$ was computed first, and monotonicity then forces the $n=14$ coset integral to be exactly $89$ with no chiral part. The code produced $89$.

The $SO$ row is not monotone, and it should not be, it counts $\delta$-contractions together with $\epsilon$-contractions, and the $\epsilon$ ones die out as $n$ grows past $4k$. The twisted row inherits that, which is why it can read $40$ at $n=8$ and $0$ at $n=10$.

**One correction to the record.** $89$ is the $n=12$ value, and it happens to persist through $n=14$ and $n=16$, but the first fundamental theorem only guarantees stability for $n\ge 4k=24$. The persistence to $16$ is measured, not proved. A downstream statement of the form "the degree-six count is 89 for all $n\ge12$" is at present an observation over three dimensions, and should be written that way.

### Was the $n=8$ validation adequate?

No, not on its own. It is one scalar in a place chosen for convenience rather than for stress.

- **It sits at $(n,k)=(8,4)$ while the use is at $(12,6)$**, so both the rank ($m=3$ against $m=5$) and the degree are below the target. The degree-6 layer of the Newton recursion and the widest reach of the $4k$ truncation are never exercised.
- **Degree 4 is already stable at $n=8$.** The $O(n)$ degree-4 count reads $7$ at $n=8,10,12,14$ alike, so the check cannot detect any error whose size depends on $n$, which is precisely the error class an $n=8\to n=12$ extrapolation risks.
- **The coset contributes little there.** $O(8)=(9+5)/2=7$ tests the single coset value $5$; at $n=12$ the coset must deliver $86$ out of a total of $178$. A recipe wrong by a systematic factor or a missing term has far more room to land on $7$ by accident than on $86$.
- **The record's own wording blurs the degree.** [plan.md](../plan.md) line 283 reports the validation beside the degree-six claim in a way that reads as same-degree; line 297 makes clear it is degree four. At degree six the same code gives $O(8)=82$ from $SO(8)=122$ with $40$ chiral, and nothing checked that.

What does license the $n=12$ use is the battery above: the module-agnostic machinery is pinned by three classical invariant rings at ranks $m=1$ through $5$ including a non-zero twisted count at exactly $(m,k)=(5,6)$; the one $\mathcal W$-specific ingredient is pinned by explicit matrices at $n=12$ itself; the recursion's two shortcuts are pinned by a brute route at $n=8,10$ and by a widened bound at $n=12$; and the answer satisfies a monotonicity theorem that was turned into a successful prediction at $n=14$. The number $89$ stands.

## What I did not do

Claims 2, 3 and 5 went unexamined. The brief prioritised 1 and 4, and by the time claims 1 and 4 were closed commits 6fb01f4 and 6cec27b had rewritten [run_n5_dictionary.py](../scripts/runs/run_n5_dictionary.py) and [run_n5_copies.py](../scripts/runs/run_n5_copies.py), so any verdict I could file on the earlier text would describe code that no longer exists. Claim 2(c), whether "the same lowering words" is a well-defined equivariant identification, and what happens when a word annihilates one copy's vector, remains the sharpest open target in the brief and deserves a reviewer of its own.
