# Reviewer 94, the moduli count, Huisken's Lemma 3.5, and the four route closures

**No numerical checking was used anywhere in this report.** Every quantity below is an exact rational or an exact surd, obtained by hand algebra or by `sympy` over `Rational`/`sqrt` with exact comparison. No floating point, no sampling, no solvers, no optimisation. Where the author quotes a decimal I certify it by exact rational bounds on the surd (e.g. "$x$ rounds to $0.1124$" is checked as $(x-\tfrac{1124}{10000})^2<\tfrac{25}{10^{10}}$), never by evaluating it.

Worked cold: Huisken's Lemma 3.5 and Xu's Lemma 2.14 were rebuilt from the primary texts and the sphere-product and $\mathbb{CP}^2$ tensors constructed from scratch before the author's claims were read.

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 1a | $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$ | **CONFIRMED** |
| 1b | Subtracting $\dim O(n)$ is legitimate (generic stabiliser) | **CONFIRMED** as *finite*, not *trivial* |
| 1c | The generic count misleads at the maximisers | **REFUTED**, the orbits there are *smaller*, so the transverse slack is *larger*; the count understates |
| 1d | "Alignment IS these moduli, so a spectral bound cannot suffice" | **REFUTED as an inference**, and it collapses at $n=4$, where the cubic is a function of the spectrum alone |
| 2 | Huisken's Lemma 3.5 proceeds by normal form + Lagrange enumeration; the displayed $8P$ | **CONFIRMED verbatim**, polynomial reproduced identically |
| 2' | That enumeration is "the operative obstruction", and $\mathfrak{so}(4)$-splitting is not | **REFUTED**, the operative fact is $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ on $\mathrm{Weyl}_4$, which *is* the $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ splitting; no enumeration is needed at all |
| 3 | $B_\#/\theta_0=\frac{n(n-3)}{(n-1)(n-2)}$, $\mathop{\mathrm{tr}}(W^3)/P=\frac2{(n-1)(n-2)}$, summing to $1$; vertex bound saturated | **CONFIRMED**, all three, exactly and independently |
| 3' | "$\ge1.29\times$ unconditionally" | **REFUTED as stated**, false for every $n\ge324$; the true unconditional floor is $1+\frac{\sqrt3}6=1.2886\ldots$ |
| 3'' | The $\mathop{\mathrm{tr}}(W^3)$ bound "overshoots on Weyl tensors by $17\times$/$43\times$" | **MISLEADING**, correct against the *maximiser's value*, but the looseness against $\mathrm{Weyl}_n$ is at most $2.32\times$/$2.39\times$ |
| 4 | Xu's constant, the $\sqrt{n(n+1)/2}$ overshoot, the $M$-reformulation, $\Theta(n)$ | **CONFIRMED**, including all four quoted decimals |
| 4' | "(2.53) and (2.54) are identities, all the inequality is (2.55)" | **PARTLY REFUTED**, Xu's chain contains a second inequality (the triangle step), and removing it is exactly what the $M$-form gains |
| 5 | The four route closures | Three sound; the Huisken row of [ATTEMPTS.md](../ATTEMPTS.md) contradicts fence post F2c, and the correct reason is neither of the two on file |
| 6 | Bookkeeping | Two different fence posts are both numbered **3** in [fence-posts.md](../findings/fence-posts.md) |

---

## The headline: at $n=4$ the cubic is a spectral invariant, and that is what Lemma 3.5 is about

**Theorem (derived here).** For every $W\in\mathrm{Weyl}_4$,

$$\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3),\qquad\text{hence}\qquad \langle Q(W),W\rangle=3\mathop{\mathrm{tr}}(W^3)=3\big(\mathop{\mathrm{tr}}((W^+)^3)+\mathop{\mathrm{tr}}((W^-)^3)\big).$$

