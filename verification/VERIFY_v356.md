# Verifier v356, Lemma L115: the heading $\lambda_{\max}(M)=\theta$ at every global maximiser, the restricted display, the cap that would close it, the by-product $\theta\ge\max_\alpha\lambda_\alpha$, the two comparisons with Conjecture A, and the Lean files

Cold brief ([BRIEF_L115.md](BRIEF_L115.md)), read in full. No numerical work was done and no scripts were written. Every value below is exact and derived by hand from the quoted passages, from the definitions in the brief, or from closed-form test objects. The cited findings lines (bounds-relaxations.md 268, 284, 286, 288, 290, 292, 294 and second-order.md 55, 61, 63 and the odd lines 532 to 548) were printed and match the brief verbatim. Log: [agent_logs/verify-L115-v356.log](../agent_logs/verify-L115-v356.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Heading: $\lambda_{\max}(M)=\theta$ at every global maximiser, unrestricted | GAP |
| C2 | Passage B: $M$ symmetric, $P=\langle\lambda,M\lambda\rangle$, $\theta\le\lambda_{\max}(M)$, $M\lambda=\theta\lambda$ at a critical point, $\mathop{\mathrm{diag}}M=\lambda$ | CONFIRMED |
| C3 | The step from Lemma L24 to $\lambda_{\max}(L_e\vert_{\mathcal D})=1$ does not follow (the record's own GAP grade) | CONFIRMED |
| C4 | Restricted display: $\lambda_{\max}(M)=\theta$ at every coordinate-diagonal global maximiser and at every $S^m\times S^m$, $m\ge4$ | GAP |
| C5 | A cap on $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})$ would close the unrestricted form | CONFIRMED AS ALGEBRA |
| C6 | $\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A | GAP |
| C7 | The pointwise statement at maximisers is Conjecture A rewritten, neither easier nor harder | GAP |
| C8 | By-product: $\theta\ge\max_\alpha\lambda_\alpha$ at every global maximiser | CONFIRMED |
| C9 | Passage B's run values: the $C_5$ pair $0.809017$, $0.670820$ and the suprema $\sqrt{3/2}$ at $n=6,8,10$ | HYPOTHESIS-DEBT |
| C10 | Passage D, the Lean declarations, against Passages A and B | CONFIRMED AS ALGEBRA |

**What the round should do:** retitle L115 to what is proven (the by-product with margin $\sqrt{3/2}-1$, plus C2), put an argument for the restricted display on file with its hypotheses stated (or drop the $S^m\times S^m$ clause), give C6 a range and a real witness or withdraw "strictly", and make C7 conditional on C1.

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with the Frobenius inner product, $N=n(n-1)/2$, and $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ totally antisymmetric in any orthonormal basis. $c'^2_{\alpha\beta\gamma}$ is the entrywise square, totally symmetric.
- $(X^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\eta}X_{\gamma\varepsilon}X_{\delta\eta}$, Hamilton's normalisation $Q(\mathrm{Id})=(n-1)\mathrm{Id}$. In it $c^2=1$ on every coordinate triple $\{e_{ik},e_{jk},e_{ij}\}$ ($i,j,k$ distinct), and $c^2=2$ on the triple $\omega_1,\omega_2,\omega_3$ of unit self-dual forms of $\mathbb R^4$ (for instance $\omega_1=(e_{12}+e_{34})/\sqrt2$).
- Consistency with the record, checked by hand: in $n=4$ on $\Lambda^+$ with $W^+=\mathop{\mathrm{diag}}(a,b,c)$, $a+b+c=0$, one gets $P^+=\sum a^3+6abc=9abc$. The unit $W_{\mathbb{CP}^2}$, $W^+=t(2,-1,-1)$ with $t=1/\sqrt6$, gives $P=18t^3=\sqrt{3/2}$, and $S^2\times S^2$, the same block on both sides with $t=1/\sqrt{12}$, gives $P=36t^3=\sqrt3/2=\theta_0(4)$. Both match the brief.
- $L_e X=e\circ X$, self-adjoint on symmetric operators because $\langle X\circ Y,Z\rangle$ is a symmetric trilinear form. $\pi_{\mathcal D}$ is the orthogonal projection onto $\mathcal D$, and "$L_e\vert_{\mathcal D}$" is read as the compression $\pi_{\mathcal D}L_e\vert_{\mathcal D}$, the only reading under which it is a symmetric operator on $\mathcal D$.
- A global maximiser is a unit $W$ with $P(W)=M(n)$, and $M(n)\ge\sqrt{3/2}$ for $n\ge4$ by padded $W_{\mathbb{CP}^2}$ (brief). The smallest admissible dimension is $n=4$ since $\mathcal W_3=0$.

