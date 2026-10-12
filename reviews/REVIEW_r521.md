# REVIEW r521, Lemma L37, "diagonality is decided by a single kernel"

**Target.** `findings/target.md`, `#### Lemma L37` (line 632) down to the next heading.

**Statement under audit.** For $W\in\mathcal W_n$ let $\delta_A(X)=AX+XA$ for symmetric $A$, and $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in some orthonormal frame iff some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$. In particular $\dim\ker\Phi_W<n$ certifies non-diagonality.

**Footing.** Analysis only. No searches, sweeps, censuses or falsifier hunts. Screening of a claim about to be recorded is permitted and is labelled as a screen.

**Phase plan.**
1. Setup (log + this file).
2. Conventions and indexes.
3. Read the L37 block verbatim.
4. The pointer: does the named section contain the argument?
5. Easy direction.
6. Hard direction (the content).
7. The threshold $n$; is the criterion vacuous?
8. Frame-independence.
9. The 8 citations.
10. Contradiction sweep in `findings/` and later sections of `target.md`.
11. Verdict.

VERDICT: **CONFIRMED**, the mathematics is correct in full; three record defects (false proof pointer, an overstated "well posed because" clause, one script mislabel) are named below.

## Findings

### F1, The pointer is FALSE. The named section contains no argument, only one application.

