# Review 615, Lemma L95, $\kappa^2(\mathbb{CP}^m)=3/(m+1)$

**Reviewer A of an independent pair on identical briefs. Review number 615.** Subject: [findings/bispectral.md](../findings/bispectral.md) line 218, the block `#### Lemma L95, $\kappa^2(\mathbb{CP}^m)=3/(m+1)$, closed form`. Derived cold from the definitions in [conventions.md](../findings/conventions.md); the block's own reasoning was read only after the derivation was finished.

**Analysis only.** No computation was opened. Every number below is derived by hand or is arithmetic on a closed form. One five-line arithmetic evaluation of two closed forms already on the record was run as a screen and is marked as such.

## Verdict

**CONFIRMED, and the gap is closed here.** The identity $\kappa^2(\mathbb{CP}^m)=3/(m+1)$ is **true and now proved**, including the part both cited reviewers left numerical: that the standard frame is the global maximiser over $O(2m)$. The proof is two lines and is given in §2.

The label `Lemma` was **unearned when written** and is earned now. The mathematics in the block is right throughout; four defects are in its prose, its attribution and its indexes.

| # | item | verdict |
|---|---|---|
| 1 | attribution of the derivation to Reviewer 101 | **partly false**, r101 derived the *standard-frame* value and said so; the $10^{-15}$ at $m=2,\dots,7$ is [r102](REVIEW_r102.md)'s figure, and the block credits neither correctly |
| 2 | $\kappa^2(\mathbb{CP}^m)=3/(m+1)$ as a max over frames | **CONFIRMED, and upgraded from numerics to a theorem** below |
| 3 | withdrawal of the $[0.105,1.000]$ range | **sound as a refutation, overstated as an identity** |
| 4 | $\min_F\lVert K(F)\rVert_F=0$ "for every tensor tested" | **GAP**, r101's own numbers are $3$–$5\times10^{-4}$, annotated *still descending* |
| 5 | "the fixed-frame lemma fails" | **pointer does not resolve** to any numbered result; nothing on the record relies on it |
| 6 | $(2m+1)/2$ times the generic value | **CONFIRMED and derived**, including the generic value itself |
| 7 | "a *high*-spread family, $6.5\times$ generic" | **unsupported**, a maximum compared against a mean; the like-for-like factor is $1.15$ |
| 8 | $\theta(\mathbb{CP}^m)<\theta_0(2m)$ for $m\ge4$, by $25\%$ at $n=12$ | **CONFIRMED, and it too is a theorem rather than a table** |
| 9 | the parity of the target constant | **safe, and confirmed** |
| 10 | [INDEX-results.md](../findings/INDEX-results.md) row 95, "Gate 2: no verdict on the record" | **stale**, L95 has a Gate 2 pair, and [LEDGER.md](../findings/LEDGER.md) line 1325 denies it wrongly |

---

## 1. The attribution, checked before the mathematics

The block says the closed form comes "with a closed-form derivation supplied by Reviewer 101". **The brief's suspicion that [r101](REVIEW_r101.md) is about a different subject is wrong**, r101's Claim 3 *is* L95's statement verbatim. But what r101 supplies is narrower than the block's sentence, and r101 says so in its own words:

> **CONFIRMED**, and now with a closed-form derivation of the standard-frame value; global maximality remains numerical.

and, in the body of its Claim 3:

> That it is the **global** maximum over $O(2m)$ remains numerical (basin-hopping, $m\le5$).

Since [conventions.md](../findings/conventions.md) fixes $\kappa^2=\max_Ft_F$, **the closed form r101 derived is the value of $t_F$ at one frame, not $\kappa^2$.** The block drops that clause. Three consequences, each checkable:

- **The $m$-range is spliced.** r101 verifies the *formula* $\lVert K\rVert_F^2=36m(m-1)/(2m-1)$ exactly at $m=2,\dots,7$, and separately reports its *global* check reproducing $3/(m+1)$ "at $m=3,4,5$ to $2\times10^{-15}$". The block's "to $10^{-15}$ at $m=2,\dots,7$" welds the tolerance of the second onto the range of the first.
- **The figure that does justify $m=2,\dots,7$ belongs to [r102](REVIEW_r102.md), which the block never names.** r102's Claim 3 is L95 verbatim, CONFIRMED, and its ascent section reports "$\kappa^2=3/(m+1)$ at $\mathbb{CP}^m$ from 40 starts and 1200 iterations leaves an excess of $\le3.6\times10^{-15}$, i.e. the standard frame is already optimal there."
- **So L95 does have a Gate 2 pair** (r101 and r102, identical briefs, agreeing) and two places on the record deny it. [INDEX-results.md](../findings/INDEX-results.md) line 110 reads "**Gate 2: no verdict on the record**", and [LEDGER.md](../findings/LEDGER.md) line 1325 says a sweep "recovered none" because "[L95](../findings/bispectral.md)'s cited pair had audited [L94](../findings/bispectral.md) and [L54](../findings/graded-half.md)". **That is false of both reviewers**: each has a Claim 3 whose subject is L95 and nothing else. [LEDGER.md](../findings/LEDGER.md) line 50 records the Gate 2 correctly, so the record contradicts itself in three places about one result.

**Net:** the block's attribution overstates what r101 proved and omits r102 entirely, while two indexes understate the support L95 actually has. Both errors are in the bookkeeping, not the mathematics.

## 2. The derivation, and the global maximum, which nobody had

### 2.1 The standard-frame value, rebuilt from the definitions

Take Fubini–Study on $\mathbb R^{2m}$ with $J$ the compatible complex structure, in the normalisation

$$R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl},$$

so that $R_{abab}=1+3J_{ab}^2$ on an orthonormal pair: holomorphic sectional curvature $4$, totally real $1$. Contracting, $\mathop{\mathrm{Ric}}=(n+2)g$ with $n=2m$, so the space is Einstein and

$$W_{ijkl}=R_{ijkl}-\frac{s}{n(n-1)}\big(g_{ik}g_{jl}-g_{il}g_{jk}\big),\qquad \frac{s}{n(n-1)}=\frac{n+2}{n-1}=\frac{2m+2}{2m-1}.$$

Hence, in the standard $J$-adapted frame,

$$K_{ab}=W_{abab}=1+3J_{ab}^2-\frac{2m+2}{2m-1}=3J_{ab}^2-\frac{3}{2m-1},$$

which reproduces r101's expression exactly. Row sums vanish, $\sum_bK_{ab}=\frac{3(2m-2)}{2m-1}-(2m-2)\frac{3}{2m-1}=0$, the hollowness-plus-trace condition $K\mathbf1=0$ that [conventions.md](../findings/conventions.md) requires. Counting the $2m$ holomorphic ordered pairs against the $2m(2m-2)$ real ones,

$$\lVert K\rVert_F^2=2m\cdot\frac{9(2m-2)^2}{(2m-1)^2}+2m(2m-2)\cdot\frac{9}{(2m-1)^2}=\frac{36m(m-1)}{2m-1}.$$

For the norm, write $W=(1-c)G+P+2Q$ with $G_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}$, $P_{ijkl}=J_{ik}J_{jl}-J_{il}J_{jk}$, $Q_{ijkl}=J_{ij}J_{kl}$ and $c=\frac{n+2}{n-1}$. The six contractions are $\langle G,G\rangle=2n(n-1)$, $\langle P,P\rangle=2n^2-2n$, $\langle Q,Q\rangle=n^2$, $\langle G,P\rangle=\langle G,Q\rangle=\langle P,Q\rangle=2n$, whence

$$\lVert W\rVert^2=\frac{6n(n-2)(n+2)}{n-1}=\frac{48m(m-1)(m+1)}{2m-1},\qquad \lVert M\rVert_F^2=\tfrac14\lVert W\rVert^2=\frac{12m(m-1)(m+1)}{2m-1}.$$