## Hypothesis inventory

| Hypothesis | Carried by | Object applied to | Checked | Used by the written text |
|---|---|---|---|---|
| $W$ a global maximiser | C1, C4, C8 | maximisers | yes | C8's second route only (via $\theta=M(n)\ge\sqrt{3/2}$). No argument on file for C1 or C4 uses global over local. |
| $\lVert W\rVert=1$, so $\lVert\lambda\rVert=1$ | C2, C8 | every unit $W$ | yes | C2 (Rayleigh bound), C8 second route |
| $Q(W)=\theta W$ | C2 | critical points | yes, given in the brief | C2 ($M\lambda=\theta\lambda$) |
| a choice of orthonormal eigenbasis | $M$ itself | every $W$ | the choice is never quantified | everywhere $M$ appears (see withdrawn W2) |
| coordinate-diagonal | C4 | coordinate-diagonal maximisers, $S^m\times S^m$ | yes | stated, but the quoted passages carry no argument that uses it |
| $m\ge4$ | C4 | $S^m\times S^m$ | yes | stated, no argument on file uses it |
| L24: critical, $\theta>0$, local maximiser | L24 | global maximisers | all three hold at a global maximiser ($\theta=M(n)\ge\sqrt{3/2}>0$) | the text applies L24's conclusion to $\mathcal D$, outside L24's domain $\mathcal W_n\cap W^\perp$ (C3) |
| L24 at $S^m\times S^m$ | C4 | $S^m\times S^m$ | local maximality of $S^m\times S^m$ is not on file in the quoted passages. At $m=2$ it fails (Section 4). | implicitly, if C4 rests on L24 |
| $L_e$ preserves $\mathcal W_n$ (so also $\mathcal W_n^\perp$) | C5 | $W$ at a maximiser | stated only at the single point $Q(W)=\theta W$ | needed by C5's sufficiency, unstated |
| $n\ge12$ | Conjecture A (Passage B) | C6, C7 | yes | C6 and C7 carry no range |
| $M(n)\ge\sqrt{3/2}$ | brief | $n\ge4$ | yes | C8 second route, and C6 at $n\le11$ |

Findings from the inventory: "global", "coordinate-diagonal" and "$m\ge4$" are stated in C4 with no use visible in the quoted text. The invariance of $\mathcal W_n$ under $L_e$ is used by C5 and stated nowhere.

## 1. C1, the heading

**Located.** Line 268: "Lemma L115, $\lambda_{\max}(M)=\theta$ at every global maximiser". Line 292: "The unrestricted form is not citable". Line 286 says the step behind the unrestricted form is the one "Lemma L115 grades a GAP eighteen lines above", and $286-18=268$ is the heading line itself.

**The claim.** By C2, $\lambda_{\max}(M)\ge\theta$ always at a critical point, so C1 is the upper bound $x^{\mathsf T}Mx\le\theta\lVert x\rVert^2$ for all $x\in\mathbb R^N$. The only route in the quoted passages is C3's, which the record itself rejects. No other argument is on file.

**Exhibited failure.** No object on file violates C1. The failure is that the numbered title asserts, as the lemma's content, the form its own body calls uncitable. What would have to be proved: at every global maximiser, $\langle x,L_ex\rangle\le\lVert x\rVert^2$ for every $x\in\mathcal D$, including the components of $x$ outside $\mathcal W_n$.

**Opposite reading.** The annotations on lines 269 to 283 (not quoted) may carry the GAP grade, and the heading may be a label rather than an assertion. Even so, the title is what a citing reader sees, and it states C1 without restriction. The finding survives as GAP.

**Tested against objects (Section 11):** C1 holds at every global maximiser in $n=4$ and at padded $W_{\mathbb{CP}^2}$ in every $n\ge5$ for every eigenbasis, both in closed form. Neither is coordinate-diagonal, so both lie outside the restricted display C4.

## 2. C2, the facts about $M$

