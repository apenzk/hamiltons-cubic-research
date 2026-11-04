# REVIEW r243, Gate 2 on A2′, the certificate point as a Cramer formula

Commit under review: `5df6750`, [run_a2prime_point_formula.py](../scripts/runs/run_a2prime_point_formula.py). Claims 1, 2 and 4 of brief 27; reviewer 244 holds 3, 5 and 6. Scripts: [scripts/reviewers/r243/](../scripts/reviewers/r243/). Everything below was re-derived from the definitions; the file was used only to read the claims off.

| Claim | Subject | Verdict |
| --- | --- | --- |
| 1 (vanishing) | the target vanishes at the balanced product at even $n$ | **CONFIRMED** exactly, in closed form, but it rests on a fact the file never states |
| 1 (transfer) | psd + vanishing forces the evaluation into the kernel | **CONFIRMED**, with the *matrix* lemma, not the vector one; the file's wording undercounts the forced conditions |
| 1 (odd $n$) | imposing $Bv(n)=0$ costs nothing at odd $n$ | conclusion **CONFIRMED**, stated reason **REFUTED**, it argues soundness where losslessness is what is owed |
| 2 (rationality) | $v(n)$ is rational in $n$ | **FALSE as written**, repairable in one line the file does not write |
| 2 (linearity) | $Bv(n)=0$ is linear in the unknowns | **CONFIRMED** |
| 4 | the constraint identity holds in the universal ring for every $t$ | **CONFIRMED but downgraded**, true, tautological, carrying an unstated hypothesis, and its screen has zero discriminating power |

---

## Claim 1, the forced kernel

### The vanishing is exact, and the file omits the half that could have killed it

The target ([fence-posts.md](../findings/fence-posts.md), post F31) is $G=\Theta_n^2A-B+\mu(C-B)$ with $A=\lVert W\rVert^6$, $B=\langle Q(W),W\rangle^2$, $C=\lVert W\rVert^2\lVert Q(W)\rVert^2$. Two independent facts are needed at $W_*$, and A2′ names neither.

- **$W_*$ is critical**, so $C-B=0$ there by the Cauchy–Schwarz equality case, and the $\mu$ term drops *for every $\mu$*, of either sign.
- **$P(W_*)=\Theta_n$** at even $n$, so $\Theta_n^2A-B=0$.

Both come out in closed form. Writing the balanced product's vertex matrix in the coordinate basis of $\Lambda^2$, the unnormalised entries are $w_{11}=w_{22}=n/2(n-1)$ and $w_{12}=-(n-2)/2(n-1)$, and Hamilton's $Q$ on a diagonal operator gives

$$Q(W_*)_{\text{same}}/W_{*,\text{same}} \;=\; Q(W_*)_{\text{mixed}}/W_{*,\text{mixed}} \;=\; \tfrac{n}{2}-1,$$

so $Q(W_*)=\tfrac{n-2}{2}W_*$ **identically in $n$**, and with $\lVert W_*\rVert^2=n^2(n-2)/8(n-1)$ this normalises to $\theta=\sqrt{2(n-1)(n-2)}/n=\Theta_n$. Both derived symbolically and cross-checked against the full $\Lambda^2$ operator with basis-free structure constants at $n=8,10,12$ (residual $\le4.5\times10^{-16}$) in [c1_balanced_product.py](../scripts/reviewers/r243/c1_balanced_product.py).

**Why the omission matters.** Criticality is not decoration. If $Q(W_*)$ were merely close to parallel with $W_*$, then $C-B>0$ strictly and $G(W_*)=\mu\,(C-B)\neq0$ for every $\mu\neq0$, the target would not vanish, nothing would be forced, and A2′ would have no forced kernel to impose. The claim is true because the balanced product is a critical point of $P$ on the whole sphere, not only within the diagonal subspace, and that is what should be written down.

**The odd-$n$ side of the dichotomy is real.** At $n=13,15,17$ the near-balanced product $S^{(n-1)/2}\times S^{(n+1)/2}$ is still critical, but $\Theta_n^2-P^2$ equals $3.69\times10^{-3}$, $2.39\times10^{-3}$, $1.64\times10^{-3}$ against the even-formula $\Theta_n^2$, strictly positive. Nothing is forced at odd $n$, exactly as A2′ says.

### The transfer works, but through a different lemma than the one advertised

