# REVIEW r336, "Problem P holds if and only if it holds at every critical point --- that is, if and only if Conjecture A holds"

Reviewer r336, cold brief, analytical only. No numerical work was performed: every arithmetic comparison below is exact rational arithmetic in closed form. External source read: [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) (the `pdftotext -layout` extraction of [nienhaus-2311.02404.pdf](https://arxiv.org/abs/2311.02404)); line numbers below are lines of that extraction. No file of the project's own record was opened.

## 1. Hypothesis inventory

### 1.1 Hypotheses the statement carries

| # | Hypothesis | Stated? | Status against the object |
|---|---|---|---|
| H1 | $n \ge 12$, and the equivalence is asserted separately for each such $n$ (it is not a single statement quantified jointly) | stated in Problem P, stated in Conjecture A | passes; both sides carry the same threshold, so the equivalence is per-dimension. A proof of Conjecture A in one dimension yields Problem P in that dimension only |
| H2 | The competition space is $\mathrm{Weyl}_n$ (algebraic Weyl operators), not $S^2_B(\mathfrak{so}(n))$ | stated in the README ("restricted to $W$ of norm 1", $W \in W_n$) and in Conjecture A ($\mathrm{Weyl}^1_n$) | passes; the two domains agree. On the larger space the equivalence would be about a different maximiser and Conjecture A would say nothing |
| H3 | $\mathrm{Weyl}_n \ne 0$ and $\mathrm{Weyl}^1_n \ne \emptyset$ | unstated | passes for $n \ge 4$, hence for $n \ge 12$ |
| H4 | "products of spheres" means the *balanced* split $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ with its symmetric Einstein metric | **unstated** in Problem P; pinned down in Conjecture A ($W^{\mathrm{crit}}_{\mathrm{sym}}$, L219–L222) | passes, but only after an imported step: $\theta_{k,l}$ is maximised over splits at the balanced one (Finding 2) |
| H5 | "$P$ is maximized on $W_{\mathrm{sym}}$" is a statement about the *value* of the maximum, not about uniqueness of the maximiser | **unstated** | load-bearing. Under the uniqueness reading the "if" direction is not delivered by Conjecture A (Finding 4) |
| H6 | "Problem P holds at a critical point $W$" means the inequality $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ | **unstated** | load-bearing. Under the literal reading ("every critical point is a sphere product / a maximiser") the statement is false (Finding 3) |
| H7 | "critical point" means critical point of $P$ restricted to the manifold $\mathrm{Weyl}^1_n$ | Material A says "Lagrange multipliers on $\{|W|=1\}$"; Conjecture A says "critical point of $P$ among $\mathrm{Weyl}^1_n$" | passes, and the two coincide only because $\mathrm{Weyl}_n$ is $Q$-invariant (check T2 below) |
| H8 | $\ker W \ne 0$ is admitted | unstated | passes vacuously: the argument is variational and imposes no rank, kernel, or genericity condition on $W$. $W_{\mathbb{CP}^2}$, which has a large kernel, is a legitimate competitor and a legitimate critical point |
| H9 | The maximum is attained | **unstated** | passes (compactness, check T1) but is nowhere written in the material |

### 1.2 Hypotheses of the imported theorems

| # | Import | Where used | Hypotheses | Check |
|---|---|---|---|---|
| T1 | Weierstrass extreme value theorem | "if it holds at every critical point $\Rightarrow$ Problem P" | continuous function, non-empty compact domain | $P$ is a cubic polynomial, $\mathrm{Weyl}^1_n$ is a closed bounded subset of the finite-dimensional space $\mathrm{Weyl}_n$, non-empty for $n\ge4$. Passes |
| T2 | $Q(R,S)\in\mathrm{Weyl}_n$ for $R,S\in\mathrm{Weyl}_n$ | needed for Material A's Euler–Lagrange equation to read $Q(W)=\lambda W$ rather than $\mathrm{proj}_{\mathrm{Weyl}_n}Q(W)=\lambda W$ | none beyond $R,S$ of Weyl type | Nienhaus Lemma 2.13, L1086–L1092, attributed to [AH11]; used again in the proof of Lemma 2.17 at L1195 ("the fact that $Q(W)\in\mathrm{Weyl}_n$ for any Weyl curvature operator"). Passes |
| T3 | Lagrange / first-order condition: a critical point of $P$ on the unit sphere satisfies $Q(R)=\lambda R$, $\lambda=P(R)$ | Material A | the constraint $|W|^2=1$ is a regular level set ($\nabla|W|^2 = 2W \ne 0$ on it); $P$'s polarisation is fully symmetric | Nienhaus Remark 2.16(ii), L1164–L1178, gives exactly $0=\frac{d}{dt}\big|_0 P(\cos t\,R+\sin t\,R_1)=3\langle Q(R),R_1\rangle$. $\lambda=P(W)$ follows by pairing with $W$. Passes |
| T4 | Full symmetry of the trilinear form polarising $P$ | Material A's justification of T3 | for the $W^2$ half: self-adjointness; for the $W^\#$ half: total antisymmetry of the structure constants of $\mathfrak{so}(n)$ in an orthonormal basis w.r.t. an $\mathrm{Ad}$-invariant inner product | Passes, but Material A justifies only the first half (Finding 5). I re-derived the second half independently in §3.5 |
| T5 | $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}$, $P(W_{S_{k,l}})=\theta_{k,l}$, and $Q(W_{S_{k,l}})=\theta_{k,l}W_{S_{k,l}}$ | needed to close H4 and to certify that $W^{\mathrm{crit}}_{\mathrm{sym}}$ is a unit competitor | $k+l=n$; $k,l\ge2$ for $\theta_{k,l}\ne0$ | Nienhaus Proposition 2.25, L1483–L1492. Passes; balanced splits at $n\ge12$ have $k,l\ge6$ |
| T6 | $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ and $W_{\mathbb{CP}^2}\in\mathrm{Weyl}_n$ is a $Q$-eigenvector for every $n\ge4$ | used only by me, to exhibit the witness in Finding 3 | $n\ge4$ | Nienhaus L1775–L1790, plus the definition of $\Theta$ at L4694, which excludes $\mathbb{R}W_{\mathbb{CP}^2}$ from the critical set precisely because it is one. Passes |

## 2. Imported-theorem checks, sources

- **Conjecture A, verbatim**, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) L212–L222: "Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n=\{W\in\mathrm{Weyl}_n\mid\|W\|=1\}$. If either $n\ge12$ or $8\leqslant n\leqslant11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\leqslant P(W^{\mathrm{crit}}_{\mathrm{sym}})$." The conclusion is an **inequality at critical points**, with no equality clause and no classification clause.
- **$Q$ preserves $\mathrm{Weyl}_n$**, Lemma 2.13, L1086–L1092, and its reuse at L1195.
- **First-order condition**, Remark 2.16(ii), L1164–L1178.
- **Sphere-product potentials**, Proposition 2.25, L1483–L1492; the Einstein constant of the balanced product is Proposition 2.24, L1475–L1481.
- **$\mathbb{CP}^2$ competitor**, L1775–L1790 ($P(W_{\mathbb{CP}^2})=\sqrt{3/2}$, valid in every $n\ge4$ by the zero-extension $\mathrm{Weyl}_{n-1}\hookrightarrow\mathrm{Weyl}_n$ at L1767) and L4689–L4695.

