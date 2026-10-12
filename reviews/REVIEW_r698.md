# Reviewer r698, the five claims of [DERIVE-j5.md](DERIVE-j5.md)'s Batch 1, attacked from the definitions

*Analysis only, per [the standing rule](../.claude/rules/analysis-only.md). **No computation of any kind was run for this report**, every number below is derived by hand, and the two places where a number was wanted are cross-checked against values the record already prints. The sphere-product derivation in §1 reproduces [ATTEMPTS.md](../ATTEMPTS.md)'s own critical-value catalogue ($1.236033$ and $1.141798$ at $n=12$) from a closed form built here, which is the validation that licenses the rest.*

| claim | verdict |
| --- | --- |
| **C1**, the two block forms are different operators, the record's vanishing at $S^p\times S^q$ | **CONFIRMED**, with a hand proof, and **strengthened**: the wrong-sign variant is exactly $4\,W_+\#W_-\succeq0$ at every critical point |
| **C2**, $H=\mathrm{Ric}^*(h)$ is diagonal in $\{e_i\wedge e_j\}$ with eigenvalues $2(\eta_i+\eta_j)$ | **SPLIT**: diagonality **CONFIRMED** and robust; the constant **REFUTED**, adjointness forces $\eta_i+\eta_j$, and the record's own Theorem A/B block says $c_k+c_l$ |
| **C3**, $J_5$ sees only the $h$-frame diagonal, so $H_{\mathrm{cross}}$ is an artefact of the splitting | **REFUTED**: the displayed chain returns $J_5=2J_5$; "no off-diagonal information in any frame" is false; $H_{\mathrm{cross}}=0$ across all blocks **is** the frame-free condition $[H,W]=0$ |
| **C4**, the positivity ladder down to $J_5\ge0$ | **CONFIRMED** as mathematics, **inert** as a contribution: its third rung is refuted at [ATTEMPTS.md](../ATTEMPTS.md) line 932, which closes the ladder in those words |
| **C5**, the four-term identity, remainder $=Q(W)-\theta W$ rather than the $P_0$ cross blocks | **identity CONFIRMED** for the closed-form $X_{\mathrm{inv}}$; the **"in particular" REFUTED**: the record defines a critical point by $Q(W)=\theta W$, so the residual is **zero at every critical point**, and both named remainders are the same vanishing object |

---

## 1. C1, CONFIRMED, and the sign error is worse than "a different operator"

### The two forms differ by an operator that is computable in closed form

Write $W_\pm$ for the positive-semidefinite spectral parts, $|W|=W_++W_-$, $W=W_+-W_-$. At a critical point $Q(W)=\theta W$ gives $W^\#=\theta W-W^2$, so $W^\#$ is a **function of $W$**: it acts on the $\lambda$-eigenspace of $W$ by the scalar $\theta\lambda-\lambda^2$. Hence

$$P_+W^\#P_+=\theta W_+-W_+^2,\qquad P_-W^\#P_-=-\theta W_--W_-^2,$$

and the two candidate operators are

$$\text{record: }|W|^\#+W|W|-\theta|W|,\qquad\text{variant: }|W|^\#+W^2-\theta W,\qquad\text{difference}=-2W_-^2-2\theta W_-.$$

They agree only where $W_-(W_-+\theta)=0$. So the claim that they are different operators is right, and it is right off the sphere products too.

### $X_{\mathrm{inv}}=0$ at every $S^p\times S^q$, proven here by hand