- $P=\sum_\alpha\lambda_\alpha Q(W)_{\alpha\alpha}$ with $(W^2)_{\alpha\alpha}=\lambda_\alpha^2$ and $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\beta\gamma}c'^2_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma$. That is $\langle\lambda,M\lambda\rangle$. CONFIRMED.
- $M$ symmetric: $c'^2$ is symmetric in its first two indices (in fact in all three). CONFIRMED.
- $\theta=\langle\lambda,M\lambda\rangle\le\lambda_{\max}(M)\lVert\lambda\rVert^2=\lambda_{\max}(M)$. Holds at every unit $W$, critical or not. CONFIRMED.
- $(M\lambda)_\alpha=\lambda_\alpha^2+\tfrac12\sum_{\beta\gamma}c'^2_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma=Q(W)_{\alpha\alpha}=\theta\lambda_\alpha$ when $Q(W)=\theta W$. Only the diagonal of $Q(W)$ is used. CONFIRMED, for every eigenbasis choice, repeated eigenvalues and $\ker W\ne0$ included.
- $\mathop{\mathrm{diag}}M=\lambda$: $M_{\alpha\alpha}=\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\alpha\gamma}\lambda_\gamma$ and $c_{\alpha\alpha\gamma}=0$ by antisymmetry. The record states it without the line, and the line is immediate. CONFIRMED.

Candidate withdrawn under this claim: W1 (Section 10).

## 3. C3, the step from L24 to $\mathcal D$

**The algebra of the step.** For $x=\sum x_\alpha v_\alpha\otimes v_\alpha\in\mathcal D$, the diagonal of $e\circ x=\tfrac1{2\theta}(Wx+xW)+\tfrac1\theta W\#x$ is $\tfrac1\theta\big(\lambda_\alpha x_\alpha+\tfrac12\sum_{\beta\gamma}c'^2_{\alpha\beta\gamma}\lambda_\beta x_\gamma\big)=\tfrac1\theta(Mx)_\alpha$. So $\pi_{\mathcal D}L_e\vert_{\mathcal D}=M/\theta$, $e\in\mathcal D$, and $L_ee=Q(e)=e$. Hence $\lambda_{\max}(M)=\theta$ is exactly $\lambda_{\max}(\pi_{\mathcal D}L_e\vert_{\mathcal D})=1$, as the record says.

**Why L24 does not reach it.** L24 bounds $\langle z,L_ez\rangle\le\tfrac12\lVert z\rVert^2$ for $z\in\mathcal W_n\cap W^\perp$ only. Combined with $L_ee=e$ and self-adjointness it gives $\langle x,L_ex\rangle\le\lVert x\rVert^2$ on $\mathcal W_n$. An $x\in\mathcal D$ has a component off $\mathcal W_n$ in general: $\mathrm{Id}\in\mathcal D$ is not trace-free, and in an eigenframe of non-decomposable 2-forms the diagonal operators fail Bianchi. L24 says nothing about that component. The record's GAP grade on this step is CONFIRMED.

**What $\mathcal D\cap\mathcal W_n$ is.** It contains $W$. For a general eigenframe nothing more is on file. For a coordinate-diagonal $W$ in its coordinate frame, every diagonal operator satisfies Bianchi (a term $R_{ijkl}$ with $i,j,k$ distinct needs $\{k,l\}=\{i,j\}$), the map $h\mapsto h\wedge\mathrm{id}$, $(h\wedge\mathrm{id})_{ij}=h_i+h_j$, is injective for $n\ge3$, and $\mathcal D\cap\mathcal W_n$ is the Ricci-free diagonal operators, of dimension $n(n-3)/2$.

## 4. C4, the restricted display

**Located.** Line 290: "$\lambda_{\max}(M)=\theta$ at every COORDINATE-DIAGONAL global maximiser, and at every $S^m\times S^m$, $m\ge4$." It follows "So" at the end of line 286, whose content is that the unrestricted step fails. A failure of the general step does not yield the restricted claim, and no argument for it appears in the quoted passages.