The block at [target.md:634](../findings/target.md#L634) says *"the argument is in this file under 'What survives, because it was verified directly rather than taken from'"*. That section exists at [target.md:383](../findings/target.md#L383) (full title: *"What survives, because it was verified directly rather than taken from the review"*). I read it in full. It is about the $(\mathfrak{su}(m),\mathfrak{so}(m))$ Kähler family and its closed form $\theta^2=X/(X-2)$. Its **only** contact with L37 is the four-word parenthesis "non-diagonal ($\dim\ker\Phi_W=1$)" on line 385, an *application* of the corollary, with neither direction of the equivalence stated, let alone proved.

**Where each direction is actually proved.**

| location | what it holds |
| --- | --- |
| [target.md:510](../findings/target.md#L510) (section *"What survives, and it is a real gain"*) | the **statement**, attributed to Reviewer 75, plus the implementation note that the dimension corollary alone is insufficient. No proof. |
| [target.md:474-486](../findings/target.md#L474) (post F22) | the definition of $\Phi_W$, and the measurement that it carries no information about $\theta$. No proof. |
| [target.md:458](../findings/target.md#L458) | the one-line fact $\delta_{\mathrm{Id}}(X)=2X$, so $\mathrm{Id}\in\ker\Phi_W$ always. A fragment of the threshold argument. |
| [results.md:470](../results.md#L470) | the statement plus **one clause of the easy direction**: "the diagonal matrices in any frame supply an $n$-dimensional subspace of $\ker\Phi_W$ when $W$ is diagonal there". |
| [report/sections/07-gradedness-split.tex:792](../report/sections/07-gradedness-split.tex#L792) | **the only place either direction is argued**, in three clauses: the $a_i+a_j$ are the eigenvalues of $\delta_A$ on $\Lambda^2$ with the coordinate $2$-planes as eigenspaces; commuting is $\Phi_W(A)=0$; "conversely a diagonalising frame produces such an $A$"; "the dimension certificate follows because a diagonal $W$ admits an $n$-parameter family of such $A$". |

So the argument is **not in `findings/target.md` at all**, it is in `report/`, and the block's pointer names a section that does not contain it. This is the same defect the brief flags on a sibling result. It is a **pointer defect, not a mathematical one**: the mathematics is correct, and I derive it below from the definitions.

### F2, $\delta_A$ acts on $\Lambda^2$ exactly the way the argument needs. Derived.

Identify $\Lambda^2\mathbb R^n$ with skew matrices, $u\wedge v\leftrightarrow uv^{\mathsf T}-vu^{\mathsf T}$, and $\varphi_{ij}=e_i\wedge e_j$ orthonormal for $i<j$ under the record's half-trace pairing ([conventions.md](../findings/conventions.md)).

1. **$\delta_A$ preserves $\Lambda^2$.** For $A$ symmetric and $X$ skew, $(AX+XA)^{\mathsf T}=X^{\mathsf T}A+AX^{\mathsf T}=-(AX+XA)$. So $\delta_A:\Lambda^2\to\Lambda^2$ is well defined.
2. **$\delta_A$ is the derivation extension of $A$.** $A(uv^{\mathsf T}-vu^{\mathsf T})+(uv^{\mathsf T}-vu^{\mathsf T})A=(Au)v^{\mathsf T}-v(Au)^{\mathsf T}+u(Av)^{\mathsf T}-(Av)u^{\mathsf T}$, using $A^{\mathsf T}=A$. Hence $\delta_A(u\wedge v)=Au\wedge v+u\wedge Av$.
3. **Spectrum.** Let $e_1,\dots,e_n$ be an orthonormal eigenbasis of $A$, $Ae_i=a_ie_i$. Then $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$. So the spectrum of $\delta_A$ on $\Lambda^2$ is exactly the multiset $\{a_i+a_j\}_{i<j}$, of the right cardinality $\binom n2=\dim\Lambda^2$, with the coordinate $2$-planes as eigenvectors.
4. **$\delta_A$ is symmetric on $\Lambda^2$**, so $\Phi_W(A)=[W,\delta_A]$ is a commutator of two symmetric operators; $\Phi_W$ is a linear map $\mathrm{Sym}^2(\mathbb R^n)\to\mathfrak{so}(\Lambda^2)$ and $\ker\Phi_W$ is a linear subspace of $\mathrm{Sym}^2(\mathbb R^n)$.
5. **$A\in\ker\Phi_W$ is literally $W\delta_A=\delta_AW$**, by the definition of $\Phi_W$. No reinterpretation is involved.

Step 3 is what the argument needs and it holds. ✓

### F3, Easy direction: CONFIRMED, and the distinctness is always achievable.

Suppose $W$ is diagonal in the orthonormal frame $f_1,\dots,f_n$, i.e. every $\varphi_{ij}=f_i\wedge f_j$ is an eigenvector of $W$, which is the record's meaning of "diagonal" ([conventions.md](../findings/conventions.md): diagonal in coordinate $2$-planes, *not* diagonal as an operator on $\Lambda^2$).

Take $A=\sum_i 2^i f_if_i^{\mathsf T}$. By uniqueness of binary representation the $\binom n2$ sums $2^i+2^j$, $i<j$, are pairwise distinct, so **the distinctness is achievable for every $n$, unconditionally**, it is not a genericity assumption that might fail. By F2.3, $\delta_A$ is diagonal in the basis $\{\varphi_{ij}\}$; $W$ is too; two operators diagonal in one basis commute; hence $[W,\delta_A]=0$, i.e. $A\in\ker\Phi_W$. ✓

**The "some" quantifier is load-bearing and the block gets it right.** A "for every $A\in\ker\Phi_W$" reading would be false at once: $\delta_{\mathrm{Id}}=2\,\mathrm{id}$, so $\mathrm{Id}\in\ker\Phi_W$ for *every* $W$, and $\mathrm{Id}$ has all $\binom n2$ sums equal to $2$. The block's sentence reads "some $A\in\ker\Phi_W$ has pairwise-distinct sums", which is the correct quantifier.

**Side note on decidability.** The set of $A\in\mathrm{Sym}^2$ with pairwise-distinct sums is the non-vanishing locus of $\mathrm{disc}(\chi_{\delta_A})$, a polynomial in the entries of $A$; so it is Zariski-open, and "some $A\in\ker\Phi_W$ has distinct sums" is equivalent to "the generic $A\in\ker\Phi_W$ does". The existential over a linear subspace is therefore decidable, which is what makes L37 a usable test rather than a search over $O(n)$.

### F4, Hard direction: CONFIRMED. The mechanism is exactly simple spectrum on $\Lambda^2$.

Let $A\in\ker\Phi_W$ have pairwise-distinct sums $a_i+a_j$, $i<j$.

1. **Distinct sums force distinct $a_i$** (for $n\ge3$; $\mathcal W_n=0$ below that): if $a_i=a_j$ with $i\ne j$, pick $k\notin\{i,j\}$, then $a_i+a_k=a_j+a_k$ are two equal sums at distinct index pairs. So $A$ has $n$ distinct eigenvalues and a **unique** orthonormal eigenframe up to signs and order.
2. **$\delta_A$ has simple spectrum on $\Lambda^2$** by F2.3, with one-dimensional eigenspaces $\mathbb R\varphi_{ij}$.
3. **$W$ commutes with $\delta_A$** (F2.5), so $W$ preserves each eigenspace of $\delta_A$; each is a line, so $W\varphi_{ij}=\lambda_{ij}\varphi_{ij}$.
4. Therefore $W$ is diagonal in $A$'s eigenframe, which is orthonormal because $A$ is symmetric. ✓

Every step is forced. The equivalence is correct as stated.

**One remark the record never makes and should:** nothing in F2–F4 uses $W\in\mathcal W_n$. L37 holds for *any* linear operator on $\Lambda^2\mathbb R^n$. Restricting the statement to $\mathcal W_n$ is harmless but hides that the criterion is pure linear algebra.

### F5, The threshold $n$: CONFIRMED, sharp, no hidden hypothesis, and non-vacuous with an analytic witness.

**The containment.** If $W$ is diagonal in the orthonormal frame $f_1,\dots,f_n$, then *every* $A$ diagonal in that frame lies in $\ker\Phi_W$, the argument of F3 used only that $\delta_A$ and $W$ are simultaneously diagonal in $\{\varphi_{ij}\}$, and that holds for any diagonal $A$, distinct sums or not. Those $A$ form an $n$-dimensional subspace of $\mathrm{Sym}^2(\mathbb R^n)$. Hence

$$W\text{ diagonal}\ \Longrightarrow\ \dim\ker\Phi_W\ge n,$$

whose contrapositive is the corollary. **No hypothesis is hidden**: the implication needs neither criticality, nor $\ker W=0$, nor $W\in\mathcal W_n$. "Outright" means "with no frame search", and that is what it delivers.

**$n$ is exactly the guaranteed dimension, and the threshold cannot be raised.** $\dim\ker\Phi_W=n$ does *not* imply diagonal. Analytic witness: let $V=\mathbb R^4\subseteq\mathbb R^n$, and let $W$ act as $W^+\oplus0$ on $\Lambda^2V=\Lambda^+\oplus\Lambda^-$ with $W^+$ traceless, symmetric and **invertible** on $\Lambda^+$ (e.g. eigenvalues $2,-1,-1$, which is $W_{\mathbb{CP}^2}$), and as $0$ on $\Lambda^2\mathbb R^n\ominus\Lambda^2V$.
- *$W$ is non-diagonal*: its nonzero-eigenvalue eigenvectors span $\Lambda^+$, and every nonzero $\omega\in\Lambda^+$ satisfies $\omega\wedge\omega=\lVert\omega\rVert^2\mathrm{vol}_V\ne0$, so $\omega$ has rank $4$ and is not decomposable. A diagonal $W$ has a basis of decomposable eigenvectors.
- *Yet the kernel is large*: for $A=\alpha\,\mathrm{Id}_V\oplus B$ with $B$ symmetric on $U=V^\perp$, $\delta_A$ preserves the splitting $\Lambda^2V\oplus(V\otimes U)\oplus\Lambda^2U$ and acts as the scalar $2\alpha$ on $\Lambda^2V$, while $W$ is supported on $\Lambda^2V$ and block-diagonal for the same splitting; so $[W,\delta_A]=0$. That is $1+\tfrac{(n-4)(n-3)}2$ dimensions, which is $\ge n$ exactly when $n^2-9n+14\ge0$, i.e. **for every $n\ge7$**.

This reproduces the record's own numbers independently: it predicts $\dim\ker\Phi_W\ge n$ at padded $W_{\mathbb{CP}^2}$ (matching [target.md:510](../findings/target.md#L510), "implementing only the dimension corollary … wrongly called padded $W_{\mathbb{CP}^2}$ diagonal"), and for $\mathbb{CP}^2+\mathbb{CP}^2$ at $n=12$ ($V_1,V_2$ two copies of $\mathbb R^4$, $U=\mathbb R^4$) it gives $2+\dim\mathrm{Sym}^2(\mathbb R^4)=2+10=12=n$, matching [07-gradedness-split.tex:812](../report/sections/07-gradedness-split.tex#L812)'s "$\dim\ker\Phi_W=n$ exactly".

**The criterion is not vacuous.** At $n=4$ the same $W$ has $\dim\ker\Phi_W=1<4$. Derivation: $\mathcal W_4=\mathrm{Sym}^2_0(\Lambda^+)\oplus\mathrm{Sym}^2_0(\Lambda^-)$ (dimension $5+5=10=\dim\mathcal W_4$ ✓). Split $A=c\,\mathrm{Id}+A_0$ with $A_0$ traceless; $\delta_{c\mathrm{Id}}=2c\,\mathrm{id}$ is central, so $\Phi_W(A)=[W,\delta_{A_0}]$. As $SO(4)$-representations $\mathrm{Sym}^2_0(\mathbb R^4)=(1,1)$, and the $(1,1)$-isotypic part of $\mathrm{End}(\Lambda^2\mathbb R^4)$ is exactly $\mathrm{Hom}(\Lambda^+,\Lambda^-)\oplus\mathrm{Hom}(\Lambda^-,\Lambda^+)$, $\mathrm{End}(\Lambda^\pm)=(0,0)+(2,0)$ resp. $(0,0)+(0,2)$ carry no $(1,1)$. So $\delta_{A_0}$ is **purely off-diagonal**, $\delta_{A_0}=\begin{pmatrix}0&S^{\mathsf T}\\S&0\end{pmatrix}$. (Check: $A_0=\mathrm{diag}(1,-1,0,0)$ sends $\varphi_{13}+\varphi_{42}\in\Lambda^+$ to $\varphi_{13}-\varphi_{42}\in\Lambda^-$.) Then $[W,\delta_{A_0}]=\begin{pmatrix}0&W^+S^{\mathsf T}\\-SW^+&0\end{pmatrix}$, which vanishes iff $SW^+=0$, and $W^+$ invertible forces $S=0$, hence $\delta_{A_0}=0$, hence $A_0=0$ (if $\delta_{A_0}=0$ then $a_i+a_j=0$ for all $i<j$, forcing $a_i\equiv0$ at $n\ge3$). So $\ker\Phi_W=\mathbb R\cdot\mathrm{Id}$, $\dim=1<4$: **the dimension certificate fires, and it fires correctly**, since this $W$ is non-diagonal by the rank-$4$ argument above. This also derives, rather than measures, the record's "$\dim\ker\Phi_W=1$ at every $\mathbb{CP}^m$" for $m=2$.

### F6, Frame-independence: CONFIRMED.

$\Phi_W$ is defined without reference to a frame: $\delta_A$ is the derivation extension of $A\in\mathrm{Sym}^2(\mathbb R^n)$ to $\Lambda^2$ (F2.2), and $\Phi_W(A)=[W,\delta_A]$. Equivariance: for $g\in O(n)$, $\delta_{gAg^{-1}}=(\Lambda^2g)\,\delta_A\,(\Lambda^2g)^{-1}$, so

$$\ker\Phi_{(\Lambda^2g)W(\Lambda^2g)^{-1}}=g\,(\ker\Phi_W)\,g^{-1}.$$

Hence $\dim\ker\Phi_W$ is an $O(n)$-invariant of $W$, and "some $A\in\ker\Phi_W$ has pairwise-distinct sums" is preserved, since conjugation does not change $A$'s eigenvalues. The criterion quantifies over a subspace that moves *with* $W$, so no frame is secretly chosen. ✓

This is the property the report's [06-shape.tex:51](../report/sections/06-shape.tex#L51) leans on ("that statement is well posed because 'non-diagonal' has a frame-independent meaning") and L37 does deliver it.

### F7, The citations. All take a true consequence except two.

| citation | what it takes | verdict |
| --- | --- | --- |
| [target.md:654](../findings/target.md#L654), Obs. L40 | the **equivalence**, as a decision procedure over the catalogue ("decided by Lemma L37 rather than by frame inspection"; "diagonal controls are correctly excluded") | sound |
| [bounds.md:142](../findings/bounds.md#L142) | the **dimension corollary**, correctly noting it is *only sufficient*: "$\dim\ker\Phi_W=8=n$ leaves Lemma L37 silent" | sound, and exactly the right reading of the one-sidedness |
| [results.md:16](../results.md#L16), [results.md:160](../results.md#L160), [results.md:470](../results.md#L470) | the statement; :470 adds the one clause of the easy direction ("the diagonal matrices in any frame supply an $n$-dimensional subspace") | sound |
| [results.md:166](../results.md#L166), [results.md:488](../results.md#L488), Obs. L40 | the **equivalence** | sound |
| [07-gradedness-split.tex:799](../report/sections/07-gradedness-split.tex#L799) | "the diagonality hypothesis has to be carried to the end, and Lemma 37 is the tool for carrying it" | sound (aspirational, not a mathematical claim) |
| [08-fence-posts.tex:112](../report/sections/08-fence-posts.tex#L112), post F22 | that $\mathrm{Id}\in\ker\Phi_W$ always, so $\dim=1$ forces $\ker\Phi_W=\mathbb R\cdot\mathrm{Id}$ | sound; I re-derived $\delta_{\mathrm{Id}}=2\,\mathrm{id}$ in F3 |
| [09-status.tex:60](../report/sections/09-status.tex#L60) | "Proven … the dimension corollary alone is insufficient, the distinct-sums search is load-bearing" | sound, and confirmed by F5's $n\ge7$ witness |
| [00-abstract.tex:9](../report/sections/00-abstract.tex#L9), [06-shape.tex:51](../report/sections/06-shape.tex#L51), [09-status.tex:133](../report/sections/09-status.tex#L133), [02-plain-language.tex:83](../report/sections/02-plain-language.tex#L83), [diagram.tex:57](../report/sections/diagram.tex#L57), [diagram-closed.tex:63](../report/sections/diagram-closed.tex#L63) | **a strengthening**: that the residual is *well posed* **because** of L37 | see F8 |
| [scripts/reviewers/r296/e1_family.py:82](../scripts/reviewers/r296/e1_family.py#L82) | **misattribution**: the comment calls the simple-eigenvalue / eigenvector-rank certificate "Lemma 37's own test" | wrong label; see F9 |

### F8, The "well posed because Lemma 37" clause is a strengthening L37 does not supply, and [06-shape.tex:51](../report/sections/06-shape.tex#L51)'s justification is contradicted by [diagonality.md](../findings/diagonality.md).

The abstract says the residual "is well posed because diagonality has a frame-independent test (Lemma 37)". Two separate problems, neither of which touches L37's truth:

1. **Well-posedness of the supremum never depended on L37.** "$W$ is diagonal in *some* orthonormal frame" is an $O(n)$-invariant condition by construction (it quantifies over all frames) so $\{W:\ W\text{ non-diagonal}\}$ is a well-defined $O(n)$-invariant set with or without a test for membership. What L37 supplies is **decidability by linear algebra**, replacing a non-convex global search over $O(n)$. That is a real and substantial gain; it is not well-posedness.
2. **[06-shape.tex:51](../report/sections/06-shape.tex#L51)'s stated reason is false against this record's own file.** It says "every earlier test asked the question in a chosen frame and could not define the set it was quantifying over". [diagonality.md](../findings/diagonality.md)'s instrument table lists **frame-minimal off-diagonal mass** $\min_{O(n)}$ as deciding diagonalisability **exactly** ($=0$ iff diagonalisable) on **every** $W$, its own caveat being only that "*computing* it is a global search", i.e. it is frame-independent and merely expensive. [conventions.md](../findings/conventions.md) carries a second such invariant, $t=\max_Ft_F$ with "$t=2$ iff $W$ is coordinate-diagonal in some frame". So at least two earlier tests were frame-independent and did define the set.

The honest form of the sentence is: *the residual's non-diagonality hypothesis becomes **decidable without an $O(n)$ search** by Lemma 37.* The clause as written attributes to L37 something the record elsewhere shows was already available, and attributes to it a logical role (well-posedness) it does not play. **This is a report-side overstatement, not a defect in L37.**

### F9, [scripts/reviewers/r296/e1_family.py:82](../scripts/reviewers/r296/e1_family.py#L82) attributes to L37 a test L37 does not contain.

The comment reads "simple eigenvalues and the rank of their eigenvectors (Lemma 37's own test)", and the code that follows counts simple eigenvalues and computes the matrix rank of their eigenvectors. That is the **Plücker / decomposability certificate**, [diagonality.md](../findings/diagonality.md)'s first instrument, restated at [bounds.md:142](../findings/bounds.md#L142) as "a simple eigenvalue whose eigenvector is not decomposable refutes diagonality on its own, with no plane, no minimisation and no Plücker machinery". It is a *different* sufficient criterion, sound in itself (a diagonal $W$ has a basis of decomposable eigenvectors, so a simple eigenvalue's eigenvector must be decomposable), and it is logically independent of $\ker\Phi_W$. L37's test is $\ker\Phi_W$ plus a distinct-sums search. The label is wrong; the code is not.

### F10, Contradiction sweep: clean.

- **Later sections of [target.md](../findings/target.md).** The block sits at line 632; the file ends at 693. Everything below (L39, Obs. L40, L41, L45, L49) is consistent, L40 at line 654 uses the equivalence as a decision procedure, which is exactly what F3/F4 license. Everything above that touches $\Phi_W$, post F22 at [474–486](../findings/target.md#L474), the origin statement at [510](../findings/target.md#L510), the $\delta_{\mathrm{Id}}=2\,\mathrm{id}$ remark at [458](../findings/target.md#L458), agrees with the block and with my derivation. **No passage in the file refutes it.**
- **`findings/` sweep for restatements.** [diagonality.md:57](../findings/diagonality.md#L57) calls $\ker\Phi_W$ "the one test that is necessary and sufficient", agrees. [bounds.md:142](../findings/bounds.md#L142) uses the corollary one-sidedly and correctly. [INDEX-traps.md:51](../findings/INDEX-traps.md#L51) (post 22) agrees. [INDEX.md:23](../findings/INDEX.md#L23) repeats the "well posed since the $\ker\Phi_W$ test" phrasing flagged in F8. [conventions.md](../findings/conventions.md)'s "$t=2$ iff $W$ is coordinate-diagonal in some frame" is an independent characterisation and is compatible: both are $O(n)$-invariant, and I found no point where they are asserted to disagree.
- **Convention check.** [conventions.md](../findings/conventions.md) fixes "diagonal" as diagonal in the coordinate $2$-planes $e_i\wedge e_j$, *not* diagonal as an operator on $\Lambda^2$. F4 step 3 delivers precisely $W\varphi_{ij}=\lambda_{ij}\varphi_{ij}$, so L37 concludes in the right sense. **The target.md block does not say which sense it means**; [results.md:470](../results.md#L470) does ("every $\varphi_{ij}=e_i\wedge e_j$ an eigenvector"). Worth importing into the block, since the conflation is a named trap.
- **Cosmetic.** The block writes `$W\in\Weyl_n$`, a LaTeX macro that does not render in Markdown. Neighbouring blocks share the defect, and [Obs. L40](../findings/target.md#L654) additionally carries a malformed `$W_{\CP^2**$` brace. Outside my target, recorded in passing.

---

## VERDICT: CONFIRMED

**The mathematics of Lemma L37 is correct in full, and I derived both directions and the corollary from the definitions without using the record.**

| clause | status |
| --- | --- |
| $\delta_A$ well defined on $\Lambda^2$, spectrum $\{a_i+a_j\}$ with eigenvectors $\varphi_{ij}$ | proved, F2 |
| diagonal $\Rightarrow$ some $A\in\ker\Phi_W$ with distinct sums | proved, F3; $A=\sum_i2^if_if_i^{\mathsf T}$ works for every $n$, so distinctness is never an obstruction |
| some $A\in\ker\Phi_W$ with distinct sums $\Rightarrow$ diagonal | proved, F4; distinct sums force distinct $a_i$, $\delta_A$ simple on $\Lambda^2$, $W$ preserves its eigenlines |
| $\dim\ker\Phi_W<n\Rightarrow$ non-diagonal | proved, F5; no hidden hypothesis, needs neither criticality nor $W\in\mathcal W_n$ |
| $n$ is the sharp threshold | proved, F5; a non-diagonal $W$ with $\dim\ker\Phi_W\ge n$ exists at every $n\ge7$ |
| the criterion is non-vacuous | proved, F5; $\dim\ker\Phi_W=1<4$ at the self-dual $W$ with invertible $W^+$ at $n=4$ |
| frame-independence | proved, F6; $\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$ |

**Three record defects, none mathematical.**

1. **The pointer is false** (F1). The block names *"What survives, because it was verified directly rather than taken from"* as holding the argument; that section ([target.md:383](../findings/target.md#L383)) holds an *application* and no proof. The only place either direction is argued anywhere in the record is [07-gradedness-split.tex:792](../report/sections/07-gradedness-split.tex#L792), in `report/`, not `findings/`. [results.md:470](../results.md#L470)'s "**Proof:** findings/target.md" is the same false pointer at file level. **Repair: put the four-line proof (F2–F5) in the block.**
2. **"Well posed because Lemma 37" is a strengthening** (F8), repeated in the abstract and five other places. The non-diagonal set is $O(n)$-invariant by construction, so its well-posedness never depended on L37; what L37 supplies is decidability without an $O(n)$ search. And [06-shape.tex:51](../report/sections/06-shape.tex#L51)'s stated reason, "every earlier test asked the question in a chosen frame and could not define the set it was quantifying over", is **contradicted by [diagonality.md](../findings/diagonality.md)**, whose instrument table records the frame-minimal off-diagonal mass as exact, frame-independent and merely expensive to compute.
3. **[scripts/reviewers/r296/e1_family.py:82](../scripts/reviewers/r296/e1_family.py#L82) mislabels** the simple-eigenvalue/eigenvector-rank certificate as "Lemma 37's own test" (F9). Different criterion; the code is right, the comment is wrong.

**Consequence for the abstract.** L37 holds, so the residual inequality's non-diagonality hypothesis does have the frame-independent, search-free test the abstract relies on. The abstract's *conclusion* stands. Only its *reason* is overstated, and only [06-shape.tex:51](../report/sections/06-shape.tex#L51)'s supporting clause is false.

**No computation was run.** Every witness above (the $n=4$ self-dual operator, the padded family at $n\ge7$, the $\mathbb{CP}^2+\mathbb{CP}^2$ dimension count) is derived by hand and stated as a derivation.