The factor $4$ is the antisymmetry in each index pair, and is the normalisation [Lemma L94](../findings/bispectral.md) insists on. Therefore $t_{\text{std}}=\lVert K\rVert_F^2/\lVert M\rVert_F^2=3/(m+1)$. **All three of r101's expressions confirmed, independently, by hand.**

### 2.2 The global maximum over $O(2m)$, the missing half, proved

**The observation the block, r101 and r102 all miss is that the sectional formula holds in *every* frame, not just the adapted one.** $R_{abab}=1+3J_{ab}^2$ is a tensor identity: for any orthonormal frame $F=\{f_a\}$,

$$K^F_{ab}=W(f_a,f_b,f_a,f_b)=3A_{ab}^2-\frac{3}{2m-1},\qquad A:=F^{\mathsf T}JF .$$

As $F$ ranges over $O(2m)$, $A$ ranges over the orthogonal conjugates of $J$, i.e. over **all orthogonal antisymmetric $2m\times2m$ matrices**. Two identities on any such $A$: the diagonal vanishes, and $\sum_bA_{ab}^2=(AA^{\mathsf T})_{aa}=1$, so $\sum_{a\neq b}A_{ab}^2=2m$. Expanding with $s=\frac1{2m-1}$,

$$t_F=9\sum_{a\neq b}\big(A_{ab}^2-s\big)^2=9\Big[Q_4-2s\cdot2m+s^2\cdot 2m(2m-1)\Big]=9\,Q_4-\frac{18m}{2m-1},\qquad Q_4:=\sum_{a,b}A_{ab}^4 .$$

**So maximising $t_F$ over frames is exactly maximising $Q_4$ over orthogonal antisymmetric $A$.** Every entry of an orthogonal matrix satisfies $\lvert A_{ab}\rvert\le1$, so

$$Q_4=\sum_{a,b}A_{ab}^2\cdot A_{ab}^2\ \le\ \max_{a,b}A_{ab}^2\cdot\sum_{a,b}A_{ab}^2\ \le\ 2m,$$

with equality iff $A_{ab}\in\{0,\pm1\}$ throughout, i.e. iff $A$ is a signed permutation matrix, which, being antisymmetric with $A^2=-I$, is a direct sum of $2\times2$ blocks $\begin{pmatrix}0&\varepsilon\\-\varepsilon&0\end{pmatrix}$: **precisely the $J$-adapted frames.** The bound is attained, so

$$\max_F t_F=18m-\frac{18m}{2m-1}=\frac{36m(m-1)}{2m-1},\qquad \boxed{\ \kappa^2(\mathbb{CP}^m)=\frac{36m(m-1)/(2m-1)}{12m(m-1)(m+1)/(2m-1)}=\frac{3}{m+1}\ }$$

for every $m\ge2$. $\blacksquare$

**This is what the record was owed.** The numerics of both reviewers, r101's basin-hopping at $m\le5$, r102's 40-start ascent to $3.6\times10^{-15}$, were measuring a maximum that is forced by one Cauchy–Schwarz-free inequality on the entries of an orthogonal matrix. The equality case also explains r102's remark that "the standard frame is already optimal there": the maximiser set is exactly the adapted frames, a single $U(m)\rtimes\mathbb Z_2$-orbit, so ascent from any start lands on it.

A consistency check the proof passes: $\kappa^2\le2$ from [Lemma L94](../findings/bispectral.md) reads $3/(m+1)\le2$, true for all $m\ge1$ and strict for $m\ge2$, so $\mathbb{CP}^m$ is coordinate-diagonal in no frame, correct, since $Q_4=2m$ would then have to coexist with $t_F=2\lVert M\rVert_F^2$, and it does not.

## 3. The withdrawn range, and what its withdrawal costs

### 3.1 The retraction is on firmer ground than what it retracts, and the block does not say why

