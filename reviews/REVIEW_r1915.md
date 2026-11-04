# REVIEW r1915: the I-lift family between H and P (reviews/2026-09-28o-I123-coupling.md, "Third attempt")

Log: [agent_logs/r1915-lift-family.log](../agent_logs/r1915-lift-family.log)

**Verdict: CONFIRMED with two wording corrections.** The inequality for $s\in(0,1]$ is correct, needs no H, and is tight at $s=1$. The phrase "only $s=0$, statement H, is sharp" holds only under H. The bullet's "no normal $(s,1)$ with $s>0$" overreaches the family, which stops at $s=1$. The numbers $t_0$, $\beta$ and the split $\theta_0=t_0+\beta$ are already on the record in [diagonal-half.md](../findings/diagonal-half.md) and should be cited there.

| # | claim | verdict |
|---|---|---|
| 1 | expansion of $G_s(W+cI)$ | CONFIRMED |
| 2 | passage to $b(s)$ | CONFIRMED ("min" is an infimum, harmless) |
| 3 | affine split | CONFIRMED |
| 4 | $\min_uf(u,0)=\beta$, $A=t_0$, $B=\beta$, $t_0+\beta=\theta_0$ | CONFIRMED, closed form derived at every $n$ |
| 5 | $\varphi\ge1$, $\theta_0<\sqrt{2(n-1)/n}$, the gap | CONFIRMED; H is not needed for $s>0$, but "s=0 is sharp" is H itself |
| 6 | closing bullets | CONFIRMED with one scope correction to bullet 1 |
| 7 | Lean | CONFIRMED as stated in the table; the quantitative gap is not typed |
| 8 | on the record already? | PARTLY DUPLICATE: numbers and split in diagonal-half.md L57; the family inequality is new |

## 1. The expansion

$X=W+cI$, $\mathop{\mathrm{tr}}W=0$, $\lVert W\rVert=1$. $\mathop{\mathrm{tr}}X^3=A+3c\mathop{\mathrm{tr}}W^2+3c^2\mathop{\mathrm{tr}}W+c^3N=A+3c+c^3N$. The cubic form $T(X,Y,Z)=\langle X^\#Y,Z\rangle$ is symmetric, so $T(X,X,X)=B+3cT(W,W,I)+3c^2T(W,I,I)+c^3T(I,I,I)$, with $T(W,W,I)=\langle I^\#W,W\rangle=-1$, $T(W,I,I)=\langle I^\#I,W\rangle=(n-2)\mathop{\mathrm{tr}}W=0$, $T(I,I,I)=(n-2)N$. Sum: $sA+B+3c(s-1)+c^3N(s+n-2)$. Agrees with 28n batch 3 at $s=1$.

## 2. The passage to b(s)

- $\lVert W+cI\rVert^2=1+2c\mathop{\mathrm{tr}}W+c^2N=1+c^2N$, so the cap at $X=W+cI$ gives $sA+B\le$ the bracket at every $c$, hence at its infimum. Whether the infimum is attained depends on $g_s$ (at $g_s=(s+n-2)/\sqrt N$ the $c^3$ terms cancel to leading order as $c\to+\infty$). "min" should read "inf"; nothing downstream uses attainment.
- The bracket's $g_s$ coefficient is $(1+c^2N)^{3/2}>0$, so it is increasing in $g_s$.
- Any valid cap satisfies it at $X=I$: $G_s(I)=sN+(n-2)N$, $\lVert I\rVert^3=N^{3/2}$, so $g_s\ge(s+n-2)/\sqrt N$.
- With $u=c\sqrt N$: $c^2N=u^2$, $3c(s-1)=3u(s-1)/\sqrt N$, $c^3N=u^3/\sqrt N$, giving $f(u,s)$ exactly as written.

## 3. The affine split

$(1-s)\big((n-2)\varphi+3u\big)+s(n-1)\varphi=(s+n-2)\varphi+3u(1-s)$. Identity.

## 4. The minimum and the balanced product