*Proof.* Put $W$ in Huisken's normal form, $A=\mathop{\mathrm{diag}}(\lambda_i)$, $B=\mathop{\mathrm{diag}}(\mu_i)$, $\sum\lambda=\sum\mu=0$. From the full four-index tensor, $\mathop{\mathrm{tr}}(W^3)=\tfrac18W_{ijkl}W_{klmn}W_{mnij}=2\sum(\lambda_i^3+3\lambda_i\mu_i^2)$ and $\langle W^\#,W\rangle=\tfrac12W_{ijkl}W_{imkn}W_{jmln}=12\big(\lambda_1\lambda_2\lambda_3+\lambda_1\mu_2\mu_3+\lambda_2\mu_1\mu_3+\lambda_3\mu_1\mu_2\big)$. Now $\sum\lambda=0$ gives $\sum\lambda_i^3=3\lambda_1\lambda_2\lambda_3$, and $\sum\mu=0$ gives $\mu_2\mu_3=e_2(\mu)+\mu_1^2$ (and cyclically), so $\sum_i\lambda_i\mu_j\mu_k=e_2(\mu)\sum\lambda_i+\sum\lambda_i\mu_i^2=\sum\lambda_i\mu_i^2$. Substituting both, $\langle W^\#,W\rangle=12\lambda_1\lambda_2\lambda_3+12\sum\lambda_i\mu_i^2=4\sum(\lambda_i^3+3\lambda_i\mu_i^2)=2\mathop{\mathrm{tr}}(W^3)$. Both sides are $O(4)$-invariant and every $\mathrm{Weyl}_4$ tensor is $O(4)$-equivalent to a normal form, so the identity holds on all of $\mathrm{Weyl}_4$. $\square$

Checked a second, fully independent way on $S^2\times S^2$ through the vertex machinery (no normal form used): $\mathop{\mathrm{tr}}(W^3)=\tfrac49$ and $\langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)=\tfrac89$ exactly. And a third: $W_{\mathbb{CP}^2}$ has $\Lambda^2$-spectrum $c\cdot(2,-1,-1,0,0,0)$, so $\mathop{\mathrm{tr}}(W^3)/\lVert W\rVert^3=1/\sqrt6$ and the identity returns $\theta=3/\sqrt6=\sqrt{3/2}$, the recorded value, reproduced from the identity rather than assumed.

**Why it is true, structurally.** $\Lambda^2\mathbb R^4=\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, the bracket has no cross terms, and every Weyl tensor is block diagonal for that splitting; so $\#$ splits as $\big((W^+)^\#,(W^-)^\#\big)$, and on $\mathfrak{so}(3)\cong(\mathbb R^3,\times)$ the $\#$ operation *is* the adjugate up to normalisation. For traceless $3\times3$ symmetric $A$, $\langle\mathop{\mathrm{adj}}A,A\rangle=3\det A=\mathop{\mathrm{tr}}(A^3)$. That is the whole mechanism.

**Consequence 1, Lemma 3.5 has a two-line proof.** Apply Huisken's own (2.45)/Okumura constant $\frac{m-2}{\sqrt{m(m-1)}}=\frac1{\sqrt6}$ at $m=3$ to each traceless $3\times3$ block, then superadditivity $a^{3/2}+b^{3/2}\le(a+b)^{3/2}$:

$$\langle Q(W),W\rangle=3\big(\mathop{\mathrm{tr}}((W^+)^3)+\mathop{\mathrm{tr}}((W^-)^3)\big)\le\tfrac3{\sqrt6}\big(\lVert W^+\rVert^3+\lVert W^-\rVert^3\big)\le\tfrac3{\sqrt6}\lVert W\rVert^3=\sqrt{\tfrac32}\,\lVert W\rVert^3 .$$

This reproduces Xu (2.49) exactly, and its equality case falls out for free, one chirality zero, the other with spectrum $\propto(2,-1,-1)$, i.e. $W_{\mathbb{CP}^2}$. Huisken's two pages of Lagrange multipliers, and his own two stationary values $\sqrt3/4$ and $\sqrt6/4$ in the $\lvert W\rvert=1$ normalisation, are recovered without enumerating anything.

