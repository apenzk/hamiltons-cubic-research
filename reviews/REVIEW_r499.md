# REVIEW r499, Lemma L57, "the diagonal theorem, all $n$, both parities"

**Target:** [findings/problem.md](../findings/problem.md), the `#### Lemma L57` block (line 499) through the end of file.
**Reviewer:** r499, cold audit, every step re-derived from the definitions rather than read off the record. Analysis-only footing; the one numerical run below is a screen of claims I derived by hand first, reported as a screen.

**VERDICT: PLAUSIBLE.** *The theorem is true, I re-derived every step and both constants independently, and verified that the claimed maximisers attain them, but the record does not carry a complete proof of it.* Two load-bearing steps are absent from the record entirely, and one displayed identity that the constant $\Theta_n$ is computed from has numerical support only. Both holes are filled inside this review, in under fifteen lines together, so the repair is short; but until they are folded in, **[results.md](../results.md) line 12's "Proven" and [INDEX-results.md](../findings/INDEX-results.md)'s `Lemma` label both outrun the record.**

---

## 1. The pointer: is there a proof anywhere?

The block's only pointer reads *"the argument is in this file under 'What remains owed: steps 1 and 3 as proofs'"*.

**That section exists** ([problem.md](../findings/problem.md) line 299) **and its title is stale.** Its body opens *"Step 3 IS CLOSED, at both parities"* and gives two independent proofs. Step 1's proof is not there at all, it is 44 lines further down under a different heading, *"Step 1 is PROVED, and it IS the record's own Dirichlet inequality"* (line 343). So a reader who follows the pointer lands on a heading that says the opposite of the truth, reads a proof of step 3, and never learns that step 1 has one.

**Where the argument actually lives, six sections, of which the block names one, wrongly:**

| piece | where | status |
| --- | --- | --- |
| the three-step chain, stated | line 232 (`## CANDIDATE …, Gate 2 owed`) | statement of the chain only |
| step 1, $\lambda\le\frac{n-1}n\mu$ | line 343 | **proved**, I checked it, correct |
| step 2(a), $Z(v)\in\mathcal D_n$ | line 244 | **proved**, correct |
| step 2(b), $Z$ is the orthogonal projection | line 244 | **proved**, correct |
| step 2, the identity $\lVert Z(v)\rVert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$ | line 232 | **numerics only**, "verified to $10^{-12}$ at $n=6,7,8,11,12$". See §3. |
| step 3, the fourth-moment lemma | line 299 | **proved twice** (Gate 2, Reviewers 123 and 124), I checked Proof I, correct |
| the chaining arithmetic $\lambda^2\le(\frac{n-1}n)^2\cdot4\lVert Z\rVert^2_{\max}=\Theta_n^2$ | line 232 | asserted; I re-derived it, correct at both parities |
| equality case, even $n$ | line 244 (c) | ratio checked numerically at $n=6,8,10,12$; the structural reason is in an unlinked bullet at line 336 ("Claim 5") |
| equality case, odd $n$ | line 287 (d) | **derived symbolically in $n$**, correct |
| critical point $\Rightarrow$ every $W$ | **nowhere** | see §4 |
| why $D$ is diagonal (no row-sum multiplier) | **nowhere** | see §4 |

So: **the answer to "is there a complete proof" is no, but the shortfall is two short missing steps and one un-derived identity, not a missing argument.** Nothing here is a citation standing in for a proof, and nothing is a sketch.

## 2. The chain, re-derived cold, it is correct

I rebuilt all of it from the definitions. Everything in this section is my own derivation, agreeing with the record.

**Step 1.** Criticality on $\mathcal D_n\cap\{\lVert S\rVert=1\}$ reads $S^{\circ2}+S^2=\lambda S+D$. Its diagonal is forced: $(S^{\circ2})_{ii}=0$, $(S^2)_{ii}=r_i:=\sum_j s_{ij}^2$, $S_{ii}=0$, so $D=\operatorname{diag}(r_i)$. Pairing with $v\otimes v$ where $Sv=\mu v$, $\lvert v\rvert=1$, $v\perp\mathbf1$, and using $\sum_i r_iv_i^2=\tfrac12\sum_{i,j}s_{ij}^2(v_i^2+v_j^2)$:
$$\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2.$$
The two contractions are $\sum_{i<j}s_{ij}(v_i-v_j)^2=-v^{\mathsf T}Sv=-\mu$ (row sums, hollowness) and $\sum_{i<j}(v_i-v_j)^2=n\sum v^2-(\sum v)^2=n$. Cauchy–Schwarz then gives $\mu^2\le n\sum_{i<j}s^2(v_i-v_j)^2$, hence $\lambda\mu\le\frac{n-1}n\mu^2$, hence $\lambda\le\frac{n-1}n\mu$ once $\mu>0$, which holds because $S$ is hollow, so $\operatorname{tr}S=0$, so a nonzero $S$ has a positive top eigenvalue. **Correct.**