The brief's worry that "for every tensor tested" is a sampling statement retracting a sampling statement is **half right, and the asymmetry runs in the retraction's favour**. To refute a claimed *lower* bound $\inf_F\lVert K(F)\rVert_F\ge0.105$ one needs a single frame below it, and a descent that reaches $5\times10^{-4}$ is a witness, not a sample. Conversely, the original $[0.105,1.000]$ was produced by sampling rotations, which can never certify an infimum from above. **So the retraction is logically sound and the range was never evidence.**

Confirming the upper endpoint, which nobody checked: $1.000$ is not a sampled artefact but exactly $\kappa(\mathbb{CP}^2)$, since $3/(2+1)=1$ and padding preserves both $K$'s nonzero entries and $\lVert M\rVert_F$. The range's *maximum* was right; only its minimum was fiction.

**What the block owes and does not pay** is the distinction itself. It writes the retraction and the original in the same register, so a reader cannot tell that one is a witness and the other was never admissible.

### 3.2 "$\min_F\lVert K(F)\rVert_F=0$" is stated as an identity and is not one

r101's own table, which is the block's only source:

| tensor | reported $\min_F\lVert K(F)\rVert_F$ |
|---|---|
| padded $W_{\mathbb{CP}^2}$, $n=4$ | $6\times10^{-12}$ |
| padded $W_{\mathbb{CP}^2}$, $n=6,8,10,12$ | $3$–$5\times10^{-4}$, **still descending** |
| balanced $S^{n/2}\times S^{n/2}$, $n=6,10,12$ | $1$–$7\times10^{-10}$ |
| random Weyl, $n=6,8,10$ | $10^{-9}$ |

**The block prints $=0$ and drops "still descending".** At the dimensions that matter for the conjectured maximiser the descent had not converged, and $3\times10^{-4}$ is four orders short of the $n=4$ row. This is the brief's "eight hedges checked, eight concealing something incomplete", instance nine.

**On whether it should be derivable:** the brief is right that a minimum identically zero looks structural, and r101 offers the dimension count, $K=0$ is $\binom n2$ equations on a hollow symmetric matrix, with $n$ dependencies from $K\mathbf1=0$, against $\dim O(n)=\binom n2$, leaving an $n$-dimensional expected solution family. **That is a heuristic and the block presents its conclusion as a fact.** The honest statement is a conjecture with a name: *every Weyl tensor admits an orthonormal frame in which all coordinate sectional curvatures vanish*, the algebraic-curvature analogue of Horn's theorem that a trace-free symmetric matrix is orthogonally similar to a hollow one, with $\sum_{a\neq b}W_{abab}=0$ the necessary trace condition, and it holds. **I could neither prove nor refute it in the time available, and it is reachable**: the natural attack is a connectedness or degree argument on the map $F\mapsto K(F)$ from the frame manifold to $\{K:K=K^{\mathsf T},\ K_{aa}=0,\ K\mathbf1=0\}$, whose dimensions differ by exactly $n$. **It needs no computation to settle.**

### 3.3 "The fixed-frame lemma", the pointer does not resolve

The block writes "the fixed-frame lemma fails" without naming it, and **no numbered result on the record bears that name.** Tracing it to its origin, commit `e3547ede`, the object is item (i) of the *owed* list: "**the lemma $\theta$ large $\Rightarrow\lVert K\rVert_F$ large**", i.e. the candidate $\theta\le C\lVert K(F)\rVert_F$ holding in a fixed frame. It was a wanted lemma, never a proved one.

**Nothing on the record relies on it**, and I checked in both directions. The only fixed-frame statement carrying a number is [post F29](../findings/INDEX-traps.md) in [target.md](../findings/target.md) ("$\lambda\le\mu_{\max}(K)$ in a fixed frame cannot bound $\theta$"), a *different* statement, already recorded as a fence post, i.e. already known false. So **nothing breaks**; the defect is that a reader cannot follow the pointer, and the phrase "the fixed-frame lemma" reads as naming a retracted result when it names an abandoned wish.

## 4. The two comparison claims