**Exhibited gaps, each closed form.**
1. The $S^m\times S^m$ clause is not a restriction of the heading. $\theta_0(8)=\sqrt{84}/8<\sqrt{3/2}$ and $\theta_0(10)=6/5<\sqrt{3/2}$, so $S^4\times S^4$ and $S^5\times S^5$ are not global maximisers, and at $m\ge6$ their maximality is Conjecture A itself. The clause needs its own argument, and if that argument is L24 it needs $S^m\times S^m$ to be a local maximiser, which is not on file in the quoted passages.
2. The threshold $m\ge4$ is not where the statement fails. At $m=2$ ($n=4$): $\Lambda^\pm$ are ideals, so $M=M^+\oplus M^-$, and on $\Lambda^+$ with eigenvalues $(a,b,c)$ one has $M^+=\begin{pmatrix}a&c&b\\c&b&a\\b&a&c\end{pmatrix}$. Its spectrum is $\{0,\pm\sqrt{3/2}\,\lVert W^+\rVert\}$ (trace $0$, eigenvector $(1,1,1)$ with eigenvalue $a+b+c=0$, and Frobenius norm squared $3\sum a^2$). At $S^2\times S^2$, $\lVert W^\pm\rVert=1/\sqrt2$, so $\lambda_{\max}(M)=\sqrt3/2=\theta$. Yet $S^2\times S^2$ is not a local maximiser: on the unit curve $\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W_{\overline{\mathbb{CP}}^2}$, $P=\sqrt{3/2}(\cos^3\varphi+\sin^3\varphi)$, whose second derivative at $\varphi=\pi/4$ is $\sqrt{3/2}\cdot6(1/\sqrt2)^3>0$. So at $m=2$ the equality holds where L24 is unavailable. $m=3$ was not examined in closed form.
3. "Global" has no visible use. L24 needs only a local maximiser.

**What would have to be proved** for the coordinate-diagonal clause, in the coordinate frame: (i) $\mathcal D=(\mathcal D\cap\mathcal W_n)\oplus\{h\wedge\mathrm{id}\}$, (ii) the cross term $\langle x_W,L_e(h\wedge\mathrm{id})\rangle$ vanishes, (iii) the compression of $M$ to $\{h\wedge\mathrm{id}\}$ is at most $\theta$, (iv) L24 on $\mathcal D\cap\mathcal W_n$.

**Opposite reading.** The argument may sit in the unquoted annotations. The Lean name c5_exceeds_nonWeyl_cap, comparing $1/\sqrt2$ with $0.809017$, points to a non-Weyl cap of $1/\sqrt2$ somewhere on the record. Following the four items' own algebra as a test (not as a proof on file): (i) is Section 3's last paragraph. (ii) reduces to $\mathop{\mathrm{Ric}}(z)=0$ for $z_{ij}=\lambda_{ij}x_{ij}+\tfrac12\sum_k(\lambda_{ik}x_{jk}+x_{ik}\lambda_{jk})$, which holds because $\sum_{j\notin\{i,k\}}x_{jk}=-x_{ik}$ for Ricci-free $x$. (iii) $y^{\mathsf T}My=(n-2)\sum_{i<j}\lambda_{ij}h_ih_j\le\tfrac{n-2}{2}\sqrt2\,\lVert h\rVert^2\le\tfrac1{\sqrt2}\lVert y\rVert^2$ for $y=h\wedge\mathrm{id}$, using $\lVert y\rVert^2=(n-2)\lVert h\rVert^2+(\sum h)^2$ and $\lVert\Lambda\rVert_{\mathrm{op}}\le\lVert\Lambda\rVert_F=\sqrt2$. So the coordinate-diagonal clause holds at every coordinate-diagonal local maximiser with $\theta\ge1/\sqrt2$, which a global maximiser satisfies. For that clause the gap is therefore recordal: the mathematics closes in a few lines. The $S^m\times S^m$ clause still needs local maximality at $m=4,5$ and beyond. GAP retained.

## 5. C5, the cap that would close it

**Located.** Line 292: "what would close it is a cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$".

**The algebra.** Write $x\in\mathcal D$ as $x_W+y$, $x_W\in\mathcal W_n$, $y\in\mathcal W_n^\perp$ (orthogonal complement inside symmetric operators on $\Lambda^2$). If $L_e$ preserves $\mathcal W_n$, self-adjointness gives $L_e\mathcal W_n^\perp\subseteq\mathcal W_n^\perp$, the cross term vanishes, and $\langle x,L_ex\rangle\le\lVert x_W\rVert^2+\lambda_{\max}(L_e\vert_{\mathcal W_n^\perp})\lVert y\rVert^2$. So the cap $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})\le\theta$ (equivalently $\le1$ for $L_e=L_W/\theta$) suffices, with equality in C1 from $e\in\mathcal D$.

