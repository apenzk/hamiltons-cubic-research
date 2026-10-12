# Review r159, Gate 2 on the closure of route 3a

**Verdict: the implementation is CORRECT and the closure drawn from it is WRONG.** Every number in the table is reproduced here to all printed digits by an independent closed-form derivation that shares no code with the record. The three ratios are real and survive every normalisation error constructible. But "three different ratios" refutes only $C\propto\theta$, and proportionality was never what the route needed. The coefficients the record asked for are $(40,-8)$, and eliminating the second cubic between them gives an **exact identity**

$$\boxed{\ \theta\ =\ 6\operatorname{tr}(W^3)\ -\ \tfrac18\,C(W)\ }$$

so Cheng–Wang's bound reaches $\theta$ after all, through the *lower* side, the one [nondegeneracy.md](../findings/nondegeneracy.md) discarded as "useless against a supremum". **3a is not grade 0.**

## 1. The implementation, attacked hardest, it survives

I did not rebuild it. I derived $C$ in closed form on the class the table uses and compared.

**Setup.** The three test points are $\Lambda^2$-diagonal: $W_{ijij}=M_{ij}$ with $M$ hollow, symmetric, zero row sums, and every other component zero. On this class $\mathring W$ on $S^2_0$ is explicit, $(\mathring Wh)_{ij}=-M_{ij}h_{ij}$ off the diagonal, $(\mathring Wh)_{ii}=\sum_kM_{ik}h_{kk}$ on it, so the eigenbasis is $\{E_{pq}\}_{p<q}$ with eigenvalue $-M_{pq}$, together with the eigenvectors of $M|_{\mathbf 1^\perp}$. That is $\binom n2+(n-1)=\dim S^2_0$ eigenvalues, and $\sum_j\mu_j^2=3\sum_{i<j}M_{ij}^2=\tfrac34\lVert W\rVert^2$, matching Lemma 3.1.

**The derivation action, evaluated by hand.** For $D$ diagonal, $|DW|^2=16\,d^{\mathsf T}(\operatorname{diag}(r)+A)d$ with $A_{ij}=M_{ij}^2$, $r_i=\sum_jA_{ij}$. For $E_{pq}$ the quadruples with zero, one, three or four indices in $\{p,q\}$ all cancel (the four-index block cancels term-by-term in pairs), leaving $|E_{pq}W|^2=4\sum_{x\ne p,q}(M_{px}+M_{qx})^2$. Summing over the whole basis and using $M\mathbf1=0$:

$$\sum_j\lvert S^jW\rvert^2=\frac{8(n^2+n-8)}{n}\sum_{i<j}M_{ij}^2=\frac{2(n^2+n-8)}{n}\lVert W\rVert^2 .$$

**That is the record's $\kappa$, exactly**, reached from a completely different direction. It is an unforgiving check: a wrong slot count, a dropped term, or a factor on $S$ would all break it, and it also pins the $(0,4)$-from-pair-matrix normalisation to $W_{ijij}=M_{ij}$.

**The closed form.** Weighting by $\mu_j$ and using the zero row sums twice,

$$C(W)=40\sum_{i<j}M_{ij}^3-4\operatorname{tr}(M^3),\qquad\text{no }n\text{ anywhere.}$$