**Step 2.** $\mu=v^{\mathsf T}Sv=\sum_{i\ne j}s_{ij}v_iv_j=2\sum_{i<j}s_{ij}v_iv_j=2\langle S,P\rangle$ with $P_{ij}=v_iv_j$ off-diagonal, and $\langle S,P\rangle=\langle S,Z\rangle$ since $S\in\mathcal D_n$. The record's 2(a) and 2(b) are both right: the residual $P-Z$ is $a_i+a_j+c$ off-diagonal, the constant $c$ absorbs into $a_i=c/2$, and $\sum_{i<j}(a_i+a_j)T_{ij}=\sum_ia_i\cdot(\text{row sum of }T)=0$ for every $T\in\mathcal D_n$. **Correct.**

**The norm identity, which the record does not derive.** Since $Z=\Pi_{\mathcal D_n}P$, we have $\lVert Z\rVert_F^2=\langle Z,P\rangle_F=\sum_{i\ne j}Z_{ij}v_iv_j$. With $m_1=0$, $m_2=1$, the three sums are $\sum_{i\ne j}v_i^2v_j^2=1-m_4$, $\sum_{i\ne j}(v_i^2+v_j^2)v_iv_j=2(m_3m_1-m_4)=-2m_4$, $\sum_{i\ne j}v_iv_j=-1$, giving
$$\lVert Z\rVert_F^2=(1-m_4)-\frac{2m_4}{n-2}+\frac1{(n-1)(n-2)}=\frac{n^2-3n+3}{(n-1)(n-2)}-\frac n{n-2}\,m_4 .$$
The record's stated $\lVert Z\rVert^2$ is exactly half of this, i.e. the record's norm is the **unordered** pair sum $\sum_{i<j}$, consistent with its $\mu=2\langle S,Z\rangle$. **The identity is correct.** This four-line derivation is what the record is missing; see §3.

**Step 3.** Proof I is correct as written. Newton with $e_1=0$ gives $p_2=-2e_2$ and $p_4=-e_2p_2=p_2^2/2$, so the quartic is constant on the circle $C=\{\sum t=0,\sum t^2=\sigma\}\subset\mathbb R^3$. Lagrange gives $4v_i^3=\alpha+2\beta v_i$, a depressed cubic, so at most three values summing to zero. If a global minimiser has exactly three, replacing one representative of each by a generic point of $C$ preserves both constraints and the objective, so the result is still a global minimiser; only finitely many points of $C$ are excluded (each "two entries equal" or "entry equals an old value" is a line meeting the circle twice), and with $n\ge4$ some coordinate is untouched, so the new vector has $\ge4$ distinct values, contradicting "at most three". Hence at most two, and $\sum v^4=\frac n{pq}-\frac3n$, minimised at $pq=\lfloor n/2\rfloor\lceil n/2\rceil$. **Correct, and genuinely parity-blind.**

**The chaining.** $\lambda^2\le\frac{4(n-1)^2}{n^2}\lVert Z\rVert^2_{\max}$.
- Even: $m_4\ge1/n$ gives $\lVert Z\rVert^2_{\max}=\frac{(n-2)^2}{2(n-1)(n-2)}=\frac{n-2}{2(n-1)}$, hence $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$. **Checks.**
- Odd: $m_4\ge\frac{n^2+3}{n(n^2-1)}$ gives numerator $(n^2-3n+3)(n+1)-(n^2+3)=n^2(n-3)$, so $\lVert Z\rVert^2_{\max}=\frac{n^2(n-3)}{2(n-1)(n-2)(n+1)}$, hence $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$. **Checks.**

## 3. GAP 1, the constant rests on an identity the record only checked numerically

`grep` for `n^2-3n+3` across [findings/](../findings/), [results.md](../results.md) and [ATTEMPTS.md](../ATTEMPTS.md) returns [problem.md](../findings/problem.md) alone, at the line that states the formula and immediately adds *"the projection and the norm formula both verified to $10^{-12}$ at $n=6,7,8,11,12$"*. [diagonal-half.md](../findings/diagonal-half.md) does not carry it.