**Consequence 2, fence post F2c's mechanism is wrong, and it demoted the correct reason.** Post F2c says the operative obstruction is the normal-form-plus-stationary-point enumeration, feasible "only where that count is small", and files the $\mathfrak{so}(4)$-splitting as "true but not the operative obstruction". It is the reverse. The enumeration is not load-bearing (nothing needs enumerating), and the splitting is exactly what makes the cubic spectral. The obstruction to generalising is therefore sharp and quantifiable: the identity $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ is *false* for $n\ge5$, and its failure is measured by the record's own number, at $S^{n/2}\times S^{n/2}$, $\langle W^\#,W\rangle/\mathop{\mathrm{tr}}(W^3)=\tfrac{n(n-3)}2$, growing without bound. That is a better fence post than either version on file, and it deserves to replace both.

**Consequence 3, post F2c's sentence "at $n=4$ the alignment degrees of freedom are gone" contradicts its own count.** The count it quotes is $4$ at $n=4$, not $0$. What is actually true is that at $n=4$ the moduli *are* the spectrum: $W$ is determined up to $O(4)$ and a finite ambiguity by $(\mathop{\mathrm{spec}}W^+,\mathop{\mathrm{spec}}W^-)$, which is $2+2=4$ free parameters, exactly the moduli count. So "alignment carries no information beyond the spectrum" is right at $n=4$; "the degrees of freedom are gone" is not.

---

## 1. The moduli count

**(a) $\dim\mathrm{Weyl}_n$. CONFIRMED.** $\dim\mathrm{Curv}_n=\frac{n^2(n^2-1)}{12}$, and the Ricci contraction onto $\mathrm{Sym}^2(\mathbb R^n)$ is onto for $n\ge3$, so $\dim\mathrm{Weyl}_n=\frac{n^2(n^2-1)}{12}-\frac{n(n+1)}2=\frac{n(n+1)(n+2)(n-3)}{12}$: $10,35,84,300,1638$ at $n=4,5,6,8,12$. The last matches the record's own "$1638$ dimensions" at $n=12$. Subtracting $\dim O(n)$: $\frac{n(n+1)(n+2)(n-3)}{12}-\frac{n(n-1)}2=\frac{n(n^3-13n)}{12}=\frac{n^2(n^2-13)}{12}$, giving $4,25,69,272,1572$. Every figure in post F2c is right.

**(b) Is the generic stabiliser trivial? CONFIRMED in the only sense that matters, it is finite; it is never trivial.** $-\mathrm{Id}\in O(n)$ fixes every curvature tensor (degree 4), so the stabiliser always contains $\mathbb Z_2$; the count needs only $\dim\mathrm{Stab}=0$. Clean criterion, proved here:

> If the symmetric operator $\widehat W$ on $\Lambda^2$ has simple spectrum, $\mathrm{Stab}(W)$ is finite. *Proof:* $X\in\mathfrak{stab}$ gives $[\rho(X),\widehat W]=0$, so $\rho(X)$ preserves each eigenline; $\rho(X)$ is skew, so it kills each eigenline, so $\rho(X)=0$; $\rho:\mathfrak{so}(n)\to\mathfrak{so}(\Lambda^2)$ is faithful, so $X=0$.

Since $\dim\mathrm{Stab}$ is upper semicontinuous and $\mathrm{Weyl}_n$ is irreducible, one witness makes finiteness generic. Witnesses were constructed exactly: for $n=5,6,7,8$ the diagonal (vertex) Weyl tensor obtained by projecting $r_{ij}=2^i3^j$ has all $\binom n2$ eigenvalues distinct over $\mathbb Q$. At $n=4$ the diagonal locus cannot work, solving hollowness with zero row sums forces $w_{12}=w_{34}$, $w_{13}=w_{24}$, $w_{14}=w_{23}$, which is Huisken's $\mu=0$ slice, but $\lambda=(1,2,-3)$, $\mu=(4,-1,-3)$ gives $\Lambda^2$-spectrum $\{5,1,-6,-3,3,0\}$, simple. So the subtraction is legitimate at every $n\ge4$.

