# Review r368, Lemma L125 and Post F46

Gate 2, cold brief, arguing from the definitions in [second-order.md](../findings/second-order.md), [DERIVE-mx1.md](DERIVE-mx1.md), [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) and the conventions in [adversarial_check1.py](../scripts/lib/adversarial_check1.py). **Analysis only.** One screen was run, seconds of compute on objects built for the purpose, to check a number I was about to record about padded $\mathbb{CP}^2$; it is reported as a screen and is never the ground of a positive claim.

## Verdicts

| Claim | Verdict |
|---|---|
| **W1** the inequality itself | **CONFIRMED as true, REFUTED as new content**, it is *exactly* equivalent to [Lemma L24](../findings/second-order.md), and the equality at $Y=W$ is vacuous |
| **W2** the expansion | **CONFIRMED**, re-derived independently, every coefficient agrees |
| **W3** agreement with Krasnov–Tkachev | **REFUTED as stated**, KT's printed $2L_c-1\le c\otimes c$ is false at $\lVert c\rVert\ne1$, by KT's own formula (56); the project's constants are right and the record has silently repaired the source without saying so |
| **W4** the four-set application | **CONFIRMED** on arithmetic and on the identification with [DERIVE-mx1](DERIVE-mx1.md)'s $\rho$; the "now *proved* rather than introduced as a correction" gloss is **REFUTED** |
| **W5** the route closure | **REFUTED**, both numbers are wrong, "no member is excluded" is false, and the composition is empty for a reason the post misses |
| **W6** $c=1$ at padded $\mathbb{CP}^2$ | **REFUTED**, $c=1/\sqrt2$, and the slack factor is $2.25$, which is what this same file records two paragraphs earlier |

---

## W2, the expansion is right, coefficient by coefficient

Re-derived without reading the write-up's algebra. With $T(x,y,z)=\langle x\circ y,z\rangle$ fully symmetric (the symmetry is what [T_full](../scripts/lib/adversarial_check1.py) tests) and $P(X)=T(X,X,X)$:

$$P(W+tY)=T(W,W,W)+3t\,T(W,W,Y)+3t^2\,T(W,Y,Y)+t^3T(Y,Y,Y),$$

and $T(W,W,Y)=\langle Q(W),Y\rangle=\theta\langle W,Y\rangle$ by criticality, $T(W,Y,Y)=\langle Y,W\circ Y\rangle$. **Agrees.**

With $u=2t a+t^2b$, $a=\langle W,Y\rangle$, $b=\lVert Y\rVert^2$ and $\lVert W\rVert=1$: $(1+u)^{-3/2}=1-\tfrac32u+\tfrac{15}8u^2+O(u^3)$ gives $1-3ta-\tfrac32t^2b+\tfrac{15}2t^2a^2$. **Agrees.**

The $t^2$ coefficient of the product collects three terms, $\theta\big(-\tfrac32b+\tfrac{15}2a^2\big)$, the cross-term $3\theta a\cdot(-3a)=-9\theta a^2$, and $3\langle Y,W\circ Y\rangle$, and $\tfrac{15}2-9=-\tfrac32$:

$$[t^2]=3\langle Y,W\circ Y\rangle-\tfrac32\theta\lVert Y\rVert^2-\tfrac32\theta\langle W,Y\rangle^2 .$$

**Agrees exactly.** The $t^1$ coefficient is $3\theta a-3\theta a=0$ identically, as it must be for a degree-zero $f$ at a critical point, so $[t^2]\le0$ is legitimate. Dividing by $3\theta>0$ and using $W\circ Y=\theta L_eY$ gives W1. **No sign error, no stray factor of $3$, and $Q(W)=\theta W$ is used only in the linear term, where it holds.**

## W1, true, but it is L24 written twice

**The correction is that W1 is *equivalent* to [Lemma L24](../findings/second-order.md), not more general than it.** $L_e$ is self-adjoint (symmetry of $T$) and $L_eW=Q(W)/\theta=W$, so $W^\perp$ is $L_e$-invariant, KT prove exactly this line. Split $Y=\alpha W+Z$, $Z\perp W$; the cross term $\langle Z,L_eW\rangle=\langle Z,W\rangle$ vanishes, so

$$\text{LHS}=\alpha^2+\langle Z,L_eZ\rangle,\qquad \text{RHS}=\tfrac12(\alpha^2+\lVert Z\rVert^2)+\tfrac12\alpha^2=\alpha^2+\tfrac12\lVert Z\rVert^2 .$$