**$\Theta_n$ is that formula evaluated at the $m_4$ minimum, and nothing else.** So under this record's own literal labels, *"**Observation** is verified numerically at the dimensions stated"* ([INDEX-results.md](../findings/INDEX-results.md)), L57's constant currently rests on an Observation. The derivation in §2 above closes it; it should be pasted into the block.

## 4. GAP 2, the theorem is about every diagonal $W$; the argument is about critical points only

The chain opens *"at a critical point $Q(S)=\lambda S$"*. The statement quantifies over **every** diagonal $W$. Two steps bridge them and **neither appears anywhere in the record**:

**(i) The compactness step.** $\{S\in\mathcal D_n:\lVert S\rVert=1\}$ is compact and $P$ continuous, so the max is attained; at the maximiser the first-order condition holds, and $\langle Q(S),S\rangle=\langle\lambda S+D,S\rangle=\lambda$ because $D$ is diagonal and $S$ hollow. So $\max P=\lambda_{\max}\le\Theta_n$, and homogeneity plus the oddness of $P$ extend it to all $W$. One sentence, currently unwritten.

**(ii) Why $D$ is diagonal, the step that makes the criticality equation right, and it is nowhere on the record.** $\mathcal D_n$ is cut out of the hollow symmetric matrices by the $n$ linear constraints $S\mathbf1=0$, whose multipliers contribute an off-diagonal term $a_i+a_j$, as the record's **own** step 2(b) proves, $\{a_i+a_j\}$ is exactly $\mathcal D_n^\perp$. So the Lagrange equation should read $S^{\circ2}+S^2=\lambda S+D+(a_i+a_j)$, and pairing *that* with $v\otimes v$ adds $-2\sum_ia_iv_i^2$ of unknown sign to the identity $(*)$, breaking step 1.

*It happens that the multipliers vanish identically, so the record's equation is correct:* $S\mathbf1=0\Rightarrow S^2\mathbf1=0$, and $(S^2)_{ii}=r_i=\sum_{j\ne i}s_{ij}^2$, so the row sums of the off-diagonal part of $S^{\circ2}+S^2$ are $r_i+(0-r_i)=0$. **$Q$ preserves $\mathcal D_n$, so the projection in the criticality condition is trivial.** That is the missing line. Without it the block's *"$Q(S)=\lambda S$, which is the record's own $S^{\circ2}+S^2=\lambda S+D$"* is an assertion with a visible objection against it.

## 5. GAP 3, the block never says which pair-sum normalisation $\lVert S\rVert=1$ means

[conventions.md](../findings/conventions.md) states the default plainly: *"**Sums over pairs are over ORDERED pairs unless the line says otherwise.**"* Under that reading $\lVert S\rVert^2=\sum_{i\ne j}s_{ij}^2=1$, and every value in the chain moves by a factor $2\sqrt2$.

The chain needs the **unordered** reading, $\mu=2\langle S,Z\rangle$ and the stated $\lVert Z\rVert^2$ are both $\sum_{i<j}$, and conventions.md's own vertex-matrix row confirms it from the other side ($\lVert K\rVert_F^2=2$ at a unit Weyl tensor, i.e. $\sum_{a<b}K_{ab}^2=1$). **The block says neither.** This is precisely the class of trap conventions.md exists to prevent, and it is live in the block that carries the programme's starting hypothesis.

## 6. Small cases by hand, and the equality cases, all attain

Computed by hand from the block-constant ansatz ($x$ within $A$, $y$ within $B$, $z$ across; $(p-1)x+qz=0$, $(q-1)y+pz=0$; normalised by $\sum_{i<j}s^2=1$; $P=\sum_{i<j}(s_{ij}^3+(S^2)_{ij}s_{ij})$):

| $n$ | claimed maximiser | $P$ computed by hand | $\Theta_n$ | agrees |
| --- | --- | --- | --- | --- |
| 4 | $S^2\times S^2$ | $36t^3$ at $t=1/\sqrt{12}$, $=\sqrt3/2$ | $\sqrt{12/16}=\sqrt3/2$ | yes |
| 5 | $S^2\times S^3$ | $72z^3$ at $z=1/\sqrt{18}$, $=2\sqrt2/3$ | $\sqrt{16/18}=2\sqrt2/3$ | yes |
| 6 | $S^3\times S^3$ | $112.5\,z^3$ at $z^2=1/22.5$, $=\sqrt{10}/3$ | $\sqrt{40/36}=\sqrt{10}/3$ | yes |