**(c) Do the maximisers break the count? REFUTED, but the framing needs a correction the author does not make.** Stabiliser algebras, computed here from $[\rho(X),\widehat W]=0$:

| point | $\mathfrak{stab}$ | $\dim\mathfrak{stab}$ | orbit | orbit at $n=12$ |
|---|---|---|---|---|
| generic $W$ | $0$ | $0$ | $\frac{n(n-1)}2$ | $66$ |
| $S^{n/2}\times S^{n/2}$ | $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $m=\frac n2$ | $m(m-1)$ | $m^2=\frac{n^2}4$ | $36$ |
| padded $W_{\mathbb{CP}^2}$ | $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ | $4+\frac{(n-4)(n-5)}2$ | $4n-14$ | $34$ |

($\widehat W_{S\times S}$ has exactly two eigenspaces, $\Lambda^2V_1\oplus\Lambda^2V_2$ and $V_1\otimes V_2$; a mixed generator maps the first into the second, so the stabiliser is exactly block-diagonal. Both orbit dimensions agree with the record's independently obtained Peirce-cap multiplicities, $36$ and $4n-14$.)

So the orbits at the maximisers are *smaller*, $\Theta(n^2)$ and $\Theta(n)$ against $\Theta(n^2)$ with twice the constant, and $\Theta(n)$ is a collapse. The transverse slice is correspondingly *larger*: $1602$ and $1604$ at $n=12$, against the generic $1572$. The count does not mislead in the direction the brief feared; if anything it understates the slack at exactly the points that matter.

The correction the author does owe: $\dim\mathrm{Weyl}_n-\dim O(n)$ is the *generic* quotient dimension, and at a symmetric point $\dim\mathrm{Weyl}_n-\dim(\text{orbit})$ is the **slice** dimension, not a local moduli count. By the slice theorem the neighbourhood is $G\times_H S$ and the local quotient is $S/H$, of dimension $1602-30=1572$ at the balanced sphere product, the generic value again, as it must be, since generic orbits are dense. Post F2c's phrase "after the $O(n)$ gauge a Weyl tensor retains $\ldots$ moduli" is a generic-orbit statement and should say so.

**(d) "So a spectral bound cannot suffice". REFUTED as an inference.** Two independent reasons.

*It is a non-sequitur.* A bound is not an identity. Both $P$ and the spectrum are $O(n)$-invariant, so $\sigma\mapsto\sup\{P(W):\mathop{\mathrm{spec}}\widehat W=\sigma\}$ is a well-defined function of the spectrum alone, and a spectral bound $P\le\Theta(\sigma)$ suffices for Conjecture A precisely when that fibrewise supremum stays under $\theta_0\lVert W\rVert^3$. Whether it does is a quantitative question about the worst point of each fibre. A dimension count establishes only that the spectrum fails to *determine* $P$, it cannot decide whether it *bounds* $P$, and no count ever will.

*It collapses at $n=4$.* There the moduli count is $4$ and the independent spectral data is also $4$ ($6$ eigenvalues, less the two relations $\mathop{\mathrm{tr}}W^+=\mathop{\mathrm{tr}}W^-=0$), and by the theorem above $P=3\mathop{\mathrm{tr}}(W^3)$ is a function of the spectrum, indeed of a single spectral invariant. So the one dimension in which a sharp bound is known is the dimension in which the bound is purely spectral. The correct statement of post F1 is the gap between the two counts, which opens only at $n\ge5$: $25$ against $9$ at $n=5$, $69$ against $14$ at $n=6$, $1572$ against $65$ at $n=12$ (the spectral column is $\binom n2-1$, the trace being fixed). Post F1's own comparison, "$1572$ parameters against $66$ eigenvalues", is right in substance; the sentence built on it is not.

---

## 2. Huisken's Lemma 3.5, against the text

**CONFIRMED verbatim**, [huisken-jdg-1985.txt](https://projecteuclid.org/journals/journal-of-differential-geometry/volume-21/issue-1/Ricci-deformation-of-the-metric-on-a-Riemannian-manifold/10.4310/jdg/1214439463.pdf) pp. 57–59. The proof does invoke the $n=4$ normal-form theorem ($W$ on $\Lambda^2$ in the basis $e_1\wedge e_2,e_1\wedge e_3,e_1\wedge e_4,e_3\wedge e_4,e_4\wedge e_2,e_2\wedge e_3$ takes the block form built from $\mathop{\mathrm{diag}}(\lambda_i)$ and $\mathop{\mathrm{diag}}(\mu_i)$), does state $\sum\mu_i=0$ from Bianchi and $\sum\lambda_i=0$ from tracelessness, does convert the cubic to $8P$, and does enumerate stationary points by Lagrange multipliers (3.10)–(3.12). The author's description is accurate.

The displayed polynomial reproduces **identically**, off-constraint as well as on. Building $W_{ijkl}$ from the block matrix and contracting:

$$W_{ijkl}W_{imkn}W_{jmln}=24\big(\lambda_1\lambda_2\lambda_3+\lambda_1\mu_2\mu_3+\lambda_2\mu_1\mu_3+\lambda_3\mu_1\mu_2\big),\qquad W_{ijkl}W_{klmn}W_{mnij}=16\sum_i\big(\lambda_i^3+3\lambda_i\mu_i^2\big),$$

so $2W_{ijkl}W_{imkn}W_{jmln}+\tfrac12W_{ijkl}W_{klmn}W_{mnij}=48\{\lambda_1\lambda_2\lambda_3+\lambda_1\mu_2\mu_3+\lambda_2\mu_1\mu_3+\lambda_3\mu_1\mu_2\}+8\sum\lambda_i^3+24\sum\lambda_i\mu_i^2=8P$, matching the paper term for term. Two by-products confirm the setup rather than assuming it: the first Bianchi sum of the constructed tensor equals $\mu_1+\mu_2+\mu_3$ and its Ricci trace equals $\lambda_1+\lambda_2+\lambda_3$, exactly as Huisken attributes them; and $\lvert W\rvert^2=8\sum(\lambda_i^2+\mu_i^2)$, his normalisation.

Conventions bridged exactly, which the record does not do explicitly: Xu (2.52) gives $\langle Q(W),W\rangle=\tfrac18\big(W_{ijkl}W_{klmn}W_{mnij}+4W_{ijkl}W_{imkn}W_{jmln}\big)=\tfrac14\big(2W_{ijkl}W_{imkn}W_{jmln}+\tfrac12W_{ijkl}W_{klmn}W_{mnij}\big)=2P$. So Huisken's Lemma 3.5 constant is $\sqrt6/4$ against $\lvert W\rvert^3$, which is $\sqrt{3/2}$ against $\lVert W\rVert^3$, Xu (2.49), and his two stationary values are $\sqrt3/4$ (the $\mu=0$ branch, i.e. $S^2\times S^2$) and $\sqrt6/4$ (the $\lambda=\mu$ branch, i.e. $\mathbb{CP}^2$), the second being the maximum. Post F2c's identification of $\sqrt6/2\lVert W\rVert^3$ with the $\mathbb{CP}^2$ value and with $\sqrt{3/2}$ is correct.

---

## 3. Fence post F2's corrected mechanism

Everything structural here is **CONFIRMED**, derived independently from the curvature operator of $S^m\times S^m$ (unit factors, $n=2m$) with no use of the record's formulas. Projecting off the Kulkarni–Nomizu part gives the vertex matrix $w_{ij}=\frac m{n-1}$ within a block, $-\frac{m-1}{n-1}$ across, whence

$$\lVert W\rVert^2=\frac{m^2(m-1)}{2m-1},\qquad \mathop{\mathrm{tr}}(W^3)=\frac{m^2(m-1)}{(2m-1)^2},\qquad \langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)=\frac{m^3(m-1)(2m-3)}{(2m-1)^2},$$

$$\frac{P}{\lVert W\rVert^3}=\frac{\sqrt{2m^2-3m+1}}m=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)\quad\text{exactly},$$