W1 $\iff$ $\langle Z,L_eZ\rangle\le\tfrac12\lVert Z\rVert^2$ for all $Z\perp W$, which **is** L24. The implication runs both ways, so the "general form the record carried only as a quotation" was already on the record in full, as L24 plus one line of orthogonal decomposition. That decomposition is not new either, [DERIVE-mx1](DERIVE-mx1.md)'s corrected I12 theorem performs it, which is how it got $\langle X,L_eX\rangle\le\tfrac12(1+c^2)$ in the first place.

**And the advertised equality at $Y=W$ is vacuous.** $Y=W$ is the radial direction; $f$ is degree-zero, so $f(W+tW)=f(W)$ identically and *every* jet coefficient vanishes for *any* degree-zero $f$ at *any* point. Directly: $3\langle W,W\circ W\rangle-\tfrac32\theta-\tfrac32\theta=3\theta-3\theta=0$, with no use of maximality, criticality or $\theta>0$. So "equality holds at $Y=W$" records that $W$ is a unit vector, and **[DERIVE-mx1](DERIVE-mx1.md)'s "the bound is sharp at $X=W$" inherits the same emptiness**: sharpness on the one direction the constraint is blind to is not sharpness.

**Is W1 vacuous overall?** No. Off the radial line it is L24, which is a real constraint. The vacuity is confined to the claim of *added generality* and to the equality case.

## W3, REFUTED: the source's printed inequality is wrong, and the record repairs it silently

Do the general-norm expansion, $c$ an idempotent of arbitrary norm $g=\lVert c\rVert$, $c\circ c=c$, so $\langle c^2;c\rangle=g^2$:

$$[t^2]\big(P\cdot\lVert\cdot\rVert^{-3}\big)=g^{-3}\Big(3\langle y,c\circ y\rangle-\tfrac32\lVert y\rVert^2-\tfrac32\frac{\langle c,y\rangle^2}{g^2}\Big)\ \le\ 0 ,$$

i.e. **$2L_c-1\le\dfrac{c\otimes c}{\lVert c\rVert^2}=P_c$, the orthogonal projector onto $c$.**

This is confirmed from KT's own algebra rather than mine. Their displayed (56), [kt-1801.00617.txt](https://arxiv.org/abs/1801.00617) line 1071, is

```
   1 2         2|x|4 Lx − hx2 ; xi|x|2 − 3|x|2 (x ⊗ x2 + x2 ⊗ x) + 5hx2 ; xix ⊗ x
   3 D f (x) =                                                                         . (56)
                                                |x|5
```

Substituting $x=c$, $c^2=c$, $\langle c^2;c\rangle=|c|^2$ gives numerator $2|c|^4L_c-|c|^4\mathrm{Id}-6|c|^2\,c\otimes c+5|c|^2\,c\otimes c=|c|^4\big(2L_c-1\big)-|c|^2\,c\otimes c$. **Their next line 1076 prints $2L_c-1\le c\otimes c$, dropping the $1/|c|^2$.**

**The dropped factor is not cosmetic here.** KT's own normalisation makes extremal idempotents the minimal-norm ones, $\lVert c\rVert=1/\theta$, the notes file states this. So at padded $\mathbb{CP}^2$, $e=W/\theta$ with $\theta=\sqrt{3/2}$ gives $\lVert e\rVert^2=2/3$, and KT's printed inequality tested on $Y=W$ reads $\langle W,(2L_e-1)W\rangle=1$ against $\langle e,W\rangle^2=1/\theta^2=2/3$: **$1\le 2/3$, false.** With the $1/\lVert c\rVert^2$ restored it reads $1\le1$, the equality L125 reports.

**So the corrections are:**

1. **L125's own constants are right**, they are the $P_c$ form, and the $\theta$-dependence cancels correctly.
2. **W3's claim of equivalence is false as stated.** L125 is *not* "KT's Proposition 6.6 in this project's normalisation"; it is KT's Proposition 6.6 **with a normalisation error in the source repaired**. Since L125's box exists precisely to assert that the quoted inequality and the derived one are the same statement, this is the box's load-bearing sentence and it is wrong.
3. **The repair should be recorded**, in [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) as well, whose "Proof mechanism" paragraph reproduces the erroneous $2L_c-1\le c\otimes c$ under a heading that says "verbatim". Nothing downstream breaks (KT only ever use the restriction to $c^\perp$, where both forms vanish) which is exactly why it survived transcription.