**Closed form at every $n$.** Put $h(u)=(n-2)\varphi(u)+3u$, $k=n-2$. $\varphi'(u)=3u(\sqrt{1+u^2}-u)$, which is $\ge0$ for $u\ge0$, so $h'>0$ there. For $u=-v<0$, $h'=0$ reads $kv(\sqrt{1+v^2}+v)=1$, whose unique positive root is $v^2=1/(k(k+2))=1/(n(n-2))$. There $1+v^2=(k+1)^2/(k(k+2))$ and $(k+1)^3+1=(k+2)(k^2+k+1)$, so $h=(k^2+k+1-3)/\sqrt{k(k+2)}=(k-1)\sqrt{(k+2)/k}$. $h\to\infty$ at both ends, so this is the global minimum: $$\min_uf(u,0)=\frac{(n-3)\sqrt{n/(n-2)}}{\sqrt{n(n-1)/2}}=(n-3)\sqrt{\frac2{(n-1)(n-2)}},$$ which at $n=2m$ is $\frac{2m-3}{\sqrt{(m-1)(2m-1)}}=\beta$, attained at $c=-1/\sqrt{N n(n-2)}$.

**The balanced product.** $R=P$, the projector onto $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$; Einstein with $\mathrm{Ric}=(m-1)$, $\kappa=\mathrm{scal}/(n(n-1))=\frac{m-1}{2m-1}$, $W=P-\kappa I$. Eigenvalues $\frac m{2m-1}$ on dimension $m(m-1)$ and $-\frac{m-1}{2m-1}$ on dimension $m^2$. Then $\lVert W\rVert^2=\frac{m^2(m-1)}{2m-1}$ and $\mathop{\mathrm{tr}}W^3=\frac{m^2(m-1)}{(2m-1)^2}$, so $A=t_0=\frac1{m\sqrt{(m-1)(2m-1)}}$. For $B$: $P^\#P=(m-2)P$ (the cross term vanishes since the two factors commute), and $P^\#I=\mathrm{Ric}(P)\wedge\mathrm{id}-P=(m-1)I-P$ (the Böhm–Wilking formula, which returns the givens $I^\#I=(n-2)I$ and $I^\#W=-W$). So $W^\#W=\big(m-2+2\kappa\big)P+\text{const}\cdot I$ with $m-2+2\kappa=\frac{m(2m-3)}{2m-1}$, and $\langle W^\#W,W\rangle=\frac{m(2m-3)}{2m-1}\langle P,W\rangle=\frac{m(2m-3)}{2m-1}\lVert W\rVert^2$. Normalising, $B=\frac{2m-3}{\sqrt{(m-1)(2m-1)}}=\beta$. And $t_0+\beta=\frac{1+m(2m-3)}{m\sqrt{(m-1)(2m-1)}}=\frac{(2m-1)(m-1)}{m\sqrt{(m-1)(2m-1)}}=\theta_0$.

## 5. The conclusion

- $\varphi\ge1$: $(1+u^2)^3-(1+u^3)^2=u^2(3u^2-2u+3)\ge0$ (discriminant $-32$), so $(1+u^2)^{3/2}\ge|1+u^3|\ge1+u^3$. Correct.
- $f(u,1)=(n-1)\varphi/\sqrt N\ge(n-1)/\sqrt N=\sqrt{2(n-1)/n}$, equality at $u=0$.
- $\theta_0^2/\frac{2m-1}m=\frac{m-1}m<1$. Correct at every $m\ge2$.
- For $s\in(0,1]$: $f(u,s)\ge(1-s)\beta+s\sqrt{2(n-1)/n}$ uses $1-s\ge0$, and subtracting $st_0+\beta$ leaves $s(\sqrt{2(n-1)/n}-\theta_0)>0$. Correct, and **tight at $s=1$** (both bounds attained at $u=0$).
- **H is not used for $s\in(0,1]$**: the argument needs only $g_s\ge G_s(I)/\lVert I\rVert^3$, true of every valid cap, and the calculus fact $\min_uf(u,0)=\beta$ of item 4. **The clause "only $s=0$, statement H, is sharp there" does use H**: $b(0)=\beta$ exactly when $g_0=(n-2)/\sqrt N$ is a valid cap, which is H. Correction: "for $s\in(0,1]$ the lift is never sharp; $s=0$ is sharp if and only if H holds with its constant."
- Screen (seconds, one-variable grid at $n=12,14,20$, reported as a screen only): the grid minimum of $f(u,0)$ matches $\beta$ to $10^{-10}$, and the gap at $s=0.1,0.5,1$ is at or above $s(\sqrt{2(n-1)/n}-\theta_0)$, with equality at $s=1$.