The brief's suspicion is well aimed. In the block coordinates $B=\bigoplus_\lambda B_\lambda\otimes\mathrm{Id}_{V_\lambda}$ and the pairing at $W_*$ is

$$G(W_*)=\sum_\lambda \mathop{\mathrm{tr}}\!\big(B_\lambda M_\lambda\big),\qquad (M_\lambda)_{ij}=\langle c_i^\lambda(W_*),c_j^\lambda(W_*)\rangle,$$

with $M_\lambda$ psd. So the statement needed is the **matrix** one, *$A,M\succeq0$ and $\mathop{\mathrm{tr}}(AM)=0$ imply $AM=0$*, proved by $\mathop{\mathrm{tr}}(AM)=\mathop{\mathrm{tr}}(M^{1/2}AM^{1/2})$, a psd matrix of zero trace, hence zero, hence $A^{1/2}M^{1/2}=0$, not the textbook vector statement. Every trace in the sum is separately non-negative, so a single vanishing total forces every block. Checked on 800 randoms with no counterexample in [c3_psd_transfer.py](../scripts/reviewers/r243/c3_psd_transfer.py).

**The file's wording undercounts.** "$Bv(n)=0$ for one evaluation covector" gives $\mathop{\mathrm{rank}}$-one-worth of conditions per block; psd forces $B_\lambda M_\lambda=0$, which is $\mathop{\mathrm{rank}}(M_\lambda)$ of them. A two-multiplicity block with $\dim V_\lambda=2$ and independent evaluations makes the difference explicit: the forced condition is $B_\lambda=0$ (three conditions), the one-covector reading gives $b_{11}=b_{12}=0$ and leaves $b_{22}$ free. The gap is *sound* (the weaker condition is implied by the stronger) so nothing false follows; the cost is that the family is not actually cut to the boundary the sharpness structure demands, and A5 is then handed a larger family to certify. Read as intended the file is right, but only if $B$ is invoked as **equivariant**, so that one orbit point sweeps all of $V_\lambda$. The file never says so.

**A cleaner form of the condition, offered.** Impose $B_\lambda M_\lambda(n)=0$ directly. $M_\lambda(n)$ is a Brauer-pairing evaluation, hence rational in $n$ by A2, and it needs no basis of the irreducible $V_\lambda$ and no square root.

### "Costs nothing at odd $n$", the conclusion holds, the reason given does not

A2′ argues: the restriction is one "any member of which still certifies". That is a **soundness** statement. Losslessness is a different statement (whether the restriction deletes a member that would have worked) and soundness does not imply it. Witness in [c5_odd_n_and_minnorm.py](../scripts/reviewers/r243/c5_odd_n_and_minnorm.py): the psd family $B(s)=\begin{pmatrix}1&s\\ s&1\end{pmatrix}$, psd on $|s|\le1$, meets the extra condition $B(s)(1,-1)^{\mathsf T}=0$ only at $s=1$; every remaining member is deleted, and "still certifies" says nothing about them.

**The correct argument is available and gives more.** Let $B(n)$ have entries in $\mathbb Q(n)$, satisfy the constraints identically, and be psd at every even integer $n\ge12$. At each such $n$ the target vanishes at $W_*$, so $v(n)^{\mathsf T}B(n)v(n)=0$ and psd gives $B(n)v(n)=0$. Each entry of $B(n)v(n)$ is a rational function of $n$ vanishing at infinitely many points, hence identically zero. **So within the class route A searches (families rational in $n$), the forced-kernel condition is not imposed at all; it is implied.** That is stronger than what A2′ claims, it holds at odd $n$ and at every real $n$, and it turns on rationality rather than on parity. It would fail for a family that is not rational in $n$, which is the hypothesis worth recording.

---

## Claim 2, is $v(n)$ rational, and is $Bv(n)=0$ linear?

### As written, the rationality claim is false

A2′ says "$v(n)$, the evaluation covector at the balanced product, is rational in $n$". The balanced product as an element of the unit sphere is $W_*/\lVert W_*\rVert$, and

$$\lVert W_*\rVert^2=\frac{n^2(n-2)}{8(n-1)}$$