$$\frac{\mathop{\mathrm{tr}}(W^3)}P=\frac2{(n-1)(n-2)},\qquad \frac{\langle W^\#,W\rangle}P=\frac{n(n-3)}{(n-1)(n-2)}=1-\frac2{(n-1)(n-2)} .$$

$\langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)$ was checked twice, once by the pair-sum formula and once by diagonalising $\Lambda$ ($0$ once, $\frac{2m(m-1)}{2m-1}$ once, $-\frac m{2m-1}$ with multiplicity $n-2$). The reconstruction of $\theta_0$ from a from-scratch tensor is a strong cross-validation of the project's conventions.

**Saturation, CONFIRMED as a theorem, not a coincidence.** The refined vertex bound is Okumura at $m=n-1$ on $\mathbf1^\perp$: $\langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)\le\tfrac12\frac{n-3}{\sqrt{(n-1)(n-2)}}\lVert\Lambda\rVert^3=\frac{\sqrt2(n-3)}{\sqrt{(n-1)(n-2)}}\lVert W\rVert^3=:B_\#$, so $B_\#/\theta_0=\frac{n(n-3)}{(n-1)(n-2)}$ (the author's formula) and the Okumura equality profile ($n-2$ equal eigenvalues against one, in ratio $-1:(n-2)$) is exactly the spectrum of $\Lambda$ above, since $\frac{2m(m-1)}{2m-1}\big/\frac m{2m-1}=2m-2=n-2$. The two ratios sum to $1$ identically. **All the slack is in $\mathop{\mathrm{tr}}(W^3)$: confirmed.**