**Findings.** (a) The record names no level. The level that works is $\theta$, and the change of operator from $L_e$ to $L_W$ changes the level by the factor $\theta$. (b) The sufficiency uses $L_e\mathcal W_n\subseteq\mathcal W_n$, which is not stated in the quoted passages. In $n=4$ it holds in closed form ($Q(W)$ is block diagonal with trace-free blocks, trace of the $\Lambda^+$ block $=(a+b+c)^2=0$). (c) A weaker cap suffices: only the compression to $\pi_{\mathcal W_n^\perp}\mathcal D$ is needed. CONFIRMED AS ALGEBRA, with (a) and (b) supplied.

## 6. C6, "strictly stronger than Conjecture A"

**Located.** Line 294: "$\sup_W\lambda_{\max}(M)\le\theta_0$ ... is strictly stronger than Conjecture A: the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$."

**Exhibited failure, the argument.** "Stronger" holds: $M(n)=\theta(W^*)\le\lambda_{\max}(M(W^*))\le\sup$ by C2. "Strictly" needs a $W$ with $\lambda_{\max}(M(W))>\theta_0(n)$ in a dimension where Conjecture A holds. The $C_5$ point is no such $W$: $\theta_0(n)^2=2(1-3/n+2/n^2)$ increases in $n$, so $\theta_0(n)\ge\theta_0(4)=\sqrt3/2>0.809017$ for every $n\ge4$, using the record's own decimal. A ratio above $1$ at a point where $\lambda_{\max}(M)$ is still below $\theta_0$ shows slack in the Rayleigh bound, not a gap in logical strength.

**Exhibited failure, the range.** For $4\le n\le11$, padded $W_{\mathbb{CP}^2}$ gives $\sup\lambda_{\max}(M)\ge\sqrt{3/2}>\theta_0(n)$, since $\theta_0^2<3/2$ iff $n^2-12n+8<0$ iff $6-2\sqrt7<n<6+2\sqrt7$. So the target as written is false at $n\le11$. The crossover $6+2\sqrt7$ is not an integer, so no dimension ties. At odd $n$ no balanced sphere product exists, and nothing on file shows $\theta_0(n)$ is attained.

**Opposite reading.** "Strictly stronger" may mean only that the sup route is lossy as a method, and B3's target may carry $n\ge12$ implicitly. The method reading does not support the word "strictly", and Passage B's own conditional ("if the supremum is $\max(\sqrt{3/2},\theta_0(n))$") would make the two targets true together. GAP retained: strictness has no witness, and the sentence needs the range $n\ge12$.

## 7. C7, "Conjecture A rewritten, neither easier nor harder"

Read "the pointwise statement at maximisers" as $\lambda_{\max}(M(W^*))\le\theta_0(n)$ at every global maximiser $W^*$ (the reading under which it can be compared with Conjecture A at all).

- Pointwise implies Conjecture A: $M(n)=\theta\le\lambda_{\max}(M)\le\theta_0$. CONFIRMED.
- Conjecture A implies pointwise: needs $\lambda_{\max}(M(W^*))=\theta$, which is C1, graded not citable by the record itself.

**Opposite reading.** If "the pointwise statement" means C1 itself, it mentions no $\theta_0$ and cannot be Conjecture A rewritten (it holds in closed form at $n=4$, Section 11). Either way the equivalence is conditional on C1. GAP.

## 8. C8, the by-product

**Written route.** $\lambda_\alpha=M_{\alpha\alpha}\le\lambda_{\max}(M)=\theta$. The first equality is C2. The second uses C1 in the direction $\lambda_{\max}(M)\le\theta$, which is the GAP direction. As written, the route rests on an uncitable step.

**Route using only $\lVert\lambda\rVert=1$ and $M(n)\ge\sqrt{3/2}$.** $\lambda_\alpha\le\lvert\lambda_\alpha\rvert\le\lVert\lambda\rVert=1<\sqrt{3/2}\le M(n)=\theta$. It is strict, with $\theta-\lambda_\alpha\ge\sqrt{3/2}-1$, holds in every $n\ge4$, odd or even, with $\ker W\ne0$ and repeated eigenvalues. It needs global maximality (or any critical point with $\theta\ge1$). CONFIRMED, by the second route. The claim is also weak: it is implied by the norm alone once $\theta\ge1$.