### 4.1 $(2m+1)/2$ times the generic value, confirmed, and the generic value derived

The block quotes $\mathbb E_F\lVert K(F)\rVert_F^2=\frac{12}{(n+1)(n+2)}\lVert M\rVert_F^2$ without derivation. **I derived it, since the arithmetic check is worthless if the input is wrong.**

By $O(n)$-invariance the average is $c_n\lVert M\rVert_F^2$ for a universal $c_n$, since $\lVert W\rVert^2$ is the only quadratic $O(n)$-invariant of a Weyl tensor. To pin $c_n$: for independent Gaussians $x,y\sim N(0,I_n)$, antisymmetry gives $W(x,y,x,y)=\lvert x\rvert^2\lvert y_\perp\rvert^2\,W(u,v,u,v)$ with $(u,v)$ a uniform orthonormal pair independent of the radii, so

$$\mathbb E\big[W(u,v,u,v)^2\big]=\frac{\mathbb E\big[W(x,y,x,y)^2\big]}{\mathbb E[\chi^2_n]^{(2)}\;\mathbb E[\chi^2_{n-1}]^{(2)}}=\frac{A}{n(n+2)(n-1)(n+1)} .$$

For the numerator, Isserlis gives $\mathbb E[x_ix_kx_px_r]=\delta_{ik}\delta_{pr}+\delta_{ip}\delta_{kr}+\delta_{ir}\delta_{kp}$; **tracelessness of $W$ annihilates every term carrying $\delta_{ik}$ or $\delta_{jl}$**, leaving four, of which two give $\lVert W\rVert^2$ outright and two give $B=\sum W_{ijkl}W_{ilkj}$. First Bianchi fixes $B$: substituting $W_{ijkl}=-W_{iklj}-W_{iljk}$ into $\lVert W\rVert^2$ and relabelling shows the two resulting sums are equal, so each is $-\tfrac12\lVert W\rVert^2$, and $B=+\tfrac12\lVert W\rVert^2$ by the last-pair antisymmetry. Hence $A=3\lVert W\rVert^2$ and

$$\mathbb E_F\lVert K(F)\rVert_F^2=n(n-1)\cdot\frac{3\lVert W\rVert^2}{n(n-1)(n+1)(n+2)}=\frac{3\lVert W\rVert^2}{(n+1)(n+2)}=\frac{12\,\lVert M\rVert_F^2}{(n+1)(n+2)} .$$

**The block's generic value is confirmed, analytically.** A second, independent route agrees: through the $Q_4$ reformulation of §2.2, a random frame makes each row of $A$ a unit vector in $f_a^\perp$, giving $\mathbb E[Q_4]=2m\cdot\frac3{2m+1}=\frac{6m}{2m+1}$, and $9\mathbb E[Q_4]-\frac{18m}{2m-1}$ divided by $\lVert M\rVert_F^2$ returns $\frac{12}{(2m+1)(2m+2)}$ exactly.

The ratio is then arithmetic:

$$\frac{3/(m+1)}{12/\big((2m+1)(2m+2)\big)}=\frac{3(2m+1)\cdot2(m+1)}{12(m+1)}=\frac{2m+1}{2},$$

which is $6.5$ at $m=6$. **The block's arithmetic closes.** A screening evaluation of the two closed forms at $m=2,\dots,8$ returns $2.5,3.5,\dots,8.5$, confirming the identity has no off-by-one.

### 4.2 But "a *high*-spread family, $6.5\times$ generic" does not follow

**This is the one place where correct arithmetic supports a false impression.** $\kappa^2$ is a **maximum** over frames; the block's "generic value" is, by its own definition, the **mean** over frames. A maximum exceeding a mean by $6.5\times$ says nothing about whether a tensor is high-spread, because every tensor's maximum exceeds its own mean.