## W4, the arithmetic and the $\rho$ identification both hold

$\langle\hat X,L_e\hat X\rangle=\sqrt\Sigma/(2\theta)$ for the block's unit top eigenvector, so W1 gives $\sqrt\Sigma\le\theta(1+c^2)$ and, $\theta>0$, $\Sigma\le\theta^2(1+c^2)^2$. **Correct.**

**No repeat of the $\rho$ conflation r365 found.** [DERIVE-mx1](DERIVE-mx1.md)'s corrected theorem defines $c=\langle X,W\rangle$ and then writes $\theta^2(1+\rho^2)^2$ "with $\rho$ the $4$-set mass", and its sharpening line reads $\rho=\langle X,W\rangle=\langle X,R\rangle$. **I12's $\rho$ is the full-space overlap $\langle X,W\rangle$, which is W4's $c$.** (L124's $\rho^2:=\lVert W|_{\Lambda^2\langle S\rangle}\rVert^2$ is the different object; W4 does not touch it.)

**The gloss is wrong, though.** "Now *proved* from the second-order condition rather than introduced as a correction", I12's correction was already proved from the second-order condition: write $X=cW+X'$, apply L24 to $X'\perp W$, get $\langle X,L_eX\rangle\le c^2+\tfrac12(1-c^2)=\tfrac12(1+c^2)$. That is three lines in [DERIVE-mx1](DERIVE-mx1.md) and it is a proof. **This is corroboration by the same route, not by a second one**, which follows from W1 $\equiv$ L24 above.

One step does deserve credit and is correct: the LHS $=\sqrt\Sigma/(2\theta)$ needs $\langle\hat X,L_W\hat X\rangle=\langle\hat X,L_{\operatorname{diag}(M)}\hat X\rangle$, which is [Lemma L123](../findings/second-order.md), and the four-set block carries a single non-trivial sign character so L123 applies. Screened below and exact.

## W6, REFUTED: $c=1/\sqrt2$, and the slack is $2.25$

**Analytic.** On the half-flat family supported at $S$, with $V_+$ diagonal in the $\omega$-basis with entries $(A,B,C)$, $A+B+C=0$: expanding $\omega_a\otimes\omega_a$ in the coordinate-plane basis gives $W_{ij,kl}=A/2$, $W_{ik,jl}=-B/2$, $W_{il,jk}=C/2$ and diagonal entries $M_{ij}=M_{kl}=A/2$ etc. In the trace pairing $\langle X,Y\rangle=\operatorname{tr}(XY)$ that [structure_constants](../scripts/lib/adversarial_check1.py) fixes:

$$\lVert W\rVert^2=\underbrace{\tfrac12(A^2+B^2+C^2)}_{\text{diagonal, trivial character}}+\underbrace{\tfrac12(A^2+B^2+C^2)}_{\text{four-set block}}=\rho^2 .$$

**So $W$ puts exactly half of its mass in the four-set block, and $\lVert W_{\text{block}}\rVert=1/\sqrt2$ whenever $\lVert W\rVert=1$, at every member of the family, not just at $\mathbb{CP}^2$.** Since $c=\langle W,\hat X\rangle=\langle W_{\text{block}},\hat X\rangle\le\lVert W_{\text{block}}\rVert$,

$$\boxed{\;c^2\le\tfrac12,\qquad (1+c^2)^2\le\tfrac94\;}$$

with equality exactly when $\hat X\parallel(A,B,C)$. Solving $3A^2-p=\lambda A$ (and cyclic) with $A+B+C=0$ forces $A,B,C$ to be roots of one quadratic, hence two of them equal, **the $\mathbb{CP}^2$ point and nothing else**.

**Screen** (permitted: seconds, on objects built here, reported as a screen). Padded $\mathbb{CP}^2$ at $n=4$ and $n=5$, built from [structure_constants](../scripts/lib/adversarial_check1.py) / [Q_full](../scripts/lib/adversarial_check1.py) / [B_full](../scripts/lib/adversarial_check1.py):

| quantity | value |
|---|---|
| criticality residual $\lVert Q(W)-\theta W\rVert$ | $9.5\times10^{-16}$ |
| $\theta^2$, $\Sigma$ | $1.500000$, $1.500000$ |
| $L_W$ four-set block spectrum | $-0.612372,\ 0,\ +0.612372$ vs $\pm\sqrt\Sigma/2=0.612372$ |
| $W$'s signed block coordinates | $(A,B,C)/2$ exactly |
| top eigenvector, signed | $\propto(A,B,C)$ |
| $c=\langle W,\hat X\rangle$ | $\mathbf{0.7071068}$, $c^2=\mathbf{0.5}$ |
| $(1+c^2)^2$ | $\mathbf{2.25}$ |