**"$\ge1.29\times$ unconditionally": REFUTED as stated.** The floor is reconstructed exactly, the two attained values are $\langle W^\#,W\rangle$ at $S^{n/2}\times S^{n/2}$ and $\mathop{\mathrm{tr}}(W^3)=\lVert W\rVert^3/\sqrt6$ at padded $W_{\mathbb{CP}^2}$ (spectrum $\propto(2,-1,-1,0,\dots)$, so $6c^3/(6c^2)^{3/2}$), giving

$$f(n)=\frac{n(n-3)}{(n-1)(n-2)}+\frac n{2\sqrt3\sqrt{(n-1)(n-2)}},\qquad f(12)=\frac{54}{55}+\frac{\sqrt{330}}{55},\qquad \lim_{n\to\infty}f(n)=1+\frac{\sqrt3}6 .$$

$f(12)$ matches Reviewer 92's bracket exactly, so this is the intended quantity. But $f$ **decreases** to its limit, and $1+\frac{\sqrt3}6<\frac{129}{100}$ exactly, since $\sqrt3<\frac{174}{100}\iff3<\frac{7569}{2500}$. The condition $f(n)<\frac{129}{100}$ is equivalent, after clearing the surd, to the integer inequality $2500\,Dn^2<3(29D+200)^2$ with $D=(n-1)(n-2)$, whose smallest integer solution is $\mathbf{n=324}$ (and $n=323$ fails). So the claim is true on $12\le n\le323$ and **false for every $n\ge324$**. The fix is one character of honesty: the unconditional floor is $1+\frac{\sqrt3}6=1.2886\ldots$, approached from above and never attained. Reviewer 92 wrote "at least ~$1.29\times$"; the fence post dropped the tilde and added "unconditionally". *The route still closes* (the floor exceeds $1$ at every $n$) so only the constant is wrong.

**"$17\times$ at $n=8$ and $43\times$ at $n=12$": arithmetically right, rhetorically misleading.** Against the maximiser's value the ratios are exactly $\tfrac{52}3$ and $\tfrac{64\sqrt{78}}{13}$, i.e. $17.3\ldots$ and $43.5\ldots$, so the numbers check. But the sentence reads "overshoots *on Weyl tensors*", and against $\mathrm{Weyl}_n$ the looseness is at most $\frac{13\sqrt{14}}{21}$ and $\frac{64\sqrt{715}}{715}$, i.e. under $2.32\times$ and $2.39\times$, because $\sup_{\mathrm{Weyl}_n}\mathop{\mathrm{tr}}(W^3)\ge1/\sqrt6$. A reader chasing "$43\times$ of available slack" would be chasing a factor $18$ that is not there, and $f(n)>1.2886$ says no amount of sharpening the $\mathop{\mathrm{tr}}(W^3)$ bound can rescue the route. Reword to "overshoots its value at the maximiser".