## 3. Findings

### Finding 1, Material B is not an argument for this statement (stands)

**Re-derivation.** I checked all three parts of Material B from the definitions, in my own notation, and all three are correct.

(a) With the diagonal defined to be zero, $\sum_{j\ne i}v_iv_j=v_i(-v_i)=-v_i^2$; $\sum_{j\ne i}\frac{v_i^2+v_j^2}{n-2}=\frac{(n-1)v_i^2+(1-v_i^2)}{n-2}=v_i^2+\frac1{n-2}$; $\sum_{j\ne i}\frac1{(n-1)(n-2)}=\frac1{n-2}$. The three cancel. Correct.

(b) The residual off the diagonal is $-\frac{v_i^2+v_j^2}{n-2}+\frac1{(n-1)(n-2)}=a_i+a_j+c$, and for hollow symmetric $T$ with vanishing row sums, $\sum_{i<j}(a_i+a_j)T_{ij}=\sum_{i\ne j}a_iT_{ij}=\sum_i a_i\!\sum_{j\ne i}T_{ij}=0$ and $\sum_{i<j}cT_{ij}=\frac c2\sum_i\sum_{j\ne i}T_{ij}=0$. Correct. (The diagonal of $vv^{\mathsf T}$ is irrelevant either way, since $\mathcal D_n$ is hollow, so the claim holds both for the projection of $\mathrm{hollow}(vv^{\mathsf T})$ and for that of $vv^{\mathsf T}$.)