## 6. The closing bullets

- **Bullet 1.** Under P and H both lines $A+B=\theta_0$ and $B=\beta$ support the joint range at $(t_0,\beta)$, which makes it a corner of the convex hull. The $I$-lift reduces the second to H (it "certifies" it only conditionally on H, which the wording should say). **Scope correction**: the family is $s\in[0,1]$, so the result excludes normals $(s,1)$ with $0<s\le1$, not "with $s>0$". For $s>1$ the split $(1-s)f(u,0)+sf(u,1)$ has a negative weight on the $f(u,0)$ term and the argument gives nothing; whether those normals are sharp is unaddressed. "Batch 3's neutrality at $s=1$ is the end of a whole segment" is right with the segment $(0,1]$.
- **Bullet 2.** Under H, item 4's lift gives $B\le\beta$ at every unit Weyl $W$, so $A\le t_0$ gives $A+B\le\theta_0$. Correct at even $n$ (where $t_0$, $\theta_0$ are defined). $t_0(12)=1/(6\sqrt{55})=0.022473$; the written $0.02247$ is correct to its digits.

## 7. Lean

- `phi_ge_one`, `lift_affine`, `theta0_lt_sphere` state what the table says.
- `lift_not_sharp` states the strict inequality $(\beta+s(\theta_0-\beta))R<(s+n-2)\varphi+3u(1-s)$ from $0<s\le1$, $1\le\varphi$, $\beta R\le(n-2)\varphi+3u$, $\theta_0R<n-1$. $\varphi$ is a free real, so the lemma is linear arithmetic and does not tie $\varphi$ to $u$. It is non-vacuous (the file's `example` instantiates it, and the true values at $n=12$, $R=\sqrt{66}$, $\beta=9/\sqrt{55}$, $\theta_0=\sqrt{55}/6$ also satisfy every hypothesis).
- **Untyped links, to be listed**: the quantitative gap $s(\sqrt{2(n-1)/n}-\theta_0)$ is not stated (only strictness); `theta0_lt_sphere` is never connected to `hθ` (the step $\theta_0^2<2(n-1)/n\Rightarrow\theta_0\sqrt N<n-1$ with $N=n(n-1)/2$); `hβ` is a hypothesis although item 4 gives it in closed form and it could be typed.
- `#print axioms` on all four: `[propext, Classical.choice, Quot.sound]`, no `sorryAx`.

## 8. The record

- [diagonal-half.md, "And that decomposes $\theta_0$ itself"](../findings/diagonal-half.md) (line 57) already has $\theta_0(n)=\sqrt2c_n+\frac{2\sqrt2}{n\sqrt{(n-1)(n-2)}}$, $c_n=\frac{n-3}{\sqrt{(n-1)(n-2)}}$, the second term named as $\mathop{\mathrm{tr}}W^3$ at the balanced product. At $n=2m$, $\sqrt2c_n=\beta$ and the second term is $t_0$, so the note's split is the same split. Line 43 records $1.236033=1.213562+0.022471$ ([r389](REVIEW_r389.md)). $t_0$'s closed form is also in [bispectral.md](../findings/bispectral.md) (lines 186 and 510) and [ad-form-attempt.md](../findings/ad-form-attempt.md).
- What is new: there $\sqrt2c_n$ is the spectral cap on the diagonal locus (proved), and here the same number arises as H's cap on all unit Weyl tensors through the $I$-lift. Item 4's closed-form minimum shows the two coincide at every $n$. Bullet 2 is the general-$W$ form of that file's trade-off $E-E_0\le T_{\max}-T$, conditional on H. The family inequality itself is not on file.
- **Correction**: the note should cite diagonal-half.md line 57 for the split, and state that H's Weyl cap equals the diagonal locus's spectral cap $\sqrt2c_n$.