On the diagonal locus a Weyl operator is diagonal in the coordinate bivectors with entries $W_{ij}$, and $(A\#B)_{ij}=\tfrac12\sum_{k\ne i,j}(A_{ik}B_{jk}+A_{jk}B_{ik})$; the normalisation is pinned by $I\#I=(n-2)I$ and by $W\#I=-W$ on Ricci-flat $W$. For the product of round spheres, subtracting the Ricci and scalar parts gives, with $\kappa=\tfrac2{(n-1)(n-2)}$,

$$a:=W_{ij}\big|_{i,j\in p}=\kappa\,q(q-1),\qquad b:=W_{ij}\big|_{i,j\in q}=\kappa\,p(p-1),\qquad c:=W_{ij}\big|_{\text{mixed}}=-\kappa\,(p-1)(q-1).$$

Ricci-flatness $(p-1)a+qc=0$ holds identically. Three lines of arithmetic then give, on each of the three plane types,

$$Q(W)=\theta W\quad\text{exactly, as an operator, with }\theta=\frac{2(p-1)(q-1)}{n-2},$$

and the same three lines applied to $|W|^\#+(W-\theta)|W|$ return **zero on every plane type**. So $X_{\mathrm{inv}}=0$ identically at every sphere product, $p,q\ge2$.

**The validation that makes this citable.** At $n=12$, $p=q=6$ the closed form gives $\lVert W\rVert^2=1980/121$ and $\theta/\lVert W\rVert=1.236033$; at $p=3$, $q=9$ it gives $3.2/\sqrt{23760/3025}=1.141798$. Both are [ATTEMPTS.md](../ATTEMPTS.md)'s catalogued critical values to every printed digit, from a derivation that used none of the record's machinery. *It also pins the pairing: the match holds under plain $\operatorname{tr}_{\Lambda^2}$ with $\{e_i\wedge e_j\}_{i<j}$ orthonormal, and fails by $\sqrt2$ under an operator-level half-trace, [conventions.md](../findings/conventions.md)'s named trap, here confirmed on the record's own numbers.*

The variant is then $2W_-(W_-+\theta)$, whose mixed-plane entries are $2\lvert c\rvert(\lvert c\rvert+\theta)>0$. Nonzero, as claimed.

### What C1 understates, and it matters for the hunt

At **every** critical point, not just the sphere products, $W^\#$ is block-diagonal with $P_0W^\#P_0=0$, so $P_+W^\#P_++P_-W^\#P_-=W^\#$ and

$$\boxed{\ |W|^\#-P_+W^\#P_+-P_-W^\#P_-\;=\;|W|^\#-W^\#\;=\;4\,W_+\#W_-\;\succeq\;0.\ }$$

**The wrong-sign form is the PSD half of $X_{\mathrm{inv}}$.** A hunt started from it would not merely have hunted a different operator, it would have had $\mathrm{Ric}$ of a positive-semidefinite operator, hence $J_5\ge0$ by C4's own ladder, and would have reported the grant proved in a page. That is the real cost of the sign, and [DERIVE-j5.md](DERIVE-j5.md) should say so where it records the correction.

---

## 2. C2, the diagonality is right; the factor $2$ is not derivable from the stated definitions

### Diagonality: CONFIRMED, and it survives both presses

$\mathrm{Ric}^*(h)$ is a multiple of the derivation $D_h(x\wedge y)=hx\wedge y+x\wedge hy$, whose eigenvector on $e_i\wedge e_j$ is immediate. Equivalently, in the Kulkarni–Nomizu expansion the two "crossed" terms carry $\delta_{il}\delta_{jk}$, which for $i<j$ and $k<l$ would force $i=l>k=j>i$. Both presses fail against it:

- **Degenerate $\eta$.** The conclusion holds for **every** orthonormal eigenframe of $h$, so the non-uniqueness of the frame costs nothing. What is not unique is the *labelling*, and no statement below depends on it.
- **Mixed signs.** The derivation is sign-blind. It also yields a sharper positivity statement than the record uses: $H\succeq0$ **iff the two smallest eigenvalues of $h$ sum to $\ge0$**, which is strictly weaker than $h\succeq0$, and $\lambda_{\min}(H)=\eta_{(1)}+\eta_{(2)}$ in closed form. *That closed form is exactly the input [r410](REVIEW_r410.md)'s surviving shift-by-$\lambda_{\min}(H)$ repair needs, and the batch left it on the table.*

### The constant: REFUTED

Let the pairings be $\langle h,g\rangle=\sigma\operatorname{tr}(hg)$ on $S^2\mathbb R^n$ and $\langle X,Y\rangle=\tau\operatorname{tr}_{\Lambda^2}(XY)$ on operators. With $\mathrm{Ric}(A)_{ik}=\sum_jA_{ijkj}$ as the brief defines it, and $A_{ij,ij}=A_{ji,ji}$,

$$\langle\mathrm{Ric}(A),h\rangle=\sigma\sum_{i\ne j}\eta_i A_{ij,ij}=\sigma\sum_{i<j}(\eta_i+\eta_j)A_{ij,ij}\quad\Longrightarrow\quad \mathrm{Ric}^*(h)\ \text{has eigenvalue}\ \tfrac\sigma\tau(\eta_i+\eta_j).$$

§1 pins $\tau=1$ against the record's own $\theta$ catalogue. So C2's constant needs $\sigma=2$ (the $n\times n$ pairing at **twice** Frobenius) which nothing in [conventions.md](../findings/conventions.md) licenses and which would halve the record's printed $J_5=2.73$ at $SU(3)$.

**And the record contradicts it directly.** [ATTEMPTS.md](../ATTEMPTS.md)'s Theorem B computes the same operator on an isotypic sector: *"$H=h\wedge2\,\mathrm{id}$ then acts as $(c_k+c_l)\,\mathrm{Id}$ on each sector $V_k\wedge V_l$"*, coefficient one, not two. The batch's own derivation is where the doubling entered: the four-term expansion it displays already returns $(\eta_i+\eta_j)$ for $h\owedge\mathrm{id}$, and multiplying by the $2$ of $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$ counts it twice unless $\wedge$ is the half-Kulkarni–Nomizu. **The record's $\wedge$ is the half one**, which is precisely what makes [Lemma L131](../findings/isotropy-cap.md)'s $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$ and Theorem B's $(c_k+c_l)$ consistent with each other.

### And the novelty claim is overstated

Theorem B already carries this computation, for isotropy-invariant $h$. Dropping isotropy from it is one line, because the isotropy was never used in that step, which is worth recording as *"Theorem B's $H$-computation needs no isotropy"* rather than as a new fact.

---

## 3. C3, REFUTED, on three independent grounds

### (a) The displayed chain is internally inconsistent by a factor $2$, with no convention needed

C3 asserts

$$J_5=2\sum_{i<j}(\eta_i+\eta_j)\,X_{ij,ij}=2\sum_i\eta_i\,\mathrm{Ric}(X_{\mathrm{inv}})_{ii}.$$

The second equality is C4's identity, which is stated with coefficient one. But $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),h\rangle=\sum_i\eta_i\mathrm{Ric}(X_{\mathrm{inv}})_{ii}$ by definition. **So the chain says $J_5=2J_5$, hence $J_5=0$**, a reductio that needs no normalisation argument at all. C2 and C4 cannot both stand as written; §2 says which one gives way.

### (b) "No off-diagonal information about $X_{\mathrm{inv}}$ enters in any frame" is false

The true statement is *"$J_5$ depends on $X_{\mathrm{inv}}$ only through its diagonal in the $h$-eigenframe"*, and the "in any frame" extension is a different sentence that fails. Take $f_1,f_2$ two $h$-frame bivectors with $H$-eigenvalues $h_1\ne h_2$, and the rotated pair $u_{1,2}=(f_1\pm f_2)/\sqrt2$. The operator $X=u_1u_2^{\mathsf T}+u_2u_1^{\mathsf T}=f_1f_1^{\mathsf T}-f_2f_2^{\mathsf T}$ has **zero diagonal in the $u$-frame** and pairs to $h_1-h_2\ne0$. So in the $u$-frame the entire contribution is carried off the diagonal. The information is *relocated* by C2, never removed.

### (c) The statement that survives is a property of every pairing whatsoever

For any symmetric $H$ with eigenbasis $\{f_\alpha\}$ and any symmetric $X$, $\langle X,H\rangle=\sum_\alpha h_\alpha\langle Xf_\alpha,f_\alpha\rangle$. **"The pairing sees only the diagonal in the other operator's eigenframe" is true of $\langle\cdot,\cdot\rangle$ and carries no information about $J_5$.** All of C3's content is C2's identification of *which* frame that is, and that is useful only alongside a description of $X_{\mathrm{inv}}$ in the same frame, which is exactly what the grant lacks. The grant's difficulty is the **mismatch of two frames**, and naming one of them does not close it.

### (d) The conclusion about $H_{\mathrm{cross}}$ is refuted

$P_bHP_c=0$ for all $b\ne c$ in $\{+,-,0\}$ **iff $H$ commutes with $P_\pm,P_0$, iff $[H,W]=0$**, a frame-free condition on the pair $(W,h)$, not a property of a chosen splitting. The record already names it and already uses it: Theorem B is *"if $[H,W]=0$ then $H_{\mathrm{cross}}=0$"*, and Result 5(c) is the same statement. The splitting by $W$'s spectral projections is not arbitrary either: it is the one in which $X_{\mathrm{inv}}$'s three PSD diagonal blocks live. **So $H_{\mathrm{cross}}\ne0$ is a genuine fact about the point, and C3 does not license dropping it.**

### (e) One further correction, on the degenerate case the brief asked about

The batch glosses Theorem B as *"$[H,W]=0$ says exactly that $W$ is diagonal in the $h$-frame too"*. That holds only when the multiset $\{\eta_i+\eta_j\}$ is **simple**. Repeats are the rule rather than the exception: any repeated eigenvalue of $h$ produces them, $\eta_1+\eta_4=\eta_2+\eta_3$ produces them from distinct $\eta$'s, and at every isotropic point $h$ is block-scalar. In the extreme case $h$ scalar, $H$ is scalar, $[H,W]=0$ holds for **every** $W$, and no diagonality follows, which is exactly the case [post F54](../findings/second-order.md) singles out as *"$H$ scalar, where $H_{bc}=0$ and the cross term vanishes exactly"*. **So "exactly" should read "whenever $\{\eta_i+\eta_j\}$ is simple".**

---

## 4. C4, the mathematics is right; the ladder is the one the record already closed

### What is true, and it is convention-proof

$\langle\mathrm{Ric}(A)x,x\rangle=\sum_j\langle A(x\wedge e_j),x\wedge e_j\rangle$ holds with coefficient one when $x\wedge e_j$ is unit-normalised, which is [conventions.md](../findings/conventions.md)'s choice ($\lVert\varphi_{ab}\rVert^2=1$); under the plain-Frobenius bivector normalisation it carries a $\tfrac12$. **The sign is convention-free in either case**, so every implication in the ladder stands: $A\succeq0\Rightarrow\sec(A)\ge0\Rightarrow\mathrm{Ric}(A)\succeq0$, and $\mathrm{Ric}(X)\succeq0$ with $h\succeq0$ gives $J_5=\operatorname{tr}(\mathrm{Ric}(X)h)\ge0$.

### The rung the record refutes, and the refutation is sound as far as it goes

[ATTEMPTS.md](../ATTEMPTS.md) line 932 refutes the **third** rung: *"$\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$ … is false: at a genuine $n=5$ critical point ($\theta=0.882135$, residual $2\times10^{-8}$) its minimum eigenvalue is $-0.0273$"*, with two congruence intermediates failing at the same point. By contraposition the second rung falls with it, and the first is separately refuted at $n=6$, $\theta=0.6611$. The refutation is **structurally sound**, a single negative eigenvalue of a computed matrix at a point polished to residual $2\times10^{-8}$ is the right shape of evidence, and the margin $-0.0273$ is four orders above the residual. Its recorded weakness is provenance, not logic: *"single-run agent result, unreviewed; the review is owed and deferred."*

### So the ladder adds nothing, and the same line says so

That same paragraph concludes *"the entire ladder between the scalar target and operator positivity is closed off, and the scalar statements are exactly the right level."* C4 rebuilds that ladder from the definitions and stops one step before reading its own status off the record. **Verdict: correct, and inert.**

**Two collateral corrections to the batch's use of it.**

- *"Read at $A=W_-$ and $A=h$ this reproves $g\succeq0$ and $H\succeq0$."* The first half is right and is a genuinely shorter proof of $g=\mathrm{Ric}(W_-)\succeq0$ than the record's. The second half is a **type error**: $h$ is a symmetric $n\times n$ matrix, not an operator on $\Lambda^2$, and $H=\mathrm{Ric}^*(h)$ is reached by the *adjoint*. What proves $H\succeq0$ is C2, not the ladder. *Reading $A=|W|$ instead gives $h\succeq0$, which is the statement the ladder actually supplies at that slot.*
- *"The middle two rungs are on the record as refuted at one $n=5$ critical point."* Accurate for $n=5$; the record additionally refutes the **top** rung at a separate $n=6$ point.

---

## 5. C5, the identity is right, the operator it is about is not the one C1 defines, and the "in particular" is refuted

### The identity itself: CONFIRMED for the closed form

For every symmetric $W$ and every scalar $\theta$, from $|W|^\#=W^\#+4W_+\#W_-$, $W|W|=W_+^2-W_-^2$ and $W^2=W_+^2+W_-^2$:

$$|W|^\#+(W-\theta)|W|\;=\;4W_+\#W_-\;-\;2\theta W_-\;-\;2W_-^2\;+\;\big(Q(W)-\theta W\big).$$

Both sides expand to $4W_+\#W_-+W^\#+W_+^2-W_-^2-\theta W_+-\theta W_-$. **$P_0$ plays no role**, so the algebra is complete and drops nothing when the kernel is nontrivial. No Bianchi, no Ricci-flatness, no criticality.

### But C5 and C1 name different operators

C1 defines $X_{\mathrm{inv}}$ by the **block form**; C5's identity is about the **closed form**. Writing $N:=Q(W)-\theta W$, the two differ by

$$\underbrace{|W|^\#-P_+W^\#P_++P_-W^\#P_-}_{\text{block, C1}}\;-\;\underbrace{\big(|W|^\#+(W-\theta)|W|\big)}_{\text{closed, C5}}\;=\;P_-NP_--P_+NP_+ ,$$

which is generically nonzero off the critical set. **So C5's "for every symmetric $W$ … no criticality" is true of the closed form and false of the operator C1 calls "the record's $X_{\mathrm{inv}}$"**, and the batch's own screen says exactly this when it reports that *"both $P$-block readings fail off the critical set by $O(1)$"*. The two claims should not stand in one file under one symbol without that sentence.

### The "in particular" is refuted, and the open question it opens does not exist

[conventions.md](../findings/conventions.md) fixes the record's definition: ***"Critical point" is $Q(W)=\theta W$***, the operator identity, available because $Q$ maps $\mathcal W_n$ into itself, so the Lagrange condition needs no projection. **Therefore $N=0$ at every critical point.** The consequences run against C5 at every point it makes:

- **The two "remainders" are not rivals; they are the same vanishing object.** Granting the recorded compressions, and using that $\theta W$ and $W^2$ commute with $W$'s spectral projections,
  $$N=P_+NP_++P_-NP_-+\big(P_\pm W^\#P_0+P_0W^\#P_\pm\big),$$
  so the record's block remainder is precisely the part of $N$ that survives when criticality holds blockwise on $P_\pm$. Under the record's definition all three summands vanish. **C5's "and not" is refuted: at a critical point both names denote zero.**
- **The compressions are not separate facts.** $W^\#=\theta W-W^2$ makes $W^\#$ a scalar on each eigenspace of $W$, which gives $P_+W^\#P_-=0$, $P_0W^\#P_0=0$ **and** $P_\pm W^\#P_0=0$ in one line. The record verifies the first two numerically "to $10^{-15}$"; they are free.
- **The record already has the conclusion, hand-proved.** [ATTEMPTS.md](../ATTEMPTS.md)'s Theorem A: *"Criticality gives $W^\#=\theta W-W^2$, so $W^\#$ commutes with $W$ and is block-diagonal, whence $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2$, $(W^\#)_{\mathrm{cross}}=0$."* Result 3's by-products carry the same three-term form with no remainder, and [r515](REVIEW_r515.md) uses it.
- **The batch's blocked item asks for a nonexistent object.** *"Deciding it needs one genuine critical point off the diagonal locus with $Q(W)-\theta W\ne0$, which is a search, and analysis-only reserves it."* No such point exists, by the definition of a critical point. **The item should be struck rather than left blocked**, and with it the worry that [post F55](../findings/second-order.md)'s $J_5=4\langle C,H\rangle-2\langle\theta W_-+W_-^2,H\rangle$ is missing a term. It is not.

### One correction the record owes in the other direction

[ATTEMPTS.md](../ATTEMPTS.md)'s **Result 4 display carries $\big(P_\pm W^\#P_0+P_0W^\#P_\pm\big)$ as though it were live**, and calls the whole *"the concrete shape a proof of $J_5\ge0$ has to handle"*. That term is identically zero at every critical point, by the same Theorem A printed fifty lines below it. The display should be the three-term form, and the sentence that follows it (*"a PSD-calculus expression plus block-off-diagonal terms"*), should say that the only cross term is $4C_{\mathrm{cross}}$, which is what Theorem A concludes. *[DERIVE-j5.md](DERIVE-j5.md) inherited the stale display verbatim, which is how the batch came to compare it against something.*

---

## What a successor should take from this

1. **The wrong-sign variant is $4W_+\#W_-\succeq0$ at every critical point.** Record it in [DERIVE-j5.md](DERIVE-j5.md) beside the sign correction: the danger was a false proof, not a wasted hunt.
2. **Drop the factor $2$ from $H$'s spectrum**, and take the two free consequences the batch missed: $\lambda_{\min}(H)=\eta_{(1)}+\eta_{(2)}$ in closed form, and $H\succeq0$ iff the two smallest eigenvalues of $h$ sum to $\ge0$, strictly weaker than $h\succeq0$, and the exact input [r410](REVIEW_r410.md)'s surviving repair wants.
3. **$H_{\mathrm{cross}}$ stays.** It vanishes across all blocks exactly when $[H,W]=0$, which the record already isolates as the commuting class; C3 does not shrink the open part of the grant by a single point.
4. **Strike the blocked item.** $Q(W)-\theta W=0$ at every critical point by definition, so no run decides anything there, and [post F55](../findings/second-order.md)'s boxed form is not missing a term.
5. **The three-term form is canonical**, and [ATTEMPTS.md](../ATTEMPTS.md)'s Result 4 display should be brought to it.