**Result.** With $\Sigma_2=\sum_{i<j}M_{ij}^2=1$ (which is the record's normalisation, pinned below, not assumed), this gives $8.809545$, $7.771404$, $4.169574$ at $S^6\times S^6$, $S^5\times S^7$, $S^4\times S^8$ against the recorded $8.80954$, $7.77140$, $4.16957$, and ratios $7.12727$, $6.32727$, $3.47013$ against $7.12727$, $6.32727$, $3.47013$. **Six of six, every digit.**

*Why an argument alone could not settle this:* the record never states which of $\lVert W\rVert_{(0,4)}$ and $\lVert\mathring W\rVert_{\Lambda^2}$ its $\theta$ is normalised to, and the two differ by exactly $4$ on all of $\mathrm{Weyl}_n$; I had to reproduce the $\theta$ column to read the convention off.

**Normalisation, pinned independently.** The same $M$ gives $\theta=\sum_{i<j}M_{ij}^3+\tfrac12\operatorname{tr}(M^3)$ reproducing $1.236033$, $1.228239$, $1.201561$; and at $n=6$ it splits $S^3\times S^3$ as $(\operatorname{tr}W^3,\langle W^\#,W\rangle)=(0.105409,0.948683)$ against the $(0.105,0.949)$ [bounds.md](../findings/bounds.md) recorded from Reviewers 69/70. So $\theta$ is at $\lVert\mathring W\rVert_{\Lambda^2}=1$, and $C$ was computed at the same $W$. **There is no normalisation error to find.**

## 2. Does the conclusion survive every normalisation error? Yes, and for a structural reason

$C$ and $\theta$ are both homogeneous of degree $3$ in $W$: $\mu_j(tW)=t\mu_j(W)$ while eigenvectors are scale-blind, so $C(tW)=t^3C(W)$. Any convention mismatch between the two, the $(0,4)$ reconstruction using $2M$ instead of $M$, the wedge-basis normalisation, $\lVert W\rVert_{(0,4)}$ against $\lVert\mathring W\rVert_{\Lambda^2}$, is a *fixed structural constant*, the same on all of $\mathrm{Weyl}_n$ and therefore the same at all three points. It multiplies all three ratios by one number and cannot separate them. **The three-different-ratios conclusion is immune to the entire class.** The only way to break it would be a per-point normalisation, which a fixed convention cannot produce.

## 3. The one real error in the table: the sign

The geometric Weyl tensor of $S^p\times S^q$ has cross entries negative and within-block entries positive, which is the sign giving the record's $\theta>0$. At that sign $C$ is **negative** at all three points: $-8.809545$, $-7.771404$, $-4.169574$. $C$ is odd in $W$ and $\theta$ is odd in $W$, so the table reports $|C|$ against $+\theta$, its two columns are in opposite sign conventions. This is [the sign trap the record itself documents](../findings/nondegeneracy.md) ("The sign of $W$ is part of the definition of $S$"), recurring. The magnitudes and hence the ratios are unaffected; the sign matters for §5.

## 4. Item 2, the route is not closed. It survives, and not merely "in a modified form"

[bounds.md](../findings/bounds.md) records that the cubic $O(n)$-invariants of a Weyl tensor are a $2$-plane spanned by $\operatorname{tr}W^3$ and $\langle W^\#,W\rangle$ for $n\ge6$, with $\theta$ their sum. $C=\operatorname{tr}(\mathring W\circ B_W)$ with $B_W(S,T)=\langle SW,TW\rangle$ is manifestly a cubic $O(n)$-invariant, so $C$ lies in that plane. My closed form, restricted to a class on which the two spanning invariants are independent, reads its coordinates off:

$$C=40\operatorname{tr}(W^3)-8\langle W^\#,W\rangle .$$

Checked at $n=12$ (three points, two unknowns, one free consistency check, passed) and at $n=6$ (one point, passed). The coefficients carry no $n$. **This is the identification [nondegeneracy.md](../findings/nondegeneracy.md) called "worth doing to learn which cubic this is". It is done.**

Now eliminate the second cubic between $C$ and $\theta=\operatorname{tr}W^3+\langle W^\#,W\rangle$:

$$\theta=6\operatorname{tr}(W^3)-\tfrac18\,C(W),$$

verified to six digits at $S^6\times S^6$, $S^5\times S^7$, $S^4\times S^8$ and $S^3\times S^3$.

**The closure's logic fails at its first step.** Reviewer 158's criterion (the bound reaches $\theta$ "only if $\alpha=\beta<0$"), is the criterion for $C\propto\theta$, and proportionality is sufficient, never necessary. Two independent invariants bound a third whenever the third is in their span and both are controlled. Here $\theta$ is in the span of $C$ and $\operatorname{tr}W^3$, and $\operatorname{tr}W^3$ is a pure $\Lambda^2$-spectral quantity with an elementary sharp bound $\operatorname{tr}W^3\le(N-2)/\sqrt{N(N-1)}$ on the traceless unit sphere, $N=\binom n2$. **Fence post F2g does not obstruct this**: it says a bound reaching $\theta$ *through the $\Lambda^2$ spectrum alone* cannot be sharp for $n\ge6$. This one does not, $C$ carries the second-kind spectrum, which is exactly the missing information 2g names.

## 5. Item 4, the upper bound is correct, and its stated role is backwards

The $W\mapsto-W$ derivation is sound: the ordering of $\mu_j$ reverses, $|S^jW|$ is even in $W$, so the upper bound follows. **But "this is the side that could ever bound a supremum" is refuted by the sign of the coefficient.** In $\theta=6\operatorname{tr}(W^3)-\tfrac18C$ the coefficient of $C$ is *negative*, so an upper bound on $\theta$ needs a **lower** bound on $C$, the collapsed inequality the record already proved,

$$\theta\ \le\ 6\operatorname{tr}(W^3)-\frac{\mu_1+\mu_2}{16}\sum_j\lvert S^jW\rvert^2\ =\ 6\operatorname{tr}(W^3)-\frac{(\mu_1+\mu_2)(n^2+n-8)}{2n}\,,$$

the last equality at $\lVert\mathring W\rVert=1$. The free upgrade, applied to $\theta$, yields a lower bound and is the useless side. **The two sides swap roles.** This also explains the sign finding of §3: $C<0$ at the sphere products is precisely why the bottom of the spectrum is the operative end.

**How far it is from closing, stated honestly.** At $S^6\times S^6$ the inequality gives $\theta\le1.79786$ against the true $1.236033$, valid, with $45\%$ slack. Fed the crude uniform inputs $\operatorname{tr}W^3\le0.97713$ and $\mu_1+\mu_2\ge-\sqrt6$ it gives $\theta\le20.97$ against the target $\sqrt{3/2}$. **So this is a live route needing two sharpenings, not a proof.** What it delivers immediately and unconditionally is the first bound the record has ever carried on $\langle W^\#,W\rangle$, namely $\langle W^\#,W\rangle\le5\operatorname{tr}(W^3)-\tfrac1{16}(\mu_1+\mu_2)\sum_j|S^jW|^2$.

## 6. Item 3, the derivation action matches the source exactly

Definition 2.1 of [the stored paper](https://arxiv.org/abs/2508.11226), lines 218–230: $(ST)(X_1,\dots,X_k)=\sum_{i=1}^kT(X_1,\dots,SX_i,\dots,X_k)$. That is the implemented formula with no factor. Independently, any factor $\lambda$ on $S$ would have shown up as $\lambda^2$ in my $\kappa$ check, which came out exact.

## Answers to the questions

**(a) Rediscoveries.** None. $C$ is a genuinely new point of the cubic $2$-plane: its coordinate ratio is $-5$, against $-14$ for $\Psi_3$ and $-\tfrac12$ for $\Phi$, both already in [bounds.md](../findings/bounds.md). The $2$-plane itself and $\theta=\operatorname{tr}W^3+\langle W^\#,W\rangle$ are the record's, and I lean on them rather than reasserting them.

**(b) Retirement of 3a to grade 0, no.** The evidence retires a claim the route never made. On the record's own scoring I read 3a as *closes 2, attackable 2, cost 1*, i.e. **4**: the transfer is settled sound, the bound is proved, the cubic is now identified with $n$-independent coefficients, and the reduction of $\theta$ to two spectral quantities is explicit. What it owes is two sharpenings, both well posed. That is an ordinary open item, not a dead end.

**(c) 3b's grade is defensible** and I have nothing that moves it. But it is no longer the only item with a route, so the "either alone closes it" framing of item 3 should be restored to two live branches.

## Process finding

**The computation behind the closure is not in the repository.** [36ac4c6](../findings/nondegeneracy.md) touches only two Markdown files; no script producing $C$ exists under [scripts/](../scripts/). A closed route resting on an uncommitted, unreproducible number is the failure mode the brief anticipated. The closed form in §1 should be committed in its place, it is exact, needs no solver, and reproduces the table.

## Disagreements, stated plainly

- **I disagree with the closure of 3a.** It is a non-sequitur: non-proportionality is not the negation of "can bound".
- **I disagree with r158's "the only side that can bound a supremum".** The sign of the coefficient in $\theta=6\operatorname{tr}(W^3)-\tfrac18C$ makes the lower bound the operative one and the upper bound the useless one.
- **I agree with r157 and r158 on everything else**, the shift is legitimate, $\theta(n)$ cancels, the collapsed bound is correct and has content, and the source's (3.7) defect is real and inert here.