*Screen* (seconds of compute, on matrices I constructed to check the three hand computations above, reported as a screen and not as evidence): the same construction at $n=4,\dots,12$ reproduces $\Theta_n$ to machine precision at both parities, with row sums $\le10^{-16}$. So **the bound is attained**, at both parities, and the normalisation reading of §5 is the one that makes $\Theta_n$ come out.

**$\Theta_n=\theta_0(n)$ at even $n$: confirmed.** $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is literally the even formula. **And the [conventions.md](../findings/conventions.md) $\Theta_n$ row now agrees with the block**, the row carries $\sqrt{\cdot}$ at odd $n$ and the block states $\Theta_n^2$; squaring is handled consistently, and the missing-square-root defect flagged in that row is repaired. At odd $n$, $\Theta_n<\theta_0(n)$ as it must be ($\Theta_5=0.942809$ against $\theta_0(5)=0.979796$).

*One residual wording defect in that row's neighbour:* $\theta_0(n)$ is defined as *"the value at the balanced sphere product"*, which at odd $n$ is a value at an object that does not exist. It is a formula there, not a value.

## 7. The domain $\mathcal D_n$, the correspondence is exact

Verified in both directions, and it is a bijection.

- **Every hollow symmetric $S$ is a genuine algebraic curvature operator.** First Bianchi $R_{ijkl}+R_{iklj}+R_{iljk}=0$ holds: for four distinct indices all three terms vanish since each needs its two index pairs to coincide; for $l=i$ and $j\ne k$ the first two vanish for the same reason and the third by antisymmetry.
- **Ricci-flat $\iff S\mathbf1=0$.** Off-diagonal Ricci $\sum_jR_{ijkj}$ needs $\{i,j\}=\{k,j\}$, so it vanishes identically; the diagonal Ricci is the row sum. For an algebraic curvature operator, trace-free is exactly Ricci $=0$.

So $\mathcal D_n$ **is** the set of vertex matrices of coordinate-diagonal elements of $\mathcal W_n$, with no gap either way. $\dim\mathcal D_n=\binom n2-n$, which is $2$ at $n=4$ and $0$ at $n=3$, so $n\ge4$ is the right floor, and the block's $n\ge5$ caveat on odd uniqueness concerns the fourth-moment lemma alone (at $n=3$ Lemma A makes $\sum v^4$ constant), never the theorem.

**Homogeneity.** $\langle Q(W),W\rangle$ is cubic and $\lVert W\rVert^3$ is cubic, so the inequality is homogeneous as written and imposing $\lVert S\rVert=1$ costs nothing; $P$ is odd, so the sign-flipped point is a minimiser and needs no separate treatment. **Unit norm is imposed on $S$** (at line 232), not on $W$, the two agree only through §5's unstated convention.

## 8. Uniqueness, proved, and the phrasing is loose in one place

Equality in the chain forces equality in all three inequalities. From $\mu\le2\lVert Z(v)\rVert$: $S$ is a positive multiple of $Z(v)$. From the $m_4$ bound: $v$ is two-valued with multiplicities $\lfloor n/2\rfloor,\lceil n/2\rceil$. Then the **structural** step, the third bullet of *"Two corrections"* (line 336), that block-constant elements of $\mathcal D_n$ form a **one-dimensional** space because $(p-1)x+qz=0$ and $(q-1)y+pz=0$, forces $Z(v)$ proportional to the sphere product's vertex matrix, with no computation. **That is a complete uniqueness proof**, and it also retires the numerical ratio checks of (c).

Two defects of presentation:
- **The group is coordinate permutations $S_n$**, extended to the full $O(n)$-orbit because "diagonal" means diagonal in *some* frame and $P$, $\lVert\cdot\rVert$ are $O(n)$-invariant. The record never names it.
- **"up to sign and permutation" (line 374) is wrong on the sign.** $P$ is odd, so $-S$ is a *minimiser*. The sign appears only because the record's vertex matrix $V$ carries the opposite convention, *"Two corrections"* records $Z(v)=\lambda V$ with $\lambda<0$, so the maximiser is $S=-V/\lVert V\rVert$. It should read "up to permutation", with the sign folded into the convention.

## 9. The two pre-registered questions transferred from ROUND_L00, both answered, neither damages the theorem

- **F7** *("(c)'s two-value ratio matches every split $k+l=n$, so it singles out no split; balancedness is an input rather than an output")*, **correct as an observation, harmless as a criticism.** Balancedness is an output of **step 3**, not of (c); (c)'s only job is to identify *which geometric object* $Z(v)$ is, and the Claim 5 argument of §8 does that for every $(p,q)$ at once. F7 is closed.
- **F8** *("the computation covers even $n$ only")*, **answered by section (d)** (line 287), which does the odd equality case symbolically in $n$ and post-dates the finding. F8 is closed.