(c) At the balanced two-value $v$, write $A=\frac{2}{n(n-2)}-\frac1{(n-1)(n-2)}=\frac{2(n-1)-n}{n(n-1)(n-2)}=\frac1{n(n-1)}$. Then $Z_{\text{same}}=\frac1n+A=\frac1{n-1}$ and $Z_{\text{cross}}=-\frac1n+A=\frac{2-n}{n(n-1)}$, so the ratio is $\frac{n}{2-n}=-\frac{n}{n-2}=-\frac{n/2}{n/2-1}$, as claimed. Independently, for the equal-radius $S^{n/2}\times S^{n/2}$ with sectional curvature $K$ inside the factors and $0$ across, the Weyl vertex matrix is $S=\lambda-(a_i+a_j+c)$ with $a_i$ constant by symmetry; writing $u=2a+c$, the vanishing row sum $(\tfrac n2-1)(K-u)+\tfrac n2(-u)=0$ gives $u=\frac{(n/2-1)K}{n-1}$, hence $S_{\text{same}}=\frac{(n/2)K}{n-1}$, $S_{\text{cross}}=-\frac{(n/2-1)K}{n-1}$ and the same ratio $-\frac{n/2}{n/2-1}$. Correct.

**Concrete failure.** Nothing in Material B mentions $P$, $Q$, a critical point, a maximum, attainment, or a biconditional. Its content is: $Z(v)$ is the orthogonal projection of the hollow rank-one matrix $v_iv_j$ onto the diagonal Weyl space $\mathcal D_n$, and at the balanced two-value $v$ that projection is proportional to the vertex matrix of the balanced sphere product. Substituting Material B for the statement under review leaves both directions of the "if and only if" untouched: no clause of it constrains $\max_{\mathrm{Weyl}^1_n}P$, and no clause of it constrains the set of critical points. The designated argument therefore establishes a different proposition.

**Defence attempted.** The strongest defence is that Material B might be the engine of the *hard* content and the equivalence a trivial wrapper. It is not: Material B lives entirely inside the coordinate-diagonal subspace $\mathcal D_n$ (the "already solved" case per the README) and is a statement about a linear projection, whereas the statement under review is a statement about the global variational structure of $P$ on all of $\mathrm{Weyl}^1_n$. A second defence, that Material B supplies H4 (the balanced product is the right comparison object) via its part (c), fails too: (c) identifies the balanced product as the object $Z(v)$ is parallel to at one particular $v$, not as the maximiser over splits, and it presumes $n$ even ($k=n/2$), so it does not even cover the odd $n\ge13$ that Problem P and Conjecture A both include. The defence fails; the finding stands.

Two further remarks on Material B, offered without prejudice to whatever lemma it actually belongs to: (i) the heading "the equality case is the balanced product" is a *computation at* the balanced $v$, not a proof that equality *forces* the balanced $v$, the quoted text contains no optimisation whose equality case is being analysed; (ii) the argument of (c) is confined to even $n$.

### Finding 2, attainment, criticality of the maximiser, and the split-monotonicity step are nowhere in the material (stands)

**Re-derivation.** The equivalence is true for $n\ge12$ under readings H5 and H6, and here is the whole of it.

*"Only if" ($\Rightarrow$).* Suppose $\max_{\mathrm{Weyl}^1_n}P=P(W^{\mathrm{crit}}_{\mathrm{sym}})$. Any critical point $W\in\mathrm{Weyl}^1_n$ satisfies $P(W)\le\max P=P(W^{\mathrm{crit}}_{\mathrm{sym}})$, which is Conjecture A at $n\ge12$. This direction needs nothing at all, not compactness, not Lagrange, not $Q$-invariance; even a supremum would do.