## 9. C9 and C10

**C9.** The $C_5$ values $0.809017$ and $0.670820$, "six digits across the catalogue", and the suprema $\sqrt{3/2}$ at $n=6,8,10$ "by full-gradient ascent" are supported only by runs. HYPOTHESIS-DEBT. The conditional display "if the supremum is $\max(\sqrt{3/2},\theta_0(n))$ then $M(n)\le\theta_0(n)$ for $n\ge12$" is CONFIRMED AS ALGEBRA by C2.

**C10, declaration by declaration.**
- lambda2_six, ambient_dim, weyl_six: natural-number identities $15=\dim\Lambda^2\mathbb R^6$, $120=\dim S^2(\Lambda^2\mathbb R^6)$, $84=\dim\mathcal W_6$ (from $n(n+1)(n+2)(n-3)/12$, exact in $\mathbb N$). True, and no quoted claim uses them.
- intersection_share_ambient, intersection_share_weyl, share_bracket: $1/120<1/100<1/84<12/1000$ in $\mathbb Q$. True. No quoted passage names an object with share $1/100$, so these match no claim in A or B.
- cap_on_subspace_transfers_nothing: there exist $f$ and $c$ bounded on the line $\{(t,0)\}$ and unbounded overall, witnessed by $f(p)=p_2$. True and existential: it shows a cap can fail to transfer, says nothing about $L_e$, $\mathcal D$ or $\mathcal W_n$, and is linear rather than a quadratic form.
- true_claim_bad_argument: from $C$ and $\lnot H$, $(H\to C)\wedge C$. A propositional tautology.
- IsTopRayleigh A t: $x^{\mathsf T}Ax\le t\,x^{\mathsf T}x$ for all $x$. This is $\lambda_{\max}(A)\le t$ for symmetric $A$ (for general $A$, of its symmetric part). It is an upper bound, not $\lambda_{\max}=t$. No symmetry hypothesis, harmless where used.
- diag_is_rayleigh, theta_ge_diag: $A_{\alpha\alpha}=\lambda_\alpha$ and $\lambda_{\max}(A)\le\theta$ give $\lambda_\alpha\le\theta$. This is C8's written route with both of its inputs, $\mathop{\mathrm{diag}}M=\lambda$ and the GAP direction of C1, taken as hypotheses. $M$ is never defined.
- le_norm_of_sum_sq, one_lt_sqrt_three_halves, margin, theta_gt_lambda, theta_sub_lambda_ge: C8's second route, $\lambda_\alpha<\theta$ and $\theta-\lambda_\alpha\ge0.2247$, with $\sqrt{3/2}\le\theta$ as a hypothesis. $1.2247^2=1.49989\ldots\le3/2$, true. The link $\theta=M(n)\ge\sqrt{3/2}$ is not formalised.
- c5_exceeds_nonWeyl_cap: $1/\sqrt2<0.809017$, true ($0.809017\cdot1.4142>1$). The right side is a run value typed as a literal, and the cap $1/\sqrt2$ is not stated in A or B.
- witLam, wit_norm, the example: the hypotheses of theta_gt_lambda are satisfiable in Fin 2. $N=2$ is no $\dim\Lambda^2\mathbb R^n$, so it is a nonvacuity check of the abstract lemma only.

**Summary.** Every declaration is true as typed. The clause-1 equality is not typed anywhere, no declaration mentions Weyl tensors, $P$, $M$ or a maximiser, and the by-product is formalised only with its links to the objects as hypotheses. CONFIRMED AS ALGEBRA.

## 10. Withdrawn candidates

- **W1, "$Q(W)=\theta W$ cannot hold literally since $Q(W)$ has a scalar part."** Fails step 2: in Hamilton's normalisation the trace of $Q(W)$ on $\Lambda^+$ in $n=4$ is $\sum a^2+2\sum ab=(a+b+c)^2=0$, and $Q(W)$ is block diagonal, hence Weyl. No closed-form failure exists at $n=4$, and the brief gives $Q(W)=\theta W$ as the critical-point equation.
- **W2, "$\lambda_{\max}(M)$ depends on the eigenbasis at repeated eigenvalues, so C1 is ill-posed."** $M$'s entries do depend on the choice (an entrywise square is not tensorial), but no object was exhibited where $\lambda_{\max}(M)$ changes. At padded $W_{\mathbb{CP}^2}$ it provably does not (below). Fails step 2. Kept as a note: C1 and C4 should say "for every orthonormal eigenbasis", and C4's argument sketched in Section 4 works only in the coordinate frame.
- **W3, "the by-product fails once C1 is removed."** Fails step 3: the norm route of Section 8 gives it strictly.
- **W4, "the $S^m\times S^m$ clause is false for $m\le3$."** Fails step 2 at $m=2$: equality holds (Section 4). $m=3$ not examined.