The like-for-like comparison is in the same sentence and points the other way. The block's own random-tensor figure is $\kappa^2\approx0.372$ at $n=12$, against a mean of $\frac{12}{13\cdot14}=0.0659$, a ratio of $5.6$. So $\mathbb{CP}^6$'s $6.5$ sits barely above what a random Weyl tensor already does, and the honest max-against-max statement is $0.4286$ versus $0.372$: **a factor $1.15$, not $6.5$.** "Not the $\kappa$-minimiser" is exactly right and is what the $0.372$ supports; "**not even low-$\kappa$**" and "**a *high*-spread family**" are not supported by anything in the block.

There is a further tension the block does not resolve. The same file's earlier text established $\kappa(\mathbb{CP}^m)\to0$ and used it to refute $\theta\le C\kappa$; the correction now calls the family high-spread. Both readings are true of $3/(m+1)$ against different baselines (absolutely it vanishes, relative to the frame-mean $\sim3/m^2$ it diverges) and **a reader given only "a *high*-spread family" is left with the wrong one.**

### 4.3 $0.4286$, and whether the block distinguishes its two kinds of number

$3/(6+1)=0.428571$: **consistent with the closed form**, and it is now the proved value rather than a measured one.

The $0.372$ is a sampled minimum over 12 random tensors used to support a *negative* claim, that $\mathbb{CP}^m$ is not the minimiser. **That is a legitimate use of numerics**, since one witness below $0.4286$ settles it. **The block does not distinguish the two.** It sets "$\kappa^2\approx0.372$" and "$\mathbb{CP}^6$'s $0.4286$" side by side in one clause with no mark of their different standing, one a sampled witness, the other an identity. The same paragraph's "$6.5\times$ generic" is a third kind, an exact ratio of two closed forms. Three epistemic grades in one sentence, typographically identical.

## 5. The threshold claim

### 5.1 Parity: safe, and confirmed

$\mathbb{CP}^m$ has $n=2m$, always even. [conventions.md](../findings/conventions.md) line 19 fixes $\Theta_n=\theta_0(n)$ at even $n$, with the two separating only at odd $n$ where $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$. **So writing $\theta_0(2m)$ where the diagonal maximum is $\Theta_{2m}$ is correct here, and the failure mode that refuted a neighbouring result cannot arise**, no odd $n$ is in range. Confirmed.

### 5.2 The claim is stronger than the block states: it is a theorem

Both closed forms are on the record, $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$ at [nondegeneracy.md](../findings/nondegeneracy.md) line 514 and [graded-half.md](../findings/graded-half.md), derived there from Fox, and $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at [conventions.md](../findings/conventions.md), so the comparison needs no table:

$$\frac{\theta^2(\mathbb{CP}^m)}{\theta_0(2m)^2}=\frac{(m+1)(2m-1)}{3m(m-1)}\cdot\frac{4m^2}{2(2m-1)(2m-2)}=\frac{m(m+1)}{3(m-1)^2},$$

and this is $<1$ exactly when $3(m-1)^2-m(m+1)=2m^2-7m+3=(2m-1)(m-3)>0$, i.e. **exactly when $m>3$.** So:

- $\theta(\mathbb{CP}^m)<\theta_0(2m)$ for every $m\ge4$, **confirmed as a theorem, not a table of six rows**;
- $m=3$ is an exact tie, $\theta^2=\theta_0(6)^2=\tfrac{10}9$, which [INDEX-values.md](../findings/INDEX-values.md) line 24 already records;
- $m=2$ is strictly above, $\sqrt{3/2}$ against $\theta_0(4)=0.866$, which is why padded $W_{\mathbb{CP}^2}$ is the record's threshold object;
- the ratio $\to1/\sqrt3=0.577$, so **the margin widens without bound**, a fact the block's "for every $m\ge4$" understates.

### 5.3 The $25\%$ at $n=12$ refers to $\mathbb{CP}^6$, and the block does not conflate

At $m=6$ the ratio of squares is $\frac{6\cdot7}{3\cdot25}=\frac{42}{75}=0.56$, so $\theta(\mathbb{CP}^6)/\theta_0(12)=\sqrt{0.56}=0.74833$: **$25.2\%$ below. The block's "$25\%$" is correct and is correctly about $\mathbb{CP}^6$.**