*"If" ($\Leftarrow$).* $P$ is a polynomial and $\mathrm{Weyl}^1_n$ is compact and non-empty, so the maximum is attained at some $W^\ast$ (T1). $\mathrm{Weyl}^1_n$ is a regular level set of $W\mapsto|W|^2$, so $W^\ast$ is a critical point of $P|_{\mathrm{Weyl}^1_n}$ (T3). Conjecture A then gives $P(W^\ast)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$, while $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathrm{Weyl}^1_n$ gives $P(W^\ast)\ge P(W^{\mathrm{crit}}_{\mathrm{sym}})$. Hence equality, and the maximum is attained at the balanced sphere product.

*Closing H4.* If "Problem P holds" is read loosely as "the maximum is attained at *some* $S^k\times S^l$", the two readings coincide, but only via T5: with $k+l=n$, $\log\!\big[(1-\tfrac1k)(1-\tfrac1l)\big]$ has $k$-derivative $\frac1{k(k-1)}-\frac1{l(l-1)}$, which is positive exactly when $k<l$, so $\theta_{k,l}$ is maximised at the most balanced split, and $\theta_{1,n-1}=0$. Hence $\max_{k}P(W_{S_{k,l}})=P(W^{\mathrm{crit}}_{\mathrm{sym}})$ and the loose reading implies the sharp one.

**Concrete failure.** Material A supplies exactly one of these ingredients, the first-order condition $Q(W)=\lambda W$, $\lambda=P(W)$. It does not assert that the maximum is attained, does not observe that the maximiser is therefore a critical point (the step that carries the entire "if" direction), and does not contain the split-monotonicity computation that identifies "products of spheres" with the balanced product. Material B supplies none of them (Finding 1). So the record's argument for the biconditional consists of a first-order condition and nothing else; the two facts that make the biconditional true are unwritten.

**Defence attempted.** The strongest defence is that these steps are so standard that writing them is pedantry, Weierstrass on a compact sphere, and Lagrange on a regular level set. I accept that for T1 and T3, and I would not raise a finding on those alone. The defence fails on the third ingredient: the identification of "products of spheres" with $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ is *not* standard, it is the content of Proposition 2.25 plus the monotonicity computation above, and without it the "only if" direction is not even well posed, because the two sides of the claimed equivalence compare against different objects. The finding stands, at the reduced scope: the gap is the H4 step, with T1/T3 recorded as unwritten but harmless.

### Finding 3, "it holds at every critical point" is false under its literal reading; only the inequality reading is defensible (stands, hypothesis correction)

**Re-derivation.** "Problem P" is a statement about a maximum; "Problem P holds at a critical point $W$" is not literally meaningful. Two readings are available: (i) $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$, which is Conjecture A; (ii) every critical point is a maximiser, or is the Weyl operator of a sphere product. Reading (ii) is what the phrase says on its face, and it is false.

**Concrete failure.** Two witnesses, both closed form.

1. $Q$ is quadratic and $\#$ is quadratic, so $Q(-W)=(-W)^2+(-W)^\#=W^2+W^\#=Q(W)$. Hence if $Q(W)=\lambda W$ then $Q(-W)=-\lambda(-W)$: critical points come in antipodal pairs, and $-W^{\mathrm{crit}}_{\mathrm{sym}}$ is a critical point with $P=-\theta_n<0$. No maximiser.
2. $W_{\mathbb{CP}^2}\in\mathrm{Weyl}_n$ for every $n\ge4$ (Nienhaus L1767–L1777), it is a $Q$-eigenvector, hence a critical point of $P$ on $\mathrm{Weyl}^1_n$, and $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ in *every* dimension (L1785). It is not the Weyl operator of a sphere product. And for $n\ge12$ it is not a maximiser: for even $n$, $\theta_n^2=2\frac{(n-1)(n-2)}{n^2}=2\big(1-\tfrac3n+\tfrac2{n^2}\big)$, whose $n$-derivative $2\big(\tfrac3{n^2}-\tfrac4{n^3}\big)=\tfrac{2(3n-4)}{n^3}$ is positive, and at $n=12$ it equals $\tfrac{2\cdot11\cdot10}{144}=\tfrac{55}{36}>\tfrac{54}{36}=\tfrac32$; for odd $n$, $\theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}>\tfrac32$ reduces to $4(n-1)(n-3)>3(n+1)(n-2)$, i.e. $n^2-13n+18>0$, whose larger root is $\tfrac{13+\sqrt{97}}2<12$. So $\sqrt{3/2}<\theta_n$ throughout $n\ge12$, strictly.