**Scope note.** "Any term-by-term route" means, in this argument, any route that bounds the two summands by *independent* suprema over $\mathrm{Weyl}_n$. It does not close routes that bound both summands by *coupled* functions of shared data. That should be stated, or the post over-claims its own reach.

---

## 4. The $\Theta(n)$ claim

**CONFIRMED throughout.** $\sqrt{\frac{N-1}N}(n-1)=\sqrt{\frac{(n^2-1)(n-2)}n}$ with $N=\frac{n(n-1)}2$, so Xu's (2.48) is exactly what his chain delivers; its ratio to $\theta_0$ squares to $\frac{(n^2-1)(n-2)}n\cdot\frac{n^2}{2(n-1)(n-2)}=\frac{n(n+1)}2$, giving $\sqrt{10},\sqrt{21},\sqrt{78},\sqrt{210}$ at $n=4,6,12,20$ and growth $\sim n/\sqrt2$. With $M=\sum\xi\otimes\xi$ (PSD, a sum of rank-ones), $\mathop{\mathrm{tr}}M=16(n-1)\lVert W\rVert^2$ and $\mathop{\mathrm{tr}}(WM)=-16\langle Q(W),W\rangle$ are (2.54) and (2.53), so $\mathop{\mathrm{tr}}(W\widehat M)=-\frac{\langle Q(W),W\rangle}{(n-1)\lVert W\rVert^2}$ and the conjecture is exactly $\lvert\mathop{\mathrm{tr}}(W\widehat M)\rvert\le\frac{\theta_0\lVert W\rVert}{n-1}=\frac{\sqrt{2(n-2)}}{n\sqrt{n-1}}\lVert W\rVert\sim\frac{\sqrt2}n\lVert W\rVert$. The four quoted decimals are $\theta_0/(n-1)$: $\frac{\sqrt{10}}{15},\frac{\sqrt{55}}{66},\frac{3\sqrt{19}}{190},\frac{2\sqrt6}{175}$, each rounding to $0.2108$, $0.1124$, $0.0688$, $0.0280$ (certified by exact rational bounds).

**One correction: "all the inequality is (2.55)" is false.** Xu's chain is $\lvert\langle Q(W),W\rangle\rvert\le\frac1{16}\sum\lvert\langle W\xi,\xi\rangle\rvert\le\ldots$, the **first** step is a triangle inequality over the $\xi^{pqrs}$, lossy whenever the terms differ in sign, and it is a second inequality alongside (2.55). The $M$-form is precisely the chain with that step removed: $\lvert\mathop{\mathrm{tr}}(W\widehat M)\rvert\le\max(\lvert\lambda_{\max}\rvert,\lvert\lambda_{\min}\rvert)\le\sqrt{\frac{N-1}N}\lVert W\rVert$ recovers (2.48) without ever taking absolute values term by term. So the reformulation's gain is not only "the measurement": it also identifies a removable loss the post says is not there. Post F2b should list two inequality steps, one of them free to delete.

---

## 5. The four route closures