The brief's suspected conflation is **not present**. Padded $W_{\mathbb{CP}^2}$ at $n=12$ has $\theta=\sqrt{3/2}=1.2247$ against $\theta_0(12)=1.2360$, a shortfall of $0.9\%$, a different object with a different number, and the block's sentence quantifies over $m$ with $n=2m$, so $n=12$ unambiguously names $\mathbb{CP}^6$. Confirmed clean.

### 5.4 The follow-on clauses

- **"Its small-$\kappa$ members are the ones furthest below threshold", confirmed, and it too is a theorem.** $\kappa^2=3/(m+1)$ is strictly decreasing in $m$ and $\theta/\theta_0(2m)=\sqrt{m(m+1)/3}/(m-1)$ is strictly decreasing in $m$ for $m\ge2$, so the two orderings coincide exactly. The block asserts it; it follows from the two closed forms in one line.
- **"$\mathbb{CP}^{n/2}$ is the lemma's sharpness case (ratio ascent approaches its $\theta/\kappa$ from below and never beats it"), a numerical claim printed as a settled one.** Its source is r101's constrained-ascent table, which r101 explicitly caps: "The search is local and gives lower bounds only, so this is evidence, not proof." **The block strips that clause.** Hedge instance ten.
- **The scope note "only against a constant uniform in $n$ ... says nothing about a per-$n$ constant $C_n$", confirmed**, and it faithfully carries r101's Claim 4(ii) correction, including r101's candidate $C_n=\theta_0(n)\sqrt{(n+2)/6}$, which the block sensibly omits as unaudited.

## 6. Pointers

The L95 block contains **no markdown links at all**, in a file where every neighbouring block links its reviewers, its scripts and its conventions. Specifically: "Reviewer 101" is not linked to [REVIEW_r101.md](REVIEW_r101.md); the minimisation table behind $\min_F=0$ is not linked to r101 either; "the fixed-frame lemma" names no target (§3.3); the generic value $\frac{12}{(n+1)(n+2)}\lVert M\rVert_F^2$ is stated with no derivation and no source, and appears nowhere else on the record; and $\theta(\mathbb{CP}^m)$ is used without pointing at the closed form that [nondegeneracy.md](../findings/nondegeneracy.md) and [graded-half.md](../findings/graded-half.md) carry. **Nothing resolves incorrectly; almost nothing resolves at all.**

## 7. What is owed

1. **Nothing on the closed form.** §2.2 supplies the proof. The block's statement is true, and the `Lemma` label is now correct for the reason it should have been correct all along.
2. **The block's support sentence needs replacing**, since it credits r101 with a global result r101 declined to claim and omits r102, who supplied the $m=2,\dots,7$ figure the block quotes.
3. **[INDEX-results.md](../findings/INDEX-results.md) row 95 and [LEDGER.md](../findings/LEDGER.md) line 1325 are wrong about L95's Gate 2**, in the opposite direction from the block. Both r101 and r102 audited it directly.
4. **$\min_F\lVert K(F)\rVert_F=0$ should be demoted** from an identity to a conjecture with a dimension-count heuristic, and its $3$–$5\times10^{-4}$ unconverged rows shown. It is reachable analytically and needs no run.
5. **"A *high*-spread family, $6.5\times$ generic" should go**, being a maximum measured against a mean; the supportable statement is $0.4286$ against a random tensor's $0.372$.
6. **Two hedges belong back**: r101's "the search is local and gives lower bounds only" on the sharpness claim, and "still descending" on the minimisation.

---

*Reviewer A, review 615. Independent of the concurrent reviewer on the identical brief, whose report and log were not read. Derived cold from [conventions.md](../findings/conventions.md); no sweeps, searches or frame sampling were run, in accordance with the analysis-only rule. Log at [agent_logs/audit-L95-a.log](../agent_logs/audit-L95-a.log).*