**Defence attempted.** The defence is that no competent reader would take reading (ii), since the clause is immediately glossed as "that is, if and only if Conjecture A holds", and Conjecture A is unambiguous. I largely accept this: the intended content is reading (i), and under it the statement is true. The finding is therefore recorded as a **hypothesis correction, not a refutation**: the phrase "it holds at every critical point" must be replaced by "$P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ at every critical point $W\in\mathrm{Weyl}^1_n$", because the class of critical points strictly contains non-maximisers and non-products in every dimension $n\ge12$.

### Finding 4, under a uniqueness reading of "is maximized on", the "if" direction is not delivered (stands, scope correction)

**Re-derivation.** Conjecture A's conclusion is the non-strict $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ with no equality clause. From a non-strict inequality one obtains "the maximum value equals $\theta_n$ and is attained at the balanced product" and nothing more.

**Concrete failure.** Conjecture A is logically consistent with the existence of $W\in\mathrm{Weyl}^1_n$, $W\notin SO(n).W^{\mathrm{crit}}_{\mathrm{sym}}$, with $P(W)=\theta_n$ exactly. If "Problem P holds" is read as "the maximum is attained *only* on Weyl operators of sphere products" (a rigidity statement) then Conjecture A does not imply it, and the biconditional fails in the "if" direction. Note that Nienhaus himself keeps the two apart: at L4689–L4691 he separately records that in dimensions $8$–$11$ "this maximum is only achieved by $W_{\mathbb{CP}^2}$", i.e. the uniqueness clause is stated as extra content beyond the inequality.

**Defence attempted.** The defence is that any tying maximiser is itself a critical point, so Conjecture A applies to it. It does, and returns $\le$, which is satisfied by the tie. The defence cannot close the equality case, and no other route from a non-strict inequality to rigidity exists. The finding stands as a scope condition: the equivalence is an equivalence of *value* statements (H5), and the record should say so, since a natural reading of "is maximized on the Weyl tensor of products of spheres" includes uniqueness.

### Finding 5, Material A's justification of the full symmetry of the polarisation covers only the $W^2$ half (stands, minor)

**Re-derivation.** Material A derives full symmetry of $T(X,Y,Z)$ "by the trace identity $\mathop{\mathrm{tr}}(XYZ)=\mathop{\mathrm{tr}}(ZYX)$". That identity does the $W^2$ half: $\langle X,YZ+ZY\rangle=\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(XZY)$ is the sum over both cyclic classes and so is invariant under every permutation of $X,Y,Z$. It says nothing about $\#$. I verified the $\#$ half independently: in an orthonormal basis $b_\alpha$ of $\mathfrak{so}(n)$ for the (bi-invariant) trace form, the structure constants $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$ are totally antisymmetric, and $\langle R\#S,T\rangle=\tfrac12\sum c_{\alpha\beta\gamma}c_{\alpha'\beta'\delta}R_{\alpha\alpha'}S_{\beta\beta'}T_{\gamma\delta}$; exchanging the index pairs $(\beta,\beta')\leftrightarrow(\gamma,\delta)$ produces $c_{\alpha\gamma\beta}c_{\alpha'\delta\beta'}=(-1)^2c_{\alpha\beta\gamma}c_{\alpha'\beta'\delta}$, so the form is symmetric. Exchanging $R\leftrightarrow S$ is likewise two sign flips.

**Concrete failure.** The stated justification is incomplete, not wrong: the trace identity is true and is used correctly, it simply does not reach $W^\#$, which is where the non-trivial content sits.