**So: W6's alignment half is CONFIRMED, the top eigenvector really is $W$'s own block component, twice it in signed coordinates. Its numerical half is REFUTED: $c=1/\sqrt2$, not $1$, and the bound is slack by $2.25$, not $4$.**

**The post contradicts its own file.** [Lemma L124](../findings/second-order.md)'s withdrawn-readings paragraph, two paragraphs above F46, reads *"at padded $\mathbb{CP}^2$ the step $\rho\le\lVert R\rVert$ is exactly tight and all of the $2.25$ is the projection correction"*, $2.25=(1+\tfrac12)^2$, the correct factor. F46 then prints $4$.

**The mechanism of the error is the r365 shape again.** F46 uses two different $c$'s: the **within-block alignment cosine**, which is $1$ at $\mathbb{CP}^2$, and the **full-space overlap $\langle W,\hat X\rangle$**, which is what W4 defines, what I12 calls $\rho$, and what Cauchy–Schwarz bounds by $1$. Only the second is the $c$ in $\tfrac12(1+c^2)$. The post reads the first and substitutes it into the second.

## W5, REFUTED, on three counts

**(a) The chain's right end is wrong.** In the frame where L124(iii) holds (see (c)), $c^2\le\tfrac12$, so the composition reads $\theta^2\le\Sigma\le\tfrac94\theta^2$, not $\le4\theta^2$. The $c\le1$ step is Cauchy–Schwarz over the whole space and is correct as an inequality, but it discards the fact (visible in one line, $\lVert W_{\text{block}}\rVert^2=\tfrac12\lVert W\rVert^2$) that this family can never put more than half its mass in one four-set block.

**(b) "Consistent for every member, so no member is excluded" is FALSE.** On the family $\Sigma\equiv\tfrac32$ (this is L124's own "$\Sigma\equiv\tfrac32$ across the family while $\theta^2$ sweeps $[0,\tfrac32]$"), so $\Sigma\le\theta^2(1+c^2)^2\le\tfrac94\theta^2$ forces

$$\theta^2\ \ge\ \tfrac49\Sigma\ =\ \tfrac23 .$$

Every member with $\theta^2<\tfrac23$ **is** excluded by the composition, a positive-measure part of a family whose $\theta^2$ reaches $0$. A screen over $\phi\in[0,\pi/3]$ (with $(A,B,C)=\sqrt{2/3}(\cos\phi,\cos(\phi-\tfrac{2\pi}3),\cos(\phi+\tfrac{2\pi}3))$, so $\theta^2=\tfrac32\cos^2 3\phi$) puts the crossing near $\phi\approx0.26$ and confirms the exclusion from $\phi\approx0.28$ onward. So the post's headline sentence is wrong even after the constant is repaired.

**(c) And the composition is empty for a reason the post does not reach.** Two independent blocks:

- **Only $\pm W_{\mathbb{CP}^2}$ is a critical point of the family.** L24 and L125 both require $Q(W)=\theta W$; without it, "$\theta$" in L125 and "$\theta=9\det V_+$" in L124(iii) are not the same object and the composition does not typecheck. On this family $P=9\det V_+$ restricted to the unit sphere of traceless symmetric $3\times3$, whose critical points satisfy $\operatorname{adj}(V)-\tfrac13\operatorname{tr}\operatorname{adj}(V)\,\mathrm{Id}\parallel V$; for $V=\operatorname{diag}(A,B,C)$ that is $BC-k=\lambda A$ and cyclic, again a quadratic with two equal roots, hence $\pm(2,-1,-1)/\sqrt6$ up to permutation. Padding preserves criticality, so the same holds inside any $\mathcal W_n$. The screen agrees: residual $9.5\times10^{-16}$ at $\phi=0$ and $\phi=\pi/3$, and $0.13$ to $1.2$ everywhere between. **So the members F46 says are "not excluded" were never candidates: the criterion cannot be evaluated at them at all.**
- **At $n\ge6$ not even $\mathbb{CP}^2$ is a maximiser**, since the balanced sphere product reaches $P=1.5278$ at $n=12$ against $\sqrt{3/2}=1.2247$.

**What survives.** The post's *conclusion* (the L124(iii) rigidity and the corrected four-set bound do not compose into an exclusion), is right, and I did not find a repair. **Its argument is wrong in every step that carries a number**, and the emptiness is structural (nothing in the family to test) rather than numerical (the constants failing to bite).

**And "what a successor must clear" is misdirected.** F46 asks for "a bound on $c$ itself at a maximiser, since $c=1$ is what makes the correction factor large enough". $c$ is never near $1$ here; and a bound on $c$ at a maximiser is already on the record as [DERIVE-mx1](DERIVE-mx1.md)'s Corollary 1$'$, $\rho^2\le1-\tfrac{t_F}2$, whose own closing line already names "tightening $4$ by bounding $\rho^2$ at an actual critical point" as the next step. The post re-opens an item I12 opened.

---

## Collateral, [Lemma L124](../findings/second-order.md)(iii)'s $\theta^2\le\Sigma$ is a non sequitur and is false as printed

F46 leans on it, so it is in scope. The proof gives two facts, both upper bounds on the same quantity: $\theta^2=81(\det V_+)^2\le81\rho^6/54=\tfrac32\rho^6$, and (ii)'s $\Sigma=\tfrac32\lVert\operatorname{diag}V_+\rVert^2\le\tfrac32\rho^2$. **Two quantities bounded by the same number are not thereby ordered**, and the middle inequality of "$\theta^2\le\Sigma\le\tfrac32\rho^2$" does not follow. At $\rho=1$ it is equivalent to $\lVert\operatorname{diag}V_+\rVert=\lVert V_+\rVert$, i.e. to $V_+$ being **diagonal in the $\omega$-basis of the chosen frame**.

**A witness the lemma's own box supplies.** It states that every traceless symmetric $3\times3$ is orthogonally similar to one with zero diagonal, that the similarity is realised by a rotation inside $\langle S\rangle$, and that the rotated point stays critical at $\theta=\sqrt{3/2}$ with $\rho^2=1$. In that frame $A=B=C=0$, so $\Sigma=0$ while $\theta^2=\tfrac32$: **$\theta^2\le\Sigma$ fails outright.** (The box's own recorded $\Sigma=0.656$ is a different rotation and makes the same point less sharply.)