## 10. Consistency with the rest of the record

**A live symbol collision: $\Theta_5$ carries two different numbers inside [results.md](../results.md).**

| line | statement | value |
| --- | --- | --- |
| [results.md](../results.md) lines 23, 40, 204, 590 (Lemma L61) | "$\Theta_5=\sqrt{3/2}$ … on all of $\mathcal W_5$" | $1.224745$ |
| [results.md](../results.md) lines 88, 98, 270 + [conventions.md](../findings/conventions.md) (Lemma L57) | $\Theta_5^2=2\cdot4\cdot2/(6\cdot3)=8/9$ | $0.942809$ |

Both statements are **individually true**, L61 is the global maximum over $\mathcal W_5$, attained on the padded $\mathbb{CP}^2$ orbit, which is diagonal in no frame; L57 is the maximum over the diagonal locus. But [conventions.md](../findings/conventions.md) defines $\Theta_n$ as *"the diagonal maximum"*, so **L61's row as written contradicts L57's constant**, 65 lines apart in one file. This is the same class as the $B$, $M$ and $\mu$ collisions that file already tables, and it belongs in that section. The repair is to rename L61's quantity.

**Everything else is consistent.** [results.md](../results.md) line 88 and line 270, [findings/INDEX.md](../findings/INDEX.md) line 28, [LEDGER.md](../findings/LEDGER.md) lines 27 and 430 all state the same two formulas, the same equality case, and the same range $n\ge4$. No competing $\Theta_n$, equality case or range exists. *One cosmetic contradiction:* [INDEX.md](../findings/INDEX.md) line 19 says "Proved outright at every $n\ge4$, odd included" and ends the same cell with "Odd $n$ open", the second clause is about the published literature's coverage, but reads as a contradiction of the first.

## 11. The label the statement is entitled to

The record's convention is literal: *"**Lemma** is proven, Gate 1 and Gate 2 passed."*

- **Section 232's own heading says `Gate 2 owed`, and its first line says *"every step below was rebuilt and screened here (Gate 1 (a)–(d)), none audited"*.**
- **Gate 2 ran on step 3 alone**, Reviewers 123 and 124, on the fourth-moment lemma. No Gate 2 verdict exists for steps 1, 2, the chaining, or either equality case.
- **[plan-verification.md](../plan-verification.md) has L57 unticked in tier 0**, carrying F7 and F8 as open questions.
- **[INDEX-results.md](../findings/INDEX-results.md) row 57 nonetheless reads `Lemma`, with no status caveat**, unlike row 1, which carries its Gate 2 outcome in full.

**Entitled label, as the record stands: `Lemma` is not yet earned, and `Observation` understates it.** The honest row is `Lemma` **with the caveat carried in the row**, the shape [INDEX-results.md](../findings/INDEX-results.md) already uses for row 1, reading: *Gate 2 on step 3 only; §§3–5 of [r499](REVIEW_r499.md) name three gaps and supply all three; one independent cold reconstruction agrees with every step and both constants.* Once §§3–5 are folded into the block, `Lemma` is earned outright and this review is one of the two Gate 2 passes.

**On [results.md](../results.md) line 12's "Proven by this record's own theorem (Lemma L57)":** the word is defensible about the *mathematics*, which I reconstructed end to end and found sound, and indefensible about the *record*, which does not contain the reconstruction. Until the block is repaired the row should read **"Proved, with three short steps supplied at audit and not yet folded in"**. The programme's starting hypothesis is not in danger, but it is, today, resting on an argument a reader cannot follow from the record alone.

## 12. What to change, in order

1. **Fix the pointer** in the L57 block. It names one section, whose title is stale, and omits the four others that carry the argument. Give the table of §1.
2. **Paste the $\lVert Z\rVert^2$ derivation** (§2) into the block, replacing "verified to $10^{-12}$".
3. **Add the two missing steps** (§4): the compactness bridge, and the one-line proof that $Q$ preserves $\mathcal D_n$ so the row-sum multipliers vanish and $D$ is diagonal.
4. **State the pair-sum convention** in the block (§5), it is the unordered one, against conventions.md's default.
5. **Rename L61's $\Theta_5$** (§10), and table the collision in [conventions.md](../findings/conventions.md)'s "words with more than one meaning".
6. **Fix "up to sign and permutation"** at line 374 (§8), and retitle section 299, whose heading now says the opposite of its content.
7. **Close F7 and F8** in [plan-verification.md](../plan-verification.md) with §9.