**Defence attempted.** One could read "made fully symmetric by the trace identity" as applying to the $B$ of $T(X,Y,Z)=\langle X,B(Y,Z)\rangle$ after $B$ has already been taken to be $Q(\cdot,\cdot)$, whose Weyl-valuedness and symmetry are imported wholesale from [AH11] via Nienhaus Lemma 2.13. Under that reading the sentence is a gesture at a citation rather than a proof, and nothing is wrong. Because the conclusion is true, citable (Nienhaus Remark 2.16(ii), L1164–L1178, states the first-order condition outright), and I have re-derived it, this is recorded as minor.

### Finding 6, withdrawn: "the Euler–Lagrange equation should be $\mathrm{proj}_{\mathrm{Weyl}_n}Q(W)=\lambda W$"

**Reason for withdrawal.** I suspected that Material A's $Q(W)=\lambda W$ was an unjustified strengthening, since the gradient of $P|_{\mathrm{Weyl}_n}$ is a priori only the $\mathrm{Weyl}_n$-projection of the ambient gradient $3Q(W)$, and since $\mathrm{tr}\,Q(R)$ and the Ricci contraction of $Q(R)$ need not vanish for general $R$. The suspicion is wrong: Nienhaus Lemma 2.13 (L1086–L1092), from [AH11], states that $Q(R,S)$ is again of Weyl type whenever $R,S$ are, and the fact is used explicitly at L1195. So $\mathrm{Weyl}_n$ is $Q$-invariant, the projection is the identity on $Q(W)$, and Material A's equation is correct as written. Recorded so the next reviewer does not re-open it.

### Finding 7, withdrawn: "Material A's claim that $Q$ preserves coordinate-diagonality contradicts Nienhaus L1116–L1119"

**Reason for withdrawal.** Nienhaus warns at L1116–L1119 that "after diagonalizing a curvature operator $R$, the expression $Q(R)$ is not diagonal anymore". That warning concerns diagonality in an arbitrary orthonormal basis of $\mathfrak{so}(n)$. Material A's claim is about the *coordinate* 2-plane basis $e_i\wedge e_j$, and there it is correct: $[e_i\wedge e_j,\ e_k\wedge e_l]$ is (a multiple of) a single coordinate bivector, non-zero only when the index pairs share exactly one index, so $\langle[b_\alpha,b_\beta],b_\gamma\rangle\langle[b_\alpha,b_\beta],b_\delta\rangle$ vanishes unless $\gamma=\delta$, whence $W^\#$ is diagonal and $(W^\#)_{ij,ij}=\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}$. No conflict.

## 4. Verdict

**GAP.**

The statement is *true* for $n\ge12$ under the readings H5 (value, not uniqueness) and H6 (inequality at critical points), and I give the complete proof in Finding 2, six lines, resting on Weierstrass, the regular-level-set first-order condition, and the monotonicity of $\theta_{k,l}$ in the split. It is *not proved by the material supplied*:

- **Material B, which the record names as the argument, proves a different proposition** (Finding 1), that $Z(v)$ is the orthogonal projection onto $\mathcal D_n$ and is parallel to the balanced product's vertex matrix at the balanced two-value $v$. All three of its parts are correct; none of them touches the biconditional. This alone is the gap.
- **Material A supplies one of the three ingredients** (the first-order condition) and leaves attainment, the criticality of the maximiser, and the split-monotonicity identification of "products of spheres" with $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ unwritten (Finding 2). The last of these is genuine mathematical content (Nienhaus Proposition 2.25 plus a monotonicity computation), not boilerplate.
- **Two hypotheses must be added to the statement** before it is even true as written: the critical-point clause is the inequality $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$, not a classification of critical points (Finding 3, $W_{\mathbb{CP}^2}$ is a non-product critical point in every $n\ge12$, with $\sqrt{3/2}<\theta_n$ shown in closed form), and "is maximized on" is the value statement, not the rigidity statement (Finding 4).

Closing the gap requires writing Finding 2's proof into the record with H4/H5/H6 made explicit, and re-attaching this result to an argument that is about it. It does not require new mathematics.
