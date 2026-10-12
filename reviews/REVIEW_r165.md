# Gate 2, Reviewer 165

**Verdict: claim 1's sign is CORRECT, and I derived it independently from the round-sphere pin without reading any recorded value. Claim 3 is correct and I re-derived it including $\theta=\sqrt{3/2}$. Claim 2's verdict is right for the wrong reason, the result it reports is forced by a theorem the record already holds, so it is not even a control of the instrument.** Three live defects sit in the sign passage, one of them the inverted formula itself, still in the file as the derivation's stated output.

## CLAIM 1, derived from scratch, and the boxed sign is right

### The pin

$\mathring R(\varphi)_{ij}=R_{ikjl}\varphi_{kl}$ is $+\mathrm{Id}$ on $S^2_0$ at the unit round sphere **only** in the convention $R_{ijkl}=g_{il}g_{jk}-g_{ik}g_{jl}$: substituting gives $R_{ikjl}=g_{il}g_{kj}-g_{ij}g_{kl}$, hence $\mathring R(\varphi)_{ij}=\varphi_{ij}$ on trace-free $\varphi$. In the complementary convention $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}$ the same contraction gives $-\varphi_{ij}$, and the record's written form $R_{iklj}\varphi_{kl}$ is that convention's spelling of the same operator. **Both spellings are the same operator; the pin is unambiguous.** In the pinned convention sectional curvature is $K_{ij}=R_{ijji}$.

### $\mathring W$ on a $\Lambda^2$-diagonal Weyl tensor

Take $W$ diagonal with vertex matrix $M$ hollow symmetric, $M\mathbf1=0$, $R_{ijji}=M_{ij}$.

- **Off-diagonal.** $\mathring W(E_{pq})_{ij}=(R_{ipjq}+R_{iqjp})/\sqrt2$. Diagonality forces $\{i,p\}=\{j,q\}$ or $\{i,q\}=\{j,p\}$, giving $R_{qppq}=M_{pq}$ at $(i,j)=(q,p)$ and $R_{pqqp}=M_{pq}$ at $(p,q)$. Hence $\mathring W(E_{pq})=+M_{pq}E_{pq}$.
- **Diagonal.** $\mathring W(\mathrm{diag}\,d)_{ii}=\sum_k R_{ikik}d_k=-\sum_k M_{ik}d_k$, i.e. $\mathring W|_{\mathrm{diag}}=-M$ on $\mathbf1^\perp$.

Round-sphere control, both blocks: $M=J-I$ gives $+E_{pq}$ and $-(J-I)d=+d$. **Both $+1$, so the relative sign between the blocks and the overall sign are pinned together.**

### The derivation action, from scratch

$(S\cdot W)_{ijkl}=S_{ip}W_{pjkl}+\cdots$ (four slots). For diagonal $W$:

- $|E_{pq}W|^2$: the only nonvanishing components have index pairs $\{p,x\},\{q,x\}$ with $x\ne p,q$, value $(M_{px}+M_{qx})/\sqrt2$, and each such configuration fills $8$ quadruples. So $|E_{pq}W|^2=4\sum_{x\ne p,q}(M_{px}+M_{qx})^2$.
- $|DW|^2$: $(D\cdot W)_{ijkl}=(d_i+d_j+d_k+d_l)W_{ijkl}=2(d_i+d_j)W_{ijkl}$, giving $16\sum_{i<j}(d_i+d_j)^2M_{ij}^2=16\,d^{\mathsf T}(\mathrm{diag}(r)+M^{\circ2})d$ with $r_i=\sum_j M_{ij}^2$.

**Both reproduce the record's stated intermediates exactly.**

### $C$ on the diagonal family

Diagonal block: $\sum_a\nu_a|D_aW|^2=\mathrm{tr}\big((-M)\cdot16(\mathrm{diag}(r)+M^{\circ2})\big)=-16\big(0+2\sum_{i<j}M_{ij}^3\big)=-32\sum_{i<j}M_{ij}^3$.

Off-diagonal block: $\sum_{x\ne p,q}(M_{px}+M_{qx})^2=(M^2)_{pp}+(M^2)_{qq}+2(M^2)_{pq}-2M_{pq}^2$, so
$4\sum_{p<q}M_{pq}[\cdots]=0+4\,\mathrm{tr}(M^3)-8\sum_{i<j}M_{ij}^3$, the first term killed by $M\mathbf1=0$.