## 11. The falsifying object and the search for it

C1 is falsified by a global maximiser $W^*$ and a unit $x\in\mathbb R^N$ with $x^{\mathsf T}M(W^*)x>\theta$. By Sections 3 and 5 such an $x$ must have a component off $\mathcal W_n$ that $L_e$ amplifies past $1$, and by Section 4 $W^*$ cannot be coordinate-diagonal. Objects checked, all in closed form:

- **$n=4$, every global maximiser.** $P=P^++P^-\le\sqrt{3/2}(\lVert W^+\rVert^3+\lVert W^-\rVert^3)\le\sqrt{3/2}$, with equality iff one block vanishes and the other is $t(2,-1,-1)$, $t>0$. So the maximisers are $W_{\mathbb{CP}^2}$ and its reverse. $\lambda_{\max}(M)=\sqrt{3/2}\lVert W^+\rVert=\sqrt{3/2}=\theta$. C1 holds. $W_{\mathbb{CP}^2}$ is not coordinate-diagonal in any frame: its $2t$-eigenspace is spanned by $\omega$, which is not decomposable, so no $e_i\wedge e_j$ lies in it.
- **Padded $W_{\mathbb{CP}^2}$, every $n\ge5$, every eigenbasis ($\ker W\ne0$, repeated eigenvalues).** Eigenspaces are $\mathbb R\omega_1$ ($2t$), $\mathop{\mathrm{span}}(\omega_2,\omega_3)$ ($-t$) and the kernel $K$, with $t=1/\sqrt6$. Since $[\Lambda^+,\Lambda^+]\subseteq\Lambda^+\perp K$, $M=M^+\oplus M_K$ with $\lambda_{\max}(M^+)=3t=\sqrt{3/2}$ (the $n=4$ block, invariant under rotations inside the eigenspaces because $c=\sqrt2\,\varepsilon$ there). $M_K=\tfrac12\sum_{\gamma}\lambda_\gamma A_\gamma\circ A_\gamma$ with $A_\gamma$ the compression of $\mathop{\mathrm{ad}}_\gamma$ to $K$, of operator norm at most $1/\sqrt2$ ($\mathop{\mathrm{ad}}_\gamma$ acts on each $\mathop{\mathrm{span}}\{e_i\wedge e_a\}$, $a\ge5$, as $\gamma$ itself and kills the rest of $K$). By Schur's inequality $\lVert A\circ A\rVert\le\lVert A\rVert^2$, $\lVert M_K\rVert\le\tfrac12(2t+t+t)\tfrac12=t$. So $\lambda_{\max}(M)=3t=\theta$. C1 holds, not only in the coordinate-diagonal cases.
- **$S^2\times S^2$ (critical, not a local maximiser).** $\lambda_{\max}(M)=\theta$ (Section 4).
- **Diagonal and sphere-product objects** fall under the coordinate-diagonal computation of Section 4 and cannot falsify at $\theta\ge1/\sqrt2$ once L24 applies.
- **$\mathbb{CP}^m$, $m\ge3$, and non-coordinate-diagonal objects in $n\ge5$ other than padded $W_{\mathbb{CP}^2}$** were not examined. They are not on file as maximisers.

No falsifier found.

## 12. Overall verdict

**GAP.** The numbered heading states the unrestricted equality, which its own body calls not citable, and no argument for it is on file. The restricted display has no argument in the quoted text, and its $S^m\times S^m$ clause needs local maximality not on file (although Section 4 shows the coordinate-diagonal clause closes in a few lines). "Strictly stronger" has no witness, and the equivalence with Conjecture A is conditional on C1. What is proven, and what the lemma should be retitled to: C2, and $\theta-\max_\alpha\lambda_\alpha\ge\sqrt{3/2}-1$ at every global maximiser in every $n\ge4$.