| Route | Verdict on the closure |
|---|---|
| Term-by-term Tachibana | **Sound**, constant wrong (see §3), scope unstated |
| Petersen–Wink Prop 1.3 | **Sound.** $\Lambda_{\alpha\beta\gamma}+6\lambda_\alpha\lambda_\beta\lambda_\gamma=\sum_{i\ne j}\lambda_i\lambda_j^2$ is elementary and correct, and the collapse checks: $T$ totally symmetric with $\sum_\gamma T_{\alpha\beta\gamma}=R_{\alpha\beta}$ and the per-row identity $\sum_\alpha R_{\alpha\beta}\lambda_\alpha=-2\lambda_\beta$ give $\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\sum_{i\ne j}\lambda_i\lambda_j^2=6\sum_{\alpha\beta}R_{\alpha\beta}\lambda_\alpha\lambda_\beta^2=-12\sum\lambda^3$, which over unordered triples $I$ is exactly the recorded $-2\sum\lambda^3$. Fence post F18 genuinely covers it, the ordered/unordered factor $6$ is the only thing to watch |
| Huisken $n=4$ | **Right answer, wrong reason, twice.** The [ATTEMPTS.md](../ATTEMPTS.md) table closes it on "$\mathfrak{so}(4)$ semisimple non-simple, $\mathrm{Weyl}_n$ irreducible for $n\ge5$" while post F2c, written the same day, files that reason as "not the operative obstruction" and substitutes the moduli count. The record contradicts itself, and neither entry is the mechanism: it is the identity $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$, whose failure for $n\ge5$ is measured by $\frac{n(n-3)}2$ |
| $\xi$-Gram reformulation | **Sound as a classification, overstated as a closure.** I verified it is an exact restatement, so "neither easier nor harder" is literally true and nothing is refuted. Calling it *closed* is wrong: an exact reformulation that also hands you a PSD $M$ quadratic in $W$ is a relabelling, and the post itself says the way in is to use that structure. It belongs in the live front, not in the closed column |

The brief asks whether any route was closed on a bad argument, given the author has done that once before. **The Huisken row is the one to worry about**, not because the route is live (it is dead), but because both recorded reasons are wrong about *why*, and a wrong reason is what misdirects the next attempt. The correct reason is also the more useful one, since it names the exact algebraic identity that would have to be replaced at $n\ge5$.

---

## 6. Other defects in the recent material

- **Duplicate numbering.** [fence-posts.md](../findings/fence-posts.md) has two posts numbered **3**, "The two separately-sharp cubic bounds overshoot by $1.7$–$1.8\times$" and "Universal lifting is false". Every later citation of "fence post F3" is now ambiguous. Renumber.
- **Post F3 (first) versus post F2.** Post F3 still headlines "$1.7$–$1.8\times$" and points at post F2 for the correction, while post F2 says the honest floor is $\approx1.29$ (really $1.2886$). Two different numbers for the same phenomenon sit five lines apart.
- **"A finite stationary-point enumeration is possible only where that count is small, and $n=4$ is the only such dimension."** Unsupported as stated, and now moot: no enumeration is needed at $n=4$, and feasibility of a Lagrange enumeration is a question about the degree and structure of the critical equations, not about a modulus count. $25$ moduli at $n=5$ is not self-evidently "not small"; the record's own diagonal-locus censuses enumerate in much larger moduli.
- **Post F1's "$\mathop{\mathrm{tr}}(W^3)/P=\frac2{(n-1)(n-2)}$ … proved as an identity rather than scanned"**, CONFIRMED, independently, above.

## What I would change, in priority order

1. Replace post F2c's mechanism with the identity $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ on $\mathrm{Weyl}_4$, the two-line proof of Lemma 3.5 it yields, and its quantified failure $\frac{n(n-3)}2$ at $n\ge5$; restore the $\mathfrak{so}(4)$ splitting as the reason rather than the demoted also-ran, and fix the [ATTEMPTS.md](../ATTEMPTS.md) row to match.
2. Replace "$\ge1.29\times$ unconditionally" with "$>1+\frac{\sqrt3}6$ at every $n$, decreasing to it" and note that $1.29$ fails from $n=324$.
3. Rewrite post F1's conclusion as a statement about the *gap* between $\frac{n^2(n^2-13)}{12}$ and $\binom n2-1$, opening only at $n\ge5$, and drop "cannot suffice" for "does not determine", a fibrewise supremum is still a spectral function, and only a quantitative argument can close that door.
4. Reword the "$17\times$/$43\times$" sentence to say "against its value at the maximiser".
5. Add the triangle-inequality step to post F2b's account of Xu's chain, and record that the $M$-form deletes it for free.
6. Renumber the second fence post F3.
