# Reviewer 87, the Dimension Lemma, the symmetric census, and the irreducibility hypothesis

**NO NUMERICAL CHECKING WAS USED.** Every computation in this report is exact: sympy `Rational`/`Poly`/`factor` over the rationals and over polynomial rings, plus hand algebra. No floating point, no sampling, no eigenvalue solver, no optimiser. The one place a decimal appears below it is a transcription of an exact rational, given for readability with the rational alongside.

**Method.** Worked cold. Before opening [findings/graded-half.md](../findings/graded-half.md) or [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py) I re-derived the curvature operator of a compact symmetric space from the definitions: $R = A^*A$ where $A:\Lambda^2\mathfrak p\to\mathfrak h$ is the bracket, the eigenvalue on each simple ideal, the trace normalisation, and the Cauchy–Schwarz threshold. Only then did I read the author's text. Casimir constants were recomputed from the Killing forms independently of the project's dictionary, and every family closed form quoted in the record was re-derived from that data rather than checked against it.

---

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $\mathop{\mathrm{tr}}R=n/4$, $c=1/(2(n-1))$, $\lVert W\rVert^2=\lVert R\rVert^2-n/(8(n-1))$ | **CONFIRMED** |
| 2 | Prop 2.2 eigenvalue data; $R$ supported on $\mathfrak h\subset\Lambda^2$; multiplicities $=d_i$ | **CONFIRMED**, and provably stronger than stated |
| 3 | Dimension Lemma, threshold $3n^2(n-1)/(2(7n-4))$, Cauchy–Schwarz direction | **CONFIRMED**, exactly |
| 4 | Coverage of rank $\ge2$ by certificates; family $(n,\dim\mathfrak h)$; twelve exceptionals | **CONFIRMED**, one omission in the residue list |
| 5 | Residue $=$ the compact rank-one spaces; the five low-rank coincidences | **CONFIRMED**, with the same one omission |
| 6 | $\lVert W\rVert^2\ge1/6$ on every compact irreducible symmetric space, equality exactly at $\mathbb{CP}^2$ | **CONFIRMED**, and the strictness gap the certificates leave open is closed below |
| 7 | Irreducibility hypothesis / $S^5\times S^7$ / scope of the advance | **CONFIRMED that the hypothesis is load-bearing**; the write-up's framing overclaims by one word, and the gap it leaves is real but closable in three lines (given below) |
| 8 | $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ refutes the enumeration at [REVIEW.md:217](../REVIEW.md#L217) | **CONFIRMED**, and far too weakly stated, the enumeration fails on at least six further families |

**No error was found in claims 1–6.** I say that plainly rather than manufacturing a concern; the two substantive criticisms are in items 7 and 8 and are about scope and framing, not about the algebra.

---

## 0. The cold derivation, which the rest rests on

Let $M=G/H$ be a compact symmetric space, $\mathfrak g=\mathfrak h\oplus\mathfrak p$, metric $\langle\cdot,\cdot\rangle=-B_{\mathfrak g}|_{\mathfrak p}$. Write $A:\Lambda^2\mathfrak p\to\mathfrak h$, $X\wedge Y\mapsto[X,Y]$.

**(i) $R=A^*A$.** With $R(X,Y)Z=-[[X,Y],Z]$ and $\langle R(X\wedge Y),Z\wedge W\rangle=R(X,Y,W,Z)$, invariance of $B$ gives $R(X,Y,W,Z)=\langle[[X,Y],Z],W\rangle=\langle A(X\wedge Y),A(Z\wedge W)\rangle$. So $R$ is positive semidefinite, $\mathop{\mathrm{im}}R=\mathop{\mathrm{im}}A^*=\iota(\mathfrak h)$ and $\ker R=\iota(\mathfrak h)^\perp$, where $\iota:\mathfrak h\hookrightarrow\mathfrak{so}(\mathfrak p)\cong\Lambda^2\mathfrak p$ is the isotropy representation. This needs only $[\mathfrak p,\mathfrak p]=\mathfrak h$ (true for irreducible pairs, and for type II where $\mathfrak p=\{(X,-X)\}$, $\mathfrak h=\Delta\mathfrak g$) and $\iota$ injective (effectiveness).

**(ii) The eigenvalue on each ideal.** $A^*z=\tfrac12\sum_a e_a\wedge[z,e_a]$, so $AA^*z=-\tfrac12\sum_a[e_a,[e_a,z]]$. Splitting the adjoint Casimir $\sum_{x\in\mathfrak g}[x,[x,z]]=-z$ into $\mathfrak h$- and $\mathfrak p$-parts and writing $B_{\mathfrak h_i}=\alpha_iB_{\mathfrak g}|_{\mathfrak h_i}$ gives

$$\lambda_i=\tfrac12(1-\alpha_i)\ \text{on }\mathfrak h_i,\qquad \lambda_0=\tfrac12\ \text{on the centre }(\alpha_0=0).$$

**(iii) The normalisation.** $\mathop{\mathrm{Ric}}=-\tfrac12B|_{\mathfrak p}=\tfrac12g$, so the Einstein constant is $\tfrac12$, $\mathop{\mathrm{scal}}=n/2$ and $\mathop{\mathrm{tr}}R=\mathop{\mathrm{scal}}/2=n/4$.

This is Petersen–Stanfield Propositions 2.1 and 2.2 rederived: their 2.1 reads $R=\tfrac12(I-P)$ on $\mathop{\mathrm{ad}}_{\mathfrak h}|_{\mathfrak p}$, which is exactly $\lambda_i=\tfrac12(1-\alpha_i)$, and their 2.2 adds $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}R$ and eigenvalue $\tfrac12$ on the centre. I read those two propositions in [petersen-stanfield-2508.11236.txt](https://arxiv.org/abs/2508.11236) only after deriving them.

---

## 1. The constants, CONFIRMED

$$c=\frac{\mathop{\mathrm{tr}}R}{N}=\frac{n/4}{n(n-1)/2}=\frac1{2(n-1)},\qquad \lVert W\rVert^2=\lVert R\rVert^2-2c\mathop{\mathrm{tr}}R+Nc^2=\lVert R\rVert^2-\frac n{8(n-1)} .$$

Both verified symbolically to residual $0$. Two further points the write-up does not make explicit but which are needed for the statement to mean anything:

- $W=R-cI$ **is** the Weyl operator, because for an Einstein metric the non-Weyl part of $R$ is the constant-curvature operator with $K=\mathop{\mathrm{scal}}/(n(n-1))=(n/2)/(n(n-1))=1/(2(n-1))=c$. So $c$ is not an ad-hoc trace subtraction.
- Consistency of the whole normalisation is checkable on the round sphere: $K=1/(2(n-1))$, $\mathop{\mathrm{tr}}R=KN=n/4$, $\mathfrak h=\mathfrak{so}(n)$, $\dim\mathfrak h=N$, $W=0$.

## 2. The eigenvalue data, CONFIRMED, and stronger than the author states

Three sub-claims, each independently checked:

| sub-claim | verdict | reason |
| --- | --- | --- |
| eigenvalue is constant on each block | CONFIRMED | $AA^*$ acts on $\mathfrak h_i$ by the scalar $\tfrac12(1-\alpha_i)$; a Casimir, hence scalar on an ideal |
| multiplicity $=d_i=\dim\mathfrak h_i$ | CONFIRMED | $\iota$ injective, so $\iota(\mathfrak h_i)$ has dimension $d_i$ |
| $R=0$ on the other $N-\dim\mathfrak h$ directions | CONFIRMED, and it is exactly $\ker R$ | $\mathop{\mathrm{im}}R=\iota(\mathfrak h)$ and $R$ self-adjoint, so $\ker R=\iota(\mathfrak h)^\perp$ |

The last row is **stronger** than the write-up claims. Since $\ker R=\ker A$ and $A^*$ is injective, every $\lambda_i$ is *strictly positive*: no simple block can silently degenerate into the kernel. So $\dim\mathfrak h$ is exactly the rank of $R$, and the Cauchy–Schwarz of step 2 is over exactly the non-kernel directions, which is what makes it as strong as it is.

**Independent numerical-free validation of the whole eigenvalue pipeline.** I recomputed $\lambda_i$ from Killing-form ratios for six families with no reference to the project's Casimir dictionary, and in every case $\sum_id_i\lambda_i-n/4$ simplified to $0$ symbolically:

| space | $\mathfrak h$ blocks and $\lambda$ | $\mathop{\mathrm{tr}}R-n/4$ |
| --- | --- | --- |
| $\mathrm{Gr}_{\mathbb C}(p,q)$ | $\tfrac12$; $\tfrac q{2(p+q)}$ on $\mathfrak{su}(p)$; $\tfrac p{2(p+q)}$ on $\mathfrak{su}(q)$ | $0$ |
| $\mathrm{Gr}_{\mathbb R}(p,q)$ | $\tfrac12\big(1-\tfrac{p-2}{p+q-2}\big)$, $\tfrac12\big(1-\tfrac{q-2}{p+q-2}\big)$ | $0$ |
| $\mathbb{HP}^m$ | $\tfrac m{2(m+2)}$ on $\mathfrak{sp}(1)$, $\tfrac1{2(m+2)}$ on $\mathfrak{sp}(m)$ | $0$ |
| $SU(m)/SO(m)$ | $\tfrac{m+2}{4m}$ | $0$ |
| $SO(2m)/U(m)$ | $\tfrac12$; $\tfrac{m-2}{4(m-1)}$ on $\mathfrak{su}(m)$ | $0$ |
| $Sp(m)/U(m)$ | $\tfrac12$; $\tfrac{m+2}{4(m+1)}$ on $\mathfrak{su}(m)$ | $0$ |
| $G$ bi-invariant | $\tfrac14$ ($\alpha=\tfrac12$ for $\Delta\mathfrak g\subset\mathfrak g\oplus\mathfrak g$) | $0$ |

Feeding these into $\theta^2=1/(4\lVert W\rVert^2)$ reproduces, symbolically and with residual $0$, every closed form the record carries:

- $\theta^2(\mathrm{Gr}_{\mathbb C}(p,q))=\dfrac{(p+q)^2(2pq-1)}{pq(4p^2q^2-p^2-q^2-2)}$, the record's "new family", confirmed;
- $\theta^2(\mathbb{CP}^m)=\dfrac{(m+1)(2m-1)}{3m(m-1)}$, $\theta^2(\mathbb{HP}^m)=\dfrac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$;
- $\theta^2(SU(m)/SO(m))=\dfrac{8m(m^2+m-4)}{(m-2)(m-1)(m+1)(m+2)(m+4)}$;
- $\lVert W\rVert^2(G)=\dfrac{n(n-3)}{16(n-1)}$, whence $\theta^2=4(n-1)/(n(n-3))$ and $\lVert W\rVert^2\ge\tfrac16\iff3n^2-17n+8\ge0$;
- the point values $\mathrm{Gr}_{\mathbb C}(2,2)=14/27$ and $\mathrm{Gr}_{\mathbb C}(2,3)=275/774$ exactly.

That last pair is the sharpest test in the file: $\mathrm{Gr}_{\mathbb C}(2,3)$ is the genuine three-eigenvalue case, $\mathfrak h=\mathfrak u(1)\oplus\mathfrak{su}(2)\oplus\mathfrak{su}(3)$ with $\lambda=\tfrac12,\tfrac3{10},\tfrac15$ and $d=1,3,8$, giving $\mathop{\mathrm{tr}}R=3=n/4$ and $\lVert R\rVert^2=21/25$ on the nose. So the block/multiplicity reading of Prop 2.2 is right on the one family where it could plausibly have been misread.

**A caveat on effectiveness, which the census silently needs.** The tabulated $\dim\mathfrak h$ is the dimension of the *isotropy algebra*, and it equals the rank of $R$ only when that algebra acts faithfully on $\mathfrak p$. This fails at $\mathfrak{so}(4)/\mathfrak u(2)$ ($m=2$ in the DIII family: $\mathfrak{su}(2)$ acts trivially on $\Lambda^2\mathbb C^2$, so the formula $\dim\mathfrak h=m^2=4$ exceeds $N=\binom22=1$). The $m\ge4$ shift excludes it, so the census is unaffected, but the exclusion is doing work the write-up does not mention.

## 3. The Dimension Lemma, CONFIRMED exactly

Cauchy–Schwarz on the vectors $(\sqrt{d_i})$ and $(\sqrt{d_i}\lambda_i)$:

$$\Big(\sum_id_i\lambda_i\Big)^2\le\Big(\sum_id_i\Big)\Big(\sum_id_i\lambda_i^2\Big)\ \Longrightarrow\ \lVert R\rVert^2\ \ge\ \frac{(n/4)^2}{\dim\mathfrak h}.$$

Direction correct (it is a **lower** bound on $\lVert R\rVert^2$, which is what a lower bound on $\lVert W\rVert^2$ needs), weights legitimate (all $d_i>0$), and the centre's forced $\lambda_0=\tfrac12$ only makes the bound slack, never invalid. Then

$$\frac{n^2}{16\dim\mathfrak h}-\frac n{8(n-1)}\ \ge\ \frac16\iff\dim\mathfrak h\le\frac{n^2}{16}\cdot\frac{24(n-1)}{7n-4}=\frac{3n^2(n-1)}{2(7n-4)},$$

using $\tfrac16+\tfrac n{8(n-1)}=\tfrac{7n-4}{24(n-1)}$. Solving the threshold symbolically for $D$ and subtracting the author's expression gives $0$. **No error.**

Note the lemma is *one-directional*: failing the dimension test says nothing. $\mathbb{CP}^m$ fails it for every $m$ ($m^2\le3m^2(2m-1)/(7m-2)\iff m\le-1$), which is why the family must be handled by its closed form, consistent, not a gap.

## 4. Coverage, CONFIRMED

**Family formulas.** All eight $(\,n,\dim\mathfrak h\,)$ pairs are correct, checked against $\dim G-\dim K$:

| type | space | $n$ | $\dim\mathfrak h$ | rank | rank $\ge2$ | shift used |
| --- | --- | --- | --- | --- | --- | --- |
| AIII | $\mathrm{Gr}_{\mathbb C}(p,q)$ | $2pq$ | $p^2+q^2-1$ | $\min(p,q)$ | $p\ge2$ | $p=2{+}a$, $q=2{+}a{+}b$ |
| BDI | $\mathrm{Gr}_{\mathbb R}(p,q)$ | $pq$ | $\binom p2+\binom q2$ | $\min(p,q)$ | $p\ge2$ | same |
| CII | $\mathrm{Gr}_{\mathbb H}(p,q)$ | $4pq$ | $p(2p{+}1)+q(2q{+}1)$ | $\min(p,q)$ | $p\ge2$ | same |
| AI | $SU(m)/SO(m)$ | $(m{-}1)(m{+}2)/2$ | $m(m{-}1)/2$ | $m-1$ | $m\ge3$ | $m=3{+}a$ |
| AII | $SU(2m)/Sp(m)$ | $(m{-}1)(2m{+}1)$ | $m(2m{+}1)$ | $m-1$ | $m\ge3$ | $m=3{+}a$ |
| DIII | $SO(2m)/U(m)$ | $m(m{-}1)$ | $m^2$ | $\lfloor m/2\rfloor$ | $m\ge4$ | $m=4{+}a$ |
| CI | $Sp(m)/U(m)$ | $m(m{+}1)$ | $m^2$ | $m$ | $m\ge2$ | $m=2{+}a$ |
| II | compact simple $G$ | $\dim\mathfrak g$ | $\dim\mathfrak g$ | $\mathop{\mathrm{rk}}\mathfrak g$ | $\mathfrak g\ne\mathfrak{su}(2)$ | $\dim\ge6$ |

Every shift threshold is exactly the rank-$\ge2$ condition, and the $p\le q$ convention is harmless by $\mathrm{Gr}(p,q)\cong\mathrm{Gr}(q,p)$. The type II shift $\dim\ge6$ is weaker than needed (the only rank-one simple algebra is $\mathfrak{su}(2)$, $\dim3$, and the next simple algebra has $\dim8$), so it is conservative and still correct. These seven classical type-I families plus type II plus the twelve exceptionals **are** Cartan's full list, so the census is structurally exhaustive.

**Certificates.** Recomputed independently. $P=3n^2(n-1)-2(7n-4)\dim\mathfrak h$ after substitution has all coefficients $\ge0$ in every family, and (the point the script's `all(c >= 0)` check does not report), the **constant term is strictly positive in every one**: $616$, $48$, $7200$, $114$, $3696$, $2192$, $236$, $84$. Since all coefficients are $\ge0$ and $a,b\ge0$, this gives $P\ge$ that constant $>0$, so the inequality is **strict** everywhere on the rank-$\ge2$ families, not merely non-strict. This matters for claim 6 and is established below.

As a transcription guard I also ran an exact rational scan over $p,q\le11$ and $m\le13$ across all eight families plus the compact simple dimensions: **zero violations**, and the tightest ratio $\dim\mathfrak h/\text{bound}$ anywhere in the classical scan is $2/3$, at $\mathrm{Gr}_{\mathbb R}(2,2)$. The lemma has at least $50\%$ headroom on the whole rank-$\ge2$ list.

**The twelve exceptionals.** All twelve $(\dim G,\dim K)$ pairs are correct, and all twelve clear the bound *strictly*:

| space | $n$ | $\dim\mathfrak h$ | bound (exact) |
| --- | --- | --- | --- |
| EI $E_6/Sp(4)$ | 42 | 36 | $54243/145$ |
| EII $E_6/(SU(6)\!\times\!SU(2))$ | 40 | 38 | $7800/23$ |
| EIII $E_6/(SO(10)\!\times\!SO(2))$ | 32 | 46 | $11904/55$ |
| EIV $E_6/F_4$ | 26 | 52 | $12675/89$ |
| EV $E_7/SU(8)$ | 70 | 63 | $28175/27$ |
| EVI $E_7/(SO(12)\!\times\!SU(2))$ | 64 | 69 | $32256/37$ |
| EVII $E_7/(E_6\!\times\!SO(2))$ | 54 | 79 | $115911/187$ |
| EVIII $E_8/SO(16)$ | 128 | 120 | $780288/223$ |
| EIX $E_8/(E_7\!\times\!SU(2))$ | 112 | 136 | $174048/65$ |
| FI $F_4/(Sp(3)\!\times\!SU(2))$ | 28 | 24 | $1323/8$ |
| FII $F_4/SO(9)=\mathbb{OP}^2$ | 16 | 36 | $160/3$ |
| G $G_2/SO(4)$ | 8 | 6 | $168/13$ |

The write-up's "$E_8/SO(16)$: $\dim\mathfrak h=120$ against a bound of $3499$" is $780288/223=3499.05\ldots$, correct. $\mathbb{OP}^2$ at $36\le160/3$ is correct, so the rank-one exceptional genuinely is covered by the lemma with no special case.

## 5. The residue, CONFIRMED, with one omission

The rank-one compact symmetric spaces are $S^n$, $\mathbb{RP}^n$, $\mathbb{CP}^m$, $\mathbb{HP}^m$, $\mathbb{OP}^2$. All five claimed low-rank coincidences check out:

| coincidence | check |
| --- | --- |
| AI $m=2$: $SU(2)/SO(2)=S^2$ | $n=(m{-}1)(m{+}2)/2=2$, $\dim\mathfrak h=1=\binom22$, full $\mathfrak{so}(2)$, constant curvature |
| AII $m=2$: $SU(4)/Sp(2)=S^5$ | $n=(m{-}1)(2m{+}1)=5$, $\dim\mathfrak h=10=\binom52$; $SU(4)\cong\mathrm{Spin}(6)$, $Sp(2)\cong\mathrm{Spin}(5)$ |
| DIII $m=3$: $SO(6)/U(3)=\mathbb{CP}^3$ | $n=m(m{-}1)=6$, $\dim\mathfrak h=9=\dim\mathfrak u(3)$, matches $\mathbb{CP}^3$ exactly |
| CI $m=1$: $Sp(1)/U(1)=S^2$ | $n=m(m{+}1)=2$, $\dim\mathfrak h=1=\binom22$ |
| CII $p=q=1$: $\mathrm{Gr}_{\mathbb H}(1,1)=S^4$ | $n=4pq=4$, $\dim\mathfrak h=3+3=6=\binom42$, full $\mathfrak{so}(4)$; $Sp(2)\cong\mathrm{Spin}(5)$, $Sp(1)^2\cong\mathrm{Spin}(4)$ |

**The omission.** The residue line lists the sphere coincidences as "$\mathrm{Gr}_{\mathbb R}(1,q)$; AI $m=2$; AII $m=2$; CI $m=1$; II $\dim3$" and separately gives DIII $m=3$ under $\mathbb{CP}^m$. It **misses DIII $m=2$**: $SO(4)/U(2)=S^2$, the other rank-one member of that family. Harmless ($S^2$ is already in the residue with $W=0$) but the enumeration of coincidences is one line short, and (see §2) that member is also the one where the $\dim\mathfrak h=m^2$ formula breaks effectiveness. Both points are the same underlying fact and both deserve a line.

$\mathbb{CP}^m$ and $\mathbb{HP}^m$ are handled by closed forms rather than by the lemma, correctly: neither family ever satisfies the dimension test ($\mathbb{CP}^m$ never; $\mathbb{HP}^m$ fails at $m=2$ by $169/13>168/13$ and passes for every $m\ge3$, since $10m^3-11m^2-20m+3>0$ there, $m^2(10m-11)\ge19m^2\ge57m>20m$).

## 6. The theorem, CONFIRMED, including the equality case

$\lVert W\rVert^2\ge\tfrac16$ on every compact irreducible symmetric space, equality exactly at $\mathbb{CP}^2$. Assembling:

- **rank $\ge2$ classical**: $P\ge\text{const}>0$ from §4, so $\lVert W\rVert^2>\tfrac16$ *strictly*;
- **twelve exceptionals**: strict, all twelve;
- **residue $\mathbb{CP}^m$**: $6\lVert W\rVert^2-1=\dfrac{(m-2)(5m-1)}{2(m+1)(2m-1)}$, which is $0$ at $m=2$ and $>0$ for every $m\ge3$;
- **residue $\mathbb{HP}^m$**: $6\lVert W\rVert^2-1=\dfrac{46m^3-57m^2-51m+8}{2(m+2)^2(4m-1)}$, and $46m^3-57m^2\ge35m^2\ge70m>51m$ for $m\ge2$, so strictly positive; the minimum is $45/224$ at $m=2$;
- **residue $S^n,\mathbb{RP}^n$**: $W=0$, $\theta$ undefined, excluded by hypothesis;
- **residue $\mathbb{OP}^2$**: strict, by the lemma.

So equality holds at $\mathbb{CP}^2$ and nowhere else. **The strictness was not established by the script**, which checks only `all(c >= 0)`, that yields $P\ge0$, hence $\lVert W\rVert^2\ge\tfrac16$, which is compatible with a second equality case somewhere on a covered family. Reporting the constant terms (all positive) closes it. This is a real hole in the certificate as written and a one-line fix; the conclusion is unaffected.

One further remark worth recording: equality in the *Cauchy–Schwarz* step would require all $\lambda_i$ equal, hence all equal to the centre's $\tfrac12$, hence $\dim\mathfrak h=n/2$, which $\mathbb{CP}^2$ ($\dim\mathfrak h=4$, $n=4$) does not satisfy. So the equality case of the theorem is *not* an equality case of the lemma, and no confusion between the two is possible.

**$\mathbb{CP}^2$ verification, independently.** $\mathfrak h=\mathfrak u(1)\oplus\mathfrak{su}(2)$, $\lambda=\tfrac12,\tfrac16$, $d=1,3$: $\mathop{\mathrm{tr}}R=\tfrac12+\tfrac12=1=n/4$; $c=\tfrac16$; $\lVert W\rVert^2=(\tfrac13)^2+3(\tfrac16-\tfrac16)^2+2\cdot(\tfrac16)^2=\tfrac19+\tfrac1{18}=\tfrac16$. Matches, and it also drops out of my general $\mathrm{Gr}_{\mathbb C}(1,2)$ formula as $\theta^2=3/2$.

---

## 7. The question that matters, irreducibility, $S^5\times S^7$, and how much this advances Conjecture A

### (a) Conjecture A does not restrict to irreducible, and $S^5\times S^7$ is not a counterexample to it

[README.md](../README.md) states the goal as: $P(W)$ on unit Weyl operators is **maximised on the Weyl tensor of products of spheres** for $n\ge12$. There is no irreducibility hypothesis, no symmetric-space hypothesis, and no $S=0$/diagonality hypothesis in it at all.

$S^5\times S^7$ **is** a product of spheres. It is therefore a member of the conjecture's own permitted answer class, not a competitor to it. Exactly:

$$\theta^2(S^5\times S^7)=\tfrac{264}{175},\qquad \theta_0(12)^2=\tfrac{55}{36},\qquad \tfrac32<\tfrac{264}{175}<\tfrac{55}{36}$$

($264\cdot36=9504<9625=55\cdot175$). So the balanced $S^6\times S^6$ still wins at $n=12$ and Conjecture A is untouched. The "$S=0$, non-diagonal" record entries are descriptive labels on that point, not hypotheses that exclude it from anything.

I re-derived its value from the author's own machinery with no reference to the record: $\lVert R\rVert^2=\tfrac5{32}+\tfrac7{48}=\tfrac{29}{96}$, $\lVert W\rVert^2=\tfrac{29}{96}-\tfrac{12}{88}=\tfrac{175}{1056}$, $\theta^2=1/(4\lVert W\rVert^2)=\tfrac{264}{175}$, reproducing the recorded $264/175$ exactly. The shortfall against the theorem's bound is

$$\tfrac16-\tfrac{175}{1056}=\tfrac1{1056},$$

and for $S^6\times S^6$ it is $\tfrac16-\tfrac9{55}=\tfrac1{330}$. **So the bound fails on reducible symmetric spaces, and by a hair.**

### (b) The irreducibility hypothesis is doing real work, genuinely, not cosmetically

Two independent reasons:

1. **The inequality is false without it**, by the two exact shortfalls just given. The hypothesis is not decoration.
2. **It has to be false without it**, or the conjecture would be false. The conjectured maximiser is a reducible symmetric space, so any theorem asserting $\theta\le\sqrt{3/2}$ over a class containing it would contradict $\theta_0(n)>\sqrt{3/2}$ for $n\ge12$. The hypothesis is exactly the line the conjecture itself draws.

That is the strongest available defence of the author, and I think it holds.

### (c) Where the write-up nevertheless overreaches, and the three lines that repair it

**The overreach is one word.** The headline reads "**THE SYMMETRIC CLASS IS CLOSED**". It is not. The *irreducible* symmetric class is closed. Reducible symmetric spaces are not products of spheres only, $\mathbb{CP}^2\times S^8$, $\mathbb{HP}^2\times S^4$, $\mathbb{CP}^2\times\mathbb{CP}^2$ are all compact symmetric, all reducible, all outside the theorem, and **none of them is a product of spheres**. The Corollary's wording ("no compact irreducible symmetric space … attains the maximum") is honest; the headline and the sentence "So the irreducible symmetric class is eliminated wholesale as a competitor to the sphere products" leave the reader with a closure that has not been proved.

**The repair is three lines, and I supply it.** Let $M=M_1\times\dots\times M_k$ with each $M_a$ an irreducible compact symmetric space normalised to Einstein constant $\tfrac12$ (forced, or the product is not Einstein). Then $R=\bigoplus_aR_a$, zero on the mixed part of $\Lambda^2$, so $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$ and $\mathop{\mathrm{tr}}R=\sum_an_a/4=n/4$. Apply the lemma's own Cauchy–Schwarz **inside each factor**, over all of $\Lambda^2\mathbb R^{n_a}$:

$$\lVert R_a\rVert^2\ \ge\ \frac{(n_a/4)^2}{\binom{n_a}2}=\frac{n_a}{8(n_a-1)}=\lVert R_{S^{n_a}}\rVert^2,$$

with equality **iff** $R_a$ is a multiple of the identity, i.e. iff $M_a$ has constant curvature. Hence for every reducible compact symmetric space,

$$\lVert W(M)\rVert^2\ \ge\ \lVert W(S^{n_1}\times\dots\times S^{n_k})\rVert^2,$$

with equality exactly when every factor is a sphere. Combined with the record's own multi-block result ($\theta^2<2/(k-1)$, so $k\ge3$ forces $\theta<1$; and for $k=2$, $p\mapsto\tfrac p{p-1}$ is strictly convex so $\theta$ is maximised at $p=q$), this gives

> **Corollary (Reviewer 87).** On every compact symmetric space (reducible or not), $\theta\le\theta_0(n)$, with equality for $n$ even exactly at the balanced sphere product $S^{n/2}\times S^{n/2}$.

That is a strictly stronger statement than the author's theorem, it closes the reducible residue the write-up leaves open, and it follows from the author's own two ingredients with no new input. Checked exactly on the cases above: $\mathbb{CP}^2\times S^8$ has $\lVert W\rVert^2=\tfrac{157}{462}$ ($\theta^2=\tfrac{231}{314}$), $\mathbb{HP}^2\times S^4$ has $\tfrac{395}{1056}$ ($\theta^2=\tfrac{264}{395}$), $\mathbb{CP}^2\times\mathbb{CP}^2$ has $\tfrac{11}{21}$, all far above $\tfrac16$, exactly as the domination predicts. As a cross-check on the domination itself, $\mathrm{Gr}_{\mathbb R}(2,2)$ computed as a Grassmannian gives $\lVert W\rVert^2=\tfrac13$, and computed as the product $S^2\times S^2$ gives $\tfrac14+\tfrac14-\tfrac4{24}=\tfrac13$.

### (d) How much does this advance Conjecture A? Bluntly

**More than "not at all", much less than "closed".**

- **What is genuinely bought.** Every compact irreducible symmetric space, and (with the repair above) every compact symmetric space, is eliminated as a competitor at $n\ge12$, by a finite argument with certificates rather than by sampling. The $n\ge12$ threshold falls out of $\theta_0(n)^2\ge\tfrac32\iff n^2-12n+8\ge0$ rather than being assumed. That is a clean, checkable, correct result.
- **What is not bought, and the write-up's own record says so.** $\mathrm{Crit}(P)$ is not the symmetric spaces. The record's open crux is the **ungraded** critical set, where the recorded ceiling is $0.900828$, the target is $\sqrt{3/2}=1.224745$, and the $0.324$ gap is "untested above $n=8$ with no method currently able to test it". The symmetric census does not touch that set: the same file records that random search reaches only $\theta\le0.512$ and that the high-$\theta$ population arrives only from structured constructions. The symmetric spaces were, by the record's own accounting, already the *easy* half.
- **So the framing is inflated.** "THE SYMMETRIC CLASS IS CLOSED" and "eliminated wholesale" describe a sub-family that (i) was already largely catalogued point-by-point in the same file, and (ii) is precisely the family for which $\theta=1/(2\lVert W\rVert)$ makes the problem quadratic rather than cubic. The theorem converts a class-by-class check into a uniform one (a real methodological gain) but it does not narrow the distance to Conjecture A by anything like the amount the headline suggests. **It is a consolidation, not a step toward the crux.**

One further honesty point: the equivalence "$\lVert W\rVert^2\ge\tfrac16\iff\theta\le\sqrt{3/2}$" is *not* part of claims 1–6; it imports the Reviewer 85/86 identity $Q(W)=\lambda W$ with $\lambda=\tfrac12$. I did not audit that identity, but I did test its consequence $\theta=1/(2\lVert W\rVert)$ against three independently recorded values, and it holds exactly in all three: $\mathbb{HP}^2$ ($56/45$), $\mathrm{Gr}_{\mathbb C}(2,2)$ ($14/27$), $\mathrm{Gr}_{\mathbb C}(2,3)$ ($275/774$), plus $S^5\times S^7$ ($264/175$) on the reducible side. That is strong corroboration, and it should be labelled as an imported hypothesis in the theorem statement rather than folded into "equivalently".

---

## 8. The claimed refutation of [REVIEW.md:217](../REVIEW.md#L217), CONFIRMED, and understated

**The arithmetic.** At $n=8$ the bound is

$$\frac{3n^2(n-1)}{2(7n-4)}=\frac{3\cdot64\cdot7}{2\cdot52}=\frac{1344}{104}=\frac{168}{13},$$

and $\dim(\mathfrak{sp}(1)\oplus\mathfrak{sp}(2))=3+10=13=\tfrac{169}{13}>\tfrac{168}{13}$. So it exceeds, by exactly $\tfrac1{13}$. And $13\ne28=\dim\mathfrak{so}(8)$, $13\ne16=\dim\mathfrak u(4)$. The subalgebra is genuine: $\mathfrak{sp}(2)\oplus\mathfrak{sp}(1)$ acts faithfully on $\mathbb H^2=\mathbb R^8$ by left matrix multiplication and right scalars. I also confirm the two thresholds are the same object: $\tfrac{3n}{7n-4}\binom n2=\tfrac{3n^2(n-1)}{2(7n-4)}$, and $\theta^2=\tfrac4{n^2}\tfrac{rN}{N-r}\ge\tfrac32\iff r\ge\tfrac{3nN}{7n-4}$. **REFUTATION CONFIRMED.**

**But "There is a third" badly undersells it.** The claim at line 217 is a flat statement about subalgebras of $\mathfrak{so}(n)$, and as such it fails on at least six further families, several of them already named elsewhere in the same repository:

| subalgebra | $\dim$ | exceeds $\dfrac{3n^2(n-1)}{2(7n-4)}$ when | exact condition |
| --- | --- | --- | --- |
| $\mathfrak{so}(n{-}1)\subset\mathfrak{so}(n)$ | $\binom{n-1}2$ | every $n\ge5$ | $(2n-1)(n-4)>0$ |
| $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ | $m^2{-}1$ | every $m\ge3$ | $m^3+m^2-7m+2>0$ |
| $\mathfrak u(m)\subset\mathfrak{so}(2m)$ | $m^2$ | every $m\ge1$ | (the case line 217 already names) |
| $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)\subset\mathfrak{so}(n)$ | $n(n{-}2)/4$ | every even $n\ge12$ | $n^2-12n+8>0$ |
| $\mathfrak{so}(5)\oplus\mathfrak{so}(7)\subset\mathfrak{so}(12)$ | $31$ | $n=12$ | $31>\tfrac{297}{10}$ |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ | $13$ | $n=8$ | $13>\tfrac{168}{13}$ |
| $\mathfrak g_2\subset\mathfrak{so}(7)$ | $14$ | $n=7$ | $14>\tfrac{49}5$ |
| $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ | $21$ | $n=8$ | $21>\tfrac{168}{13}$ |

The fourth row is worth pausing on: the balanced split exceeds the bound **exactly when $n^2-12n+8>0$**, i.e. exactly for $n\ge12$. That is the conjecture's own threshold, appearing here as the statement that the sphere product's isotropy is one of the "large" subalgebras line 217 claimed did not exist beyond two. So the missing cases are not exotic, the conjectured maximiser is one of them.

So the correct verdict on line 217 is not "the enumeration missed one quaternionic case" but "**the enumeration is wrong as a statement about subalgebras**; large subalgebras exceeding the bound are common, and what actually rules them out is the (F1)/(F2)/(F3) hypotheses of the subalgebra-family theorem", which the record already knows, since [findings/graded-half.md](../findings/graded-half.md) itself lists $\mathfrak g_2$, $\mathfrak{spin}(7)$, $\mathfrak{so}(n{-}1)$, $\mathfrak u(m)$, $\mathfrak{su}(m)$ and $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ as failing exactly those hypotheses. The correction filed at line 217 is therefore right in substance but leaves the reader believing the enumeration is now complete-minus-one, which it is not. The script's own SCOPE note ("does not claim to re-enumerate") is the right instinct; the prose in the findings file does not carry it.

---

## Summary of the actionable defects

1. **Certificate strictness (§6).** `all(c >= 0)` proves $P\ge0$, which permits a second equality case. Report the constant terms (all eight are strictly positive), to get $P>0$ and hence uniqueness of the $\mathbb{CP}^2$ equality on the covered families. One line.
2. **Headline scope (§7c).** "THE SYMMETRIC CLASS IS CLOSED" should read "THE **IRREDUCIBLE** SYMMETRIC CLASS IS CLOSED", and the reducible residue (non-sphere-product products such as $\mathbb{CP}^2\times S^8$) should either be named as out of scope or closed by the three-line per-factor Cauchy–Schwarz domination in §7c, which upgrades the result to $\theta\le\theta_0(n)$ over **all** compact symmetric spaces, equality at the balanced sphere product.
3. **Residue enumeration (§5).** DIII $m=2$ ($SO(4)/U(2)=S^2$) is missing, and it is also the member where $\dim\mathfrak h=m^2$ stops being the effective isotropy dimension. Both worth a line, neither affects the theorem.
4. **Imported hypothesis (§7d).** The "Equivalently $\theta\le\sqrt{3/2}$" clause depends on $Q(W)=\lambda W$ from Reviewers 85/86, not on claims 1–6. Label it.
5. **Understated refutation (§8).** The $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ correction should say the line-217 enumeration fails broadly, not that it missed a third case.

None of these is a mathematical error in the Dimension Lemma, the census, or the theorem. Claims 1 through 6 are correct as stated.