**Correction owed:** (iii) should read *in the eigenframe of $V_+$*, or equivalently should be stated as $\theta^2\le\tfrac32\lVert\operatorname{diag}V_+\rVert^2$ with the diagonal taken in that frame. The rigidity conclusion ($\mathbb{CP}^2$ as the unique maximiser of $\lvert\det V_+\rvert$), is unaffected, since it needs only $\theta^2\le\tfrac32\rho^6$ and the determinant bound's equality case.

## Summary of corrections to fold

1. **L125 is L24.** State it as a restatement of L24 off $W^\perp$, obtained by one orthogonal decomposition, and drop the claim of added generality. Delete or demote "equality holds at $Y=W$", it is the radial direction and holds for any degree-zero function at any point.
2. **The Krasnov–Tkachev normalisation.** The correct universal form is $2L_c-1\le P_c$; the source's printed $c\otimes c$ is missing $1/\lVert c\rVert^2$ and is false at $\lVert c\rVert=1/\theta\ne1$. Record that this record's version repairs the source rather than transports it, and fix the paraphrase in [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md).
3. **L125's "Agreement with DERIVE-mx1" paragraph.** The agreement is real and the identification of $c$ with I12's $\rho$ is correct; "now proved rather than introduced as a correction" is not, I12's corrected theorem is already a proof from L24.
4. **F46's numbers.** $c=1/\sqrt2$ at padded $\mathbb{CP}^2$; $c^2\le\tfrac12$ across the family; the slack factor is $2.25$, matching what L124's own paragraph records; the chain is $\theta^2\le\Sigma\le\tfrac94\theta^2$.
5. **F46's headline.** "No member is excluded" is false, $\theta^2\ge\tfrac23$ is forced. Replace the whole argument: the composition is empty because **$\pm W_{\mathbb{CP}^2}$ is the only critical point in the family**, so L24/L125 has nothing to evaluate at the other members, and at $n\ge6$ even $\mathbb{CP}^2$ is beaten by the balanced sphere product.
6. **F46's successor item** duplicates [DERIVE-mx1](DERIVE-mx1.md)'s own closing item; merge them rather than carrying two.
7. **L124(iii)** needs the eigenframe hypothesis or must be restated with $\lVert\operatorname{diag}V_+\rVert$.