is **not a square in $\mathbb Q(n)$**: at the $(n-2)$-adic valuation, $n^2(n-2)g^2=8(n-1)f^2$ has an odd exponent on the left and an even one on the right. So $\lVert W_*\rVert^3$ is a genuine quadratic irrationality over $\mathbb Q(n)$ (the same square root that makes $\Theta_n$ irrational) and the evaluation of any cubic at the normalised extremiser carries it. Exhibited concretely in [c2_v_rationality.py](../scripts/reviewers/r243/c2_v_rationality.py): the cubic $\sum K_{ab}^3$ evaluates to $-3(n^3-18n^2+36n-24)/4(n-1)^3$ raw, and to something with $((n-2)/(n-1))^{3/2}$ in it once normalised. The brief's suspicion is confirmed: **the square root is real and it goes through the normalisation.**

### The conclusion survives, by a step the file does not write

Cubic covariants are homogeneous of degree 3, so $c(W_*/\lVert W_*\rVert)=\lVert W_*\rVert^{-3}c(W_*)$, and $Bv=0$ is invariant under $v\mapsto sv$ for any $s\neq0$. Take $v(n)$ at the **unnormalised** $W_*$, whose entries clear to the polynomials $n$ and $2-n$ after multiplying by $2(n-1)$. Then $v(n)$ is polynomial in $n$ up to an overall scalar that scale-invariance discards.

This is one line, and it is load-bearing rather than cosmetic: had the normalised evaluation been used, the forced-kernel rows would carry coefficients in $\mathbb Q(n)[\sqrt{(n-2)(n-1)}]$, Cramer would return entries in that quadratic extension, and claim (a)'s "entries in $\mathbb Q(n)$ identically in $n$" would fail. **Verdict: the clause is false as stated, true as intended, and the intended reading needs an argument A2′ does not supply.**

Two riders. First, only $\Theta_n^2=2(n-1)(n-2)/n^2$ enters the target, so the right-hand side $b(n)$ is safe, the root can only enter through the extremiser's normalisation, which is exactly where A2′ put it. Second, $v(n)$'s rationality *in the multiplicity coordinates* is inherited from A2, and A2 is owed three things (reducedness, the coordinate-picking steps with $\det\mathrm{Gram}_S$ carrying $869n-2767$, and joint block projection). The $B_\lambda M_\lambda(n)=0$ form above is the least exposed to those, since it uses only the Brauer pairing.

### Linearity is fine

For fixed $v$, the map $B\mapsto Bv$ is linear, and $v(n)$ depends only on the extremiser, never on $B$. The condition is linear, not quadratic. Worth a wording note: "the forced kernel" invites reading $v$ as a kernel vector *of $B$*, which would make it quadratic; that is not what is meant, and one clause saying so would remove the ambiguity.

---

## Claim 4, the constraint identity for every $t$

**True. And it is the weakest true thing in the file, not the strongest.** Three findings, each with a witness, in [c4_identity_for_every_t.py](../scripts/reviewers/r243/c4_identity_for_every_t.py).

### It is a tautology of affine linear algebra

If $AB_p=b$ and $AK_i=0$ then $A\big(B_p+\sum t_iK_i\big)-b=0$ for every $t$, in any field, hence in $\mathbb Q(n)$. The $t$-freedom is not evidence about the certificate, it *is* the definition of an affine solution set. Anything obtained by writing a solution set as a base point plus a kernel has this property, including the four-point fit A2′ replaces, once its output is written that way.

### It carries an unstated hypothesis, and the hypothesis can fail while every stated obligation holds

Cramer on a **pivoted** subsystem returns a solution of the **pivot rows**. The augmented system's rows are $\mathbb Q(n)$-dependent, $B_\lambda M_\lambda=0$ is $m_\lambda^2$ equations on $m_\lambda(m_\lambda+1)/2$ unknowns, so redundancy is structural, and then a maximal minor $\xi(n)\neq0$ certifies the pivot rows only. Witness:

$$A(n)=\begin{pmatrix}1&n&2\\0&n-2&1\\1&2n-2&3\end{pmatrix},\qquad b(n)=\begin{pmatrix}n+3\\1\\0\end{pmatrix},$$

with row 3 $=$ row 1 $+$ row 2 exactly while $b_3\ne b_1+b_2$. The pivot minor is $\xi(n)=n-2$, whose only root is $2$, **sign-constant on $[12,\infty)$, so A2′'s one new Sturm obligation is met in full**. The pivoted Cramer solve has residual $(0,0)$ on the pivot rows, which is what the file's screen checks, and residual $(0,0,n+4)$ on the full system, which is what claim (b) asserts. No kernel direction repairs it: the third row is off by $n+4$ for every $t$.