$$\boxed{\ C=4\,\mathrm{tr}(M^3)-40\sum_{i<j}M_{ij}^3\ }$$

With the record's dictionary, $\mathrm{tr}(W^3)=\sum_{i<j}M_{ij}^3$ and $\langle W^{\#},W\rangle=\tfrac12\mathrm{tr}(M^3)$, both pinned independently at $S^3\times S^3$ where they give $0.105409$ and $0.948683$ summing to $\theta_0(6)=1.054093$, this is

$$C=-40\,\mathrm{tr}(W^3)+8\langle W^{\#},W\rangle,\qquad \theta=6\,\mathrm{tr}(W^3)+\tfrac18C .$$

**The record's boxed identity and the $+\tfrac18$ coefficient are CONFIRMED, and therefore so is the operative side: bounding $\theta$ above needs $C$ above, which is the $W\mapsto-W$ side.**

### Two structural upgrades the record does not have

1. **$C$ is basis-free and manifestly polynomial.** With $\mathcal Q_W$ the symmetric operator of $S\mapsto|S\cdot W|^2$, $\sum_j\mu_j\langle\mathcal QS^j,S^j\rangle=\sum_j\langle\mathring W\mathcal QS^j,S^j\rangle=\mathrm{tr}(\mathring W\mathcal Q_W)$, no eigenbasis enters. So $C$ is a cubic $O(n)$-invariant of $W$ by construction.
2. **Hence the identity is a theorem, not four evaluations.** Cubic $O(n)$-invariants of a Weyl tensor span a two-dimensional space, and $\mathrm{tr}(W^3)$, $\langle W^{\#},W\rangle$ restrict to independent functions on the diagonal family. The diagonal computation therefore determines $C$ on all of $\mathrm{Weyl}_n$. *The record's "exact, checked at four points" understates what it has.*

### Independent controls, all passed

| quantity | derived here | record |
|---|---|---|
| $\kappa$ from $T=\sum_j|S^jW|^2=\frac{4(n^2+n-8)}{n}\mathrm{tr}(M^2)$ | $\kappa=2(n^2+n-8)/n$ | same |
| $\sum_j\mu_j^2$ at $S^6\times S^6$ | $165a^2=3=\tfrac34|W|^2_{(0,4)}$ | Lemma 3.1 |
| $C(S^6\times S^6)$ | $+8.80955$ | $+8.809545$ |
| $C(S^3\times S^9)$ | $\theta(8-48r)$, $r=107/440$, $=-4.19351$ | $-4.19351$ |
| $\theta(S^3\times S^9)$ | $1.141799$ | closed form agrees |

### The three defects

**(1) The inverted formula is still in the file.** [nondegeneracy.md](../findings/nondegeneracy.md) line 206 states *"On the $\Lambda^2$-diagonal tensors $C=40\sum_{i<j}M_{ij}^3-4\operatorname{tr}(M^3)$"*, **the exact negative of what I derive, and of the boxed identity two lines above it.** This is reviewer 159's formula, left standing under reviewer 160's corrected one. It is the sign the record believes it has repaired twice, sitting in the file as the derivation's own stated output.

**(2) The tight-at-extremum table's column header names the wrong spectral tail.** The header reads $6\operatorname{tr}(W^3)-\tfrac18\cdot\tfrac{\mu_1+\mu_2}{2}T$. At $S^6\times S^6$, $n=12$: $\mu_1+\mu_2=-1.460767$, $T=98.6667$, and that formula returns **$9.142899$**, precisely the figure the same paragraph declares withdrawn. The entries $1.79781$ and $2.66678$ come from the correct $+\tfrac18\cdot\tfrac{\mu_{N-1}+\mu_N}{2}T$. **The row and its header disagree, and the header reproduces the retracted number.**

**(3) "No uniform sign flip explains one positive and one negative value" is a non sequitur.** A global flip sends $(+8.810,-4.194)$ to $(-8.810,+4.194)$, still one positive and one negative. **Mixed signs across the family are invariant under the flip and therefore carry no information about it whatsoever.** The conclusion is nevertheless right; only the argument for it is void. What settles it is the round-sphere pin, done above.

### Tight-at-extremum figures, both verified, and the closure is stronger than recorded

$\mathring W$ spectrum at $S^6\times S^6$: $\{-10a\}\cup\{a\}^{40}\cup\{-5a/6\}^{36}$, $a=1/\sqrt{55}$, $77=N$ eigenvalues, $\sum\mu_j=0$, $\sum\mu_j^2=3$. Bound $=6(0.0224733)+\tfrac18(0.1348400)(98.6667)=\mathbf{1.797813}$, $1.4545\times\theta_0(12)$.

At $S^5\times S^7$: spectrum $\{a_1\}^{14}\cup\{a_2\}^{27}\cup\{b\}^{35}\cup\{12b\}$ with $a_1=0.1954017$; bound $=0.256812+2.409954=\mathbf{2.666766}$, $2.1712\times$. **Both confirmed.**

**In closed form at the balanced product, $n=2m$:**

$$\frac{\text{bound}}{\theta_0(n)}=\frac{2m^2+m+2}{(2m-1)(m-1)}\ >\ 1\quad\text{for every }m,$$

$1.4545$ at $m=6$, $1.2398$ at $m=10$, $1.1093$ at $m=20$, $\to1$ as $m\to\infty$. **So item 3a's margin-$0$ closure holds at every $n$, not only at $n=12$ where it was checked**, the difference $2m^2+m+2-(2m^2-3m+1)=4m+1>0$ never vanishes.

**And it survives the obvious sharpening.** The natural $k$-partial-sum upgrade replaces $\tfrac{\mu_{N-1}+\mu_N}{2}$ by the mean of the top $k$. At $S^6\times S^6$ the top eigenvalue has multiplicity $40$ and at $S^5\times S^7$ multiplicity $14$, so **every $k\le40$ (resp. $\le14$) returns the identical bound.** Fu–Lu's admissible range is $k\le\lfloor(n+2)/4\rfloor=3$ at $n=12$, well inside that. *The route cannot be rescued by widening $k$.*

## CLAIM 2, the verdict is right, the reason is not, and the run was incapable of failing

**$\lambda_{\max}(L_e|_{e^\perp})\ge\tfrac12$ holds at EVERY critical point with nontrivial orbit, the record proves it on [plan.md](../plan.md) itself.** Differentiating $Q(gW)=gQ(W)$ at the identity gives $2W\circ(X\cdot W)=\theta(X\cdot W)$ for $X\in\mathfrak{so}(n)$, i.e. $L_e(X\cdot W)=\tfrac12(X\cdot W)$, and $X\cdot W\perp W$. **So $\tfrac12$ is always an eigenvalue on $e^\perp$, and "all 71 with $\lambda_{\max}>\tfrac12$" was the only outcome the sweep could report.** The single informative outcome ($\lambda_{\max}=\tfrac12$ exactly), is a measure-zero event a Newton solver on random starts will not hit.

**This is a stronger objection than the $\theta$-range one the record gives, and it does not depend on where the sweep reached.** The record's reading (control, not test), is therefore correct, but D1 is not even a control of the instrument: an instrument that cannot return the failing value confirms nothing about itself.

**The reported spread is further confounded with $\theta$ by construction.** $e=W/\theta$ gives $L_e=L_W/\theta$ exactly, so $\lambda_{\max}(L_e|_{e^\perp})=\theta^{-1}\lambda_{\max}(L_W|_{e^\perp})$. On the $\theta$-free scale the sweep's $[1.138,1.560]$ over $\theta\in[0.43,0.59]$ maps into roughly $[0.49,0.92]$, against $0.5\times1.054093=0.527$ at $S^3\times S^3$. **At the low end the sweep's points are no further from Lemma L24 equality than the balanced product is; they are excluded by the $1/\theta$ factor alone.** *The pairing of each $\lambda$ with its own $\theta$ is not recorded, so I can bound the confound but not resolve it point by point; a run reporting $\lambda_{\max}(L_W|_{e^\perp})$ would.*

**Is $\lambda_{\max}$ off $e$ computed correctly? The question is moot here.** $L_e$ is symmetric on a metrised algebra, so $e^\perp$ is invariant and "project, then take the top eigenvalue" is the right procedure. But $L_ee=Q(e)=e$, so $e$ carries eigenvalue exactly $1$, and **every reported value exceeds $1$**, so an unprojected maximum and the projected one coincide on all $71$ points. The documented strip-rule bug (target.md, "kept $e$'s own eigenvalue whenever $\lambda_{\max}>1$") cannot have moved these numbers.

**Does the result carry more than credited? No, it carries less.** The two candidate contents both fail: exclusion is redundant (every point sits at half the competitors' $\theta$), and selectivity of the equality condition is untestable by a method that can only approach $\tfrac12$ from above.

## CLAIM 3, the padding argument is right, and I re-derived the witness value

**$\mathrm{pad}(W_0)\in\mathrm{Weyl}_n$.** $\mathrm{Ric}(\mathrm{pad}\,W_0)_{ij}=\sum_kW_{ikjk}$ picks up only in-block $k$, so it equals $\mathrm{Ric}(W_0)_{ij}=0$ inside the block and vanishes identically outside. First Bianchi is inherited componentwise. ✓

**$\mathfrak{so}(n_0)$ being a subalgebra does keep $W^{\#}$ in the block.** $W^{\#}$ is built from $[Wb_\alpha,Wb_\beta]$ weighted by $\langle x,[b_\alpha,b_\beta]\rangle$. Only $b_\alpha\in\mathfrak{so}(n_0)$ survive $W$, so every bracket lies in $[\mathfrak{so}(n_0),\mathfrak{so}(n_0)]\subseteq\mathfrak{so}(n_0)$, image in the block; and for $x$ orthogonal to the block, $\langle x,[b_\alpha,b_\beta]\rangle=0$, kernel contains the complement. Both halves needed, both hold. ✓ Hence $Q(\mathrm{pad}\,W_0)=\mathrm{pad}\big(Q_0(W_0)\big)$.

**The step the record states loosely, and which is what actually makes the projection a no-op.** Padding commutes with $Q$, but criticality transfers only if $Q_0(W_0)$ is *itself* Ricci-flat, otherwise $\pi_{\mathrm{Weyl}_n}$ subtracts an $n$-dependent Kulkarni–Nomizu term that spreads outside the block, and the two projections differ. **It holds here, and I verified it two ways.** For any diagonal Weyl tensor, $Q$'s vertex matrix is $M^{\circ2}+M^2|_{\text{off-diag}}$, whose row sums are $(M^2)_{ii}-(M^2)_{ii}=0$. And at $W_{\mathbb{CP}^2}$ directly: $\Lambda^2_+\cong\mathfrak{su}(2)$ is a subalgebra with $[\Lambda^2_+,\Lambda^2_-]=0$, so with $w=(2,-1,-1)/\sqrt6$,

$$W^2+W^{\#}=\tfrac16(4,1,1)+\tfrac{2}{6}(1,-2,-2)=(1,-\tfrac12,-\tfrac12)=\theta\,w,\qquad \theta=\tfrac{\sqrt6}{2}=\sqrt{\tfrac32},$$

**exactly, with no projection anywhere.** So $Q(\mathrm{pad}\,W_0)=\theta\,\mathrm{pad}\,W_0$ at every $n\ge4$ and the residual is identically zero. *The recorded $2\times10^{-1}$ and $8\times10^{-2}$ at $n=6,7$ cannot be properties of this point.* **Claim 3 confirmed, and the $\theta=\sqrt{3/2}$ the whole programme turns on falls out of the same three lines.**

**The consequence follows.** The gap theorem needs *ungraded + critical $\Rightarrow\lambda_{\max}>\tfrac12$*; padded $W_{\mathbb{CP}^2}$ is critical at every $n\ge4$, is ungraded (its isotropy $\mathfrak u(2)\oplus\mathfrak{so}(4)$ is not an involution's fixed set), and the record measures $\lambda_{\max}=0.500000$ on the padding-leaving directions at $n=8,10,12$. So a witness exists inside $n\ge12$ and the restriction is no escape. *Caveat: full-$e^\perp$ $\lambda_{\max}$ is tabulated at $n=4$ and $8$ only; at $n=12$ only the padding-leaving subspace is on record. The remaining directions are the ones already present at $n=8$, where the full value is $0.500000$, so the gap is presentational, but it should be filled rather than assumed.*

## Answers

**(a) Asserted as new, already held.** The upper bound's role (*"and this is the side that could ever bound $\theta$ … Nobody had written it down"*), is billed as new twice in the same file, and reviewer 160's own report says the sentence was already in the record before the coefficients existed, correct but unargued. **More seriously, one claim is asserted as new and is false**: the boxed *"$\operatorname{tr}(W^3)/\theta=2/((n-1)(n-2))$ exactly at every sphere product"* holds only at the **balanced** product. Reviewer 160's own three rationals refute it, $r=\tfrac1{55},\tfrac{23}{660},\tfrac{109}{1155}$ at $S^6\times S^6$, $S^5\times S^7$, $S^4\times S^8$, i.e. $0.01818$, $0.03485$, $0.09437$, and I get $107/440=0.24318$ at $S^3\times S^9$, thirteen times the boxed value. The tabulated percentages are the balanced family across $n$. The consequence drawn for [problem.md](../findings/problem.md) item 5 survives, since the conjectured maximiser is balanced; **the quantifier does not, and a later step applying it off-balance will be wrong by an order of magnitude.**

**(b) The re-attribution is CORRECT, and it is half-applied.** [REVIEW_r159.md](REVIEW_r159.md) §3 states $C=40\operatorname{tr}(W^3)-8\langle W^{\#},W\rangle$, $\theta=6\operatorname{tr}(W^3)-\tfrac18C$, and argues $C<0$ at the sphere products at the geometric sign; [REVIEW_r160.md](REVIEW_r160.md) states $(-40,+8)$ and predicts $C(S^3\times S^9)=-4.19351$. **They disagree by an overall sign, and 160 is the one my derivation reproduces**, including $-4.19351$ to six digits at the out-of-sample point 159 never evaluated. But [nondegeneracy.md](../findings/nondegeneracy.md) line 202 still reads *"Reviewers 159 and 160, independently, 159 by deriving it, 160 by recovering the coefficients"*, which is the agreement claim, twenty-nine lines above the correction that withdraws it. **The file asserts both.**

**(c) Closures.** Of the ones checkable from the definitions: item 3a's margin-$0$ closure **holds, and more widely than recorded**, I derive $\text{bound}/\theta_0=(2m^2+m+2)/((2m-1)(m-1))>1$ at every $m$ and show every admissible $k$ gives the same bound. Item 1's closure by $S^5\times S^7$ **holds**: $\theta=1.228239>\sqrt{3/2}=1.224745$, so the above-threshold form dies too. **D1's closure as "control" holds but on a reason the plan does not state**, see claim 2; as written, *"the cone-restricted solver does not reach the $\theta$ range"* is a weaker fact than *"the orbit-tangency identity forces the reported inequality at every critical point"*, and the plan's suggested repair, *"a sweep reaching $\theta$ near $\sqrt{3/2}$"*, **would not fix it**, because $\lambda_{\max}\ge\tfrac12$ is forced there too. *I did not verify item 3b's Morse–Bott retirement or item 4's "equality on the whole $S^p\times S^q$ family" margin claim; neither is settleable from the definitions in the time available, and both remain open on the ledger as far as this review is concerned.*

## What to change

1. **Correct [nondegeneracy.md](../findings/nondegeneracy.md) line 206** to $C=4\operatorname{tr}(M^3)-40\sum_{i<j}M_{ij}^3$.
2. **Correct the tight-at-extremum table header** to $6\operatorname{tr}(W^3)+\tfrac18\cdot\tfrac{\mu_{N-1}+\mu_N}{2}T$; as it stands it regenerates the withdrawn $9.142899$.
3. **Delete the "no uniform sign flip" argument** and replace it with the round-sphere pin, which is three lines and decisive.
4. **Restate the cubic ratio** as an identity at the balanced product, and record $r=\tfrac1{55},\tfrac{23}{660},\tfrac{109}{1155},\tfrac{107}{440}$ across the $n=12$ family as the refutation of the general form.
5. **Fix line 202's attribution** so the file stops claiming 159 and 160 agreed.
6. **Record $C=\mathrm{tr}(\mathring W\,\mathcal Q_W)$** and the two-dimensionality of cubic Weyl invariants, that converts "checked at four points" into a proof.
7. **Rewrite D1's verdict** around the orbit-tangency identity, and state that no sweep of critical points can test Lemma L24 from below.