**The missing obligation is nameable and cheap:** the non-pivot rows of $[\mathrm{Aug}\mid \mathrm{bug}]$ must be $\mathbb Q(n)$-combinations of the pivot rows. One symbolic check, not an $n$-by-$n$ one. A2′'s obligation list has one item where it needs two.

### The screen offered for (b) cannot fail

The miniature builds a **square nonsingular** `Aug` and then asserts `Aug * Aug.solve(bug) == bug`. That holds for every nonsingular matrix over an exact field, correct or corrupt. Run on 200 random nonsingular $3\times3$ systems over $\mathbb Q(n)$, none of them the true constraint system: zero failures. So the line printed as "constraint identity == 0 as a rational function of $n$ (claim (b))" tests sympy's linear solver. The planted-corruption check does have content, but what it shows is `Aug_bad != Aug`; it says nothing about $t$-freedom, and the miniature never instantiates the over-determined case where (b) has any content at all.

### "The numerics never enter the proof" is overstated

What (b) buys is real and worth keeping: a badly chosen $t$ yields a **failed** certificate rather than an unsound one, so numerical error moves from a soundness risk to a completeness risk. That is a genuine gain over fitting solved points. But PSD-ness of $B(t;n)$ (the entire mathematical content), is a function of $t$, and $t$ is what the $n=12$ SDP chooses. The numerics decide whether the proof exists; they do not decide whether it is valid. The file's (c) says the second and reads as the first.

---

## One repair, offered

A2′ calls $B_p$ "the minimum-Frobenius-norm solution". It is not: Cramer on a pivoted system returns the **basic** solution with the free variables set to zero. On $A=\begin{pmatrix}1&1&0\\0&1&n\end{pmatrix}$, $b=(1,n)$, the basic solution is $(1-n,\,n,\,0)$ and the minimum-norm solution is $\big(\tfrac{n^2-n+1}{2n^2+1},\tfrac{n(n+1)}{2n^2+1},\tfrac{n(2n-1)}{2n^2+1}\big)$; they differ by a kernel element, so (a) and (b) are unharmed.

But the misdescription names the wrong denominator, and the right one is better. Take $B_p=A^{\mathsf T}(AA^{\mathsf T})^{-1}b$ and the kernel basis from $I-A^{\mathsf T}(AA^{\mathsf T})^{-1}A$. Every entry stays in $\mathbb Q(n)$ with the single denominator $\det(AA^{\mathsf T})$, which by Cauchy–Binet is the **sum of squares of the maximal minors**, $\det(AA^{\mathsf T})=2n^2+1=1^2+n^2+n^2$ in the example. Sign-constancy on $[12,\infty)$ is then automatic for every real $n$, with no Sturm run: **A2′'s one new Sturm item disappears**, and only nonvanishing is left, which is the rank condition already needed. The pseudoinverse base point is also canonical, hence equivariant under the symmetries of the constraint system, which a pivot-basic solution is not, and equivariance of $B$ is what claim 1's one-covector wording silently needs.

---

## What A2′ should say

1. State criticality of $W_*$ as a lemma ($Q(W_*)=\tfrac{n-2}{2}W_*$ identically in $n$) since without it the $\mu$ term does not drop and the forced kernel does not exist.
2. Replace "$v(n)$ is rational in $n$" by "$v(n)$ **may be taken** rational in $n$, since $Bv=0$ is scale-invariant and the covariants are homogeneous of degree 3". As written the clause is false.
3. Replace the one-covector kernel condition by $B_\lambda M_\lambda(n)=0$, or invoke equivariance of $B$ explicitly.
4. Replace "costs nothing at odd $n$" by the density argument: within families rational in $n$, psd at the even integers forces $Bv\equiv0$, so the condition is implied rather than imposed.
5. Add the second obligation to the list: the non-pivot rows of the augmented system are $\mathbb Q(n)$-combinations of the pivot rows.
6. Rebuild the screen for (b) on an **over-determined** miniature, where the check can fail; the square one cannot.
7. Take the pseudoinverse base point and delete the Sturm item, or drop the words "minimum-Frobenius-norm".

None of this refutes A2′. The repair it performs on A4 is real: defining the point instead of fitting it is the right move, and (b) does what it is supposed to do once its hypothesis is written down. What the file overstates is how much (b) buys, and what it leaves out is the fact (criticality) that the whole forced-kernel construction depends on.
