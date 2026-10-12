# Verifier v371, whether the declarations of L115.lean state and prove a claim of Lemma L115 (step F8)

Cold brief ([ADJ_L115_F8.md](ADJ_L115_F8.md)), no numerical work, no scripts written, no Lean build run, every value exact. Log: [agent_logs/verify-L115-v371.log](../agent_logs/verify-L115-v371.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The file [L115.lean](../lean/HamiltonsCubic/Results/L115.lean) is the first block of Passage D (namespace HamiltonsCubic.OutsideItsSpace), and [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean) is the second | CONFIRMED |
| 2 | lambda2_six, ambient_dim, weyl_six and the three share inequalities state claims of Passage A | REFUTED (the arithmetic itself is CONFIRMED AS ALGEBRA) |
| 3 | cap_on_subspace_transfers_nothing states and proves the non-transfer of the Lemma L24 cap that Passage A uses | REFUTED AS STATED |
| 4 | true_claim_bad_argument states a component Passage A uses | REFUTED AS STATED |
| 5 | In the companion file, theta_ge_diag is exactly the deduction of Passage A's by-product, conditional on $\lambda_{\max}(M)\le\theta$ | CONFIRMED |
| 6 | In the companion file, theta_gt_lambda proves $\theta>\max_\alpha\lambda_\alpha$ at every global maximiser for $n\ge4$, without the GAP-graded premise | CONFIRMED |
| 7 | The step F8 as written | FAILS |

**Summary: nothing declared in L115.lean mentions $M$, $\theta$, $\lambda$, $L_e$, $\mathcal D$ or a maximiser, and its only two statements with logical content are a function-level witness outside the class Passage A reasons about and a vacuous tautology, so the step FAILS as written. It becomes VALID only if "L115.lean" is read to include L115Statement.lean, whose theta_ge_diag and theta_gt_lambda do state and prove Passage A's second clause.**

## 0. Conventions, fixed once

- $\mathcal W_n$ carries the Frobenius inner product of symmetric operators on $\Lambda^2\mathbb R^n$, so a unit $W$ with orthonormal eigenbasis $\{v_\alpha\}$ and spectrum $\lambda$ has $\sum_\alpha\lambda_\alpha^2=1$.
- $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ are the structure constants of $\mathfrak{so}(n)$ in that basis, totally antisymmetric, and $c'^2_{\alpha\beta\gamma}$ is their square, totally symmetric.
- $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$ as in Passage B.
- A global maximiser is a unit $W$ with $P(W)=M(n)$. It is a critical point of $P$ on the sphere, so $Q(W)=\theta W$ with $\theta=P(W)=M(n)$.
- For a real square matrix $A$, IsTopRayleigh $A$ $t$ means $x\cdot Ax\le t\,x\cdot x$ for all $x$. For symmetric $A$ this is exactly $\lambda_{\max}(A)\le t$.
- "State and prove a claim of Passage A, or a component of one that Passage A uses" is read as: some declaration's statement, with its hypotheses instantiated by objects of Passages A to C, is that claim or a lemma the Passage A argument invokes, and its proof is correct.

## 1. Hypothesis inventory

- **H1 (file identity).** The step's "L115.lean" names the file of that name. Checked by its namespace line alone: [L115.lean:26](../lean/HamiltonsCubic/Results/L115.lean#L26) opens HamiltonsCubic.OutsideItsSpace and [L115Statement.lean:76](../lean/HamiltonsCubic/Results/L115Statement.lean#L76) opens HamiltonsCubic.L115Statement, so the first quoted block is L115.lean.
- **H2 (compilation).** The quoted declarations elaborate as written. Not checked here, since a build is a computation. Every verdict below rests on the mathematical content of the statements and proofs, which is checked by hand, and the FAILS verdict does not depend on H2 at all.
- **H3 (companion reading).** "L115.lean" is read to include its statement file L115Statement.lean. This is the only hypothesis under which the step is VALID (section 5). The words of the step name a single file and H1 settles which one it is, so H3 substitutes a different object rather than supplying an unwritten premise.
- **H4 (instantiation for theta_ge_diag).** $A=M$, lam $=\lambda$, hdiag from $\operatorname{diag}M=\lambda$, hlam from $\lambda_{\max}(M)\le\theta$. The last is half of the GAP-graded first clause of Lemma L115.
- **H5 (instantiation for theta_gt_lambda).** hnorm from $\|W\|=1$, hθ from $\theta=M(n)\ge\sqrt{3/2}$, which the brief gives for $n\ge4$ through padded $W_{\mathbb{CP}^2}$.

## 2. The claims of Passage A

Passage A carries these mathematical claims.

- (A1) $\lambda_{\max}(M)=\theta$ at every global maximiser. Graded GAP in the unrestricted form, asserted at coordinate-diagonal global maximisers and at $S^m\times S^m$, $m\ge4$.
- (A2) $\theta\ge\max_\alpha\lambda_\alpha$ at a maximiser, derived from $\operatorname{diag}M=\lambda$ and (A1).
- (A3) Lemma L24 caps $\lambda_{\max}(L_e|_{W^\perp})$ on $\mathcal W_n\cap W^\perp$ only, and reading that cap over $\mathcal D$ is the unlicensed step. What would close (A1) is a cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$.
- (A4) $\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A, and the pointwise statement at maximisers is equivalent to it.

The components (A1) to (A4) use are: $M$ symmetric with $\operatorname{diag}M=\lambda$, the Rayleigh reading of $\lambda_{\max}$, the scope of Lemma L24's statement, and the fact that a cap on the compression of a self-adjoint operator to a subspace $U$ does not bound its compression to a larger subspace $V\supset U$.

## 3. The declarations of L115.lean, one by one

### 3.1 The dimension arithmetic

- lambda2_six: $6\cdot5/2=15=\dim\Lambda^2\mathbb R^6$. Correct.
- ambient_dim: $16\cdot15/2=120=\dim\operatorname{Sym}^2(\mathbb R^{15})$. Correct.
- weyl_six: $6\cdot7\cdot8\cdot3/12=84=n(n+1)(n+2)(n-3)/12$ at $n=6$, the dimension of $\mathcal W_6$. Correct.
- intersection_share_ambient, intersection_share_weyl, share_bracket: $\tfrac1{120}<\tfrac1{100}<\tfrac1{84}<\tfrac{12}{1000}$. Correct, since $84\cdot12=1008>1000$.

None of $15$, $120$, $84$, $\tfrac1{100}$ or $0.012$ occurs in Passage A, which fixes no value of $n$ and makes no dimension count. A share of a dimension is also not a component of (A3): the scope claim concerns which subspace Lemma L24's inequality quantifies over, and no ratio of dimensions enters it. These six theorems are CONFIRMED AS ALGEBRA and state no claim of Passage A.

### 3.2 cap_on_subspace_transfers_nothing

The statement is $\exists f:\mathbb Q^2\to\mathbb Q,\ \exists c,\ (\forall t,\ f(t,0)\le c)\wedge(\forall B\ \exists p,\ B<f(p))$, witnessed by $f(p)=p_2$, $c=0$. The proof is correct: $f(t,0)=0\le0$ and $f(0,B+1)=B+1>B$.

**The case for it.** (A3) says a cap proved on $\mathcal W_n\cap W^\perp$ is read over $\mathcal D$, and that this reading is unlicensed. The Lean statement witnesses that a bound on a subset of a domain does not bound the function on the domain. That is the logical shape of the objection.

**Why it is not the component.** An inference is shown invalid by form only by a counterexample that is an instance of the form. The form (A3) objects to is: for a self-adjoint $L$ on a finite-dimensional inner-product space and subspaces $U\subset V$, $\lambda_{\max}(L|_U)\le c$ implies $\lambda_{\max}(L|_V)\le c$. An instance is a Rayleigh quotient $x\mapsto\langle x,Lx\rangle/\langle x,x\rangle$, homogeneous of degree $0$ and bounded on $V\setminus\{0\}$ by $\|L\|$. The witness $f(p)=p_2$ is linear, homogeneous of degree $1$, and unbounded, so it is an instance of no such form, and its second conjunct $\forall B\ \exists p,\ B<f(p)$ is false for every Rayleigh quotient. Hence the Lean statement follows from the operator-level non-transfer but does not imply it. The operator-level fact has a one-line instance, $L=\operatorname{diag}(0,1)$ on $\mathbb R^2$, $U=\operatorname{span}(e_1)$, $c=0$, $\lambda_{\max}(L|_U)=0\le0<1=\lambda_{\max}(L|_{\mathbb R^2})$, and L115.lean does not state it. The declaration is REFUTED AS STATED as the component of (A3).

Even the operator-level fact would not state (A3) itself, which is a claim about the scope of Lemma L24's hypothesis ($W^\perp$ inside $\mathcal W_n$) and about the absence of an argument for the $\mathcal D$ reading. A non-transfer witness shows only that such an argument is needed, and neither version mentions $L_e$, $\mathcal W_n\cap W^\perp$ or $\mathcal D$.

### 3.3 true_claim_bad_argument

The statement is: from $C$ and $\neg H$, conclude $(H\to C)\wedge C$. The proof is correct and the content is propositional. The first conjunct holds for any $C$ once $\neg H$ is given (ex falso), and also follows from the hypothesis $C$ alone, so the theorem is equivalent to $C\to C$ after discarding a redundant premise.

**The case for it.** It can be read as recording that a GAP grades an argument and leaves its conclusion open: the unrestricted (A1) may be true while the $\mathcal D$ reading of Lemma L24 fails.

**Why it is not the component.** The conclusion $H\to C$ is vacuous under $\neg H$, so the theorem says nothing about whether $H$ supports $C$, which is what "bad argument" would have to mean. Passage A never asserts $C$ (the unrestricted (A1)) or $\neg H$ (the failure of the $\mathcal D$ reading), it asserts that the record contains no proof of the reading, and the theorem takes both as hypotheses. It is REFUTED AS STATED as a component of Passage A.

### 3.4 Conclusion for L115.lean

Every declaration of L115.lean is correctly proved, and none states (A1), (A2), (A3), (A4) or any component listed at the end of section 2 at the level Passage A uses it. The step as written FAILS at the line "the declarations of L115.lean state and prove a claim of Passage A, or a component of one that Passage A uses".

## 4. The companion file, checked for the rescue reading

### 4.1 diag M equals lambda and M is symmetric

$M_{\alpha\alpha}=\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\alpha\gamma}\lambda_\gamma$ and $c'_{\alpha\alpha\gamma}=\langle[v_\alpha,v_\alpha],v_\gamma\rangle=0$, so $\operatorname{diag}M=\lambda$. $M$ is symmetric because $c'^2$ is totally symmetric. Hence for $M$, IsTopRayleigh $M$ $\theta$ is equivalent to $\lambda_{\max}(M)\le\theta$.

### 4.2 theta_ge_diag is the deduction of (A2)

diag_is_rayleigh gives $e_\alpha\cdot Ae_\alpha=A_{\alpha\alpha}$ and $e_\alpha\cdot e_\alpha=1$, both immediate from $A e_\alpha$ being column $\alpha$. theta_ge_diag then reads $A_{\alpha\alpha}=e_\alpha\cdot Ae_\alpha\le\theta$ with $A_{\alpha\alpha}=\lambda_\alpha$. Under H4 this is exactly Passage A's "since $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)=\theta$ at a maximiser, $\theta\ge\max_\alpha\lambda_\alpha$", and it uses only the upper half $\lambda_{\max}(M)\le\theta$ of (A1). CONFIRMED, conditional on that GAP-graded half.

### 4.3 theta_gt_lambda proves (A2) outright

le_norm_of_sum_sq gives $\lambda_\alpha^2\le\sum_a\lambda_a^2=1$, hence $\lambda_\alpha\le1$ (if $\lambda_\alpha>1$ then $\lambda_\alpha^2>1$). one_lt_sqrt_three_halves gives $1<\sqrt{3/2}$. So $\lambda_\alpha\le1<\sqrt{3/2}\le\theta$. Under H5, at every global maximiser with $n\ge4$, $\theta=M(n)\ge\sqrt{3/2}$ and $\sum\lambda_\alpha^2=1$, hence $\theta>\max_\alpha\lambda_\alpha$, with margin $\theta-\lambda_\alpha\ge\sqrt{3/2}-1$ (theta_sub_lambda_ge, where $0.2247\le\sqrt{3/2}-1$ holds because $1.2247^2=1.49989009<\tfrac32$). CONFIRMED.

This proves the second clause of the Lemma L115 heading at every global maximiser by a route independent of (A1). The by-product Passage A derives through the GAP-graded (A1) therefore holds unconditionally for $n\ge4$, which is stronger than Passage A's own derivation delivers.

### 4.4 The remaining companion declarations

c5_exceeds_nonWeyl_cap ($1/\sqrt2<0.809017$, true since $0.809017\cdot\sqrt2>0.809017\cdot1.4142>1$) concerns the $C_5$ value of Passage B and states no claim of Passage A. witLam, wit_norm and the closing example check that theta_gt_lambda is satisfiable on $\lambda=(1/\sqrt2,-1/\sqrt2)$ and state no claim.

## 5. Verdict

**FAILS as written.** The declarations of [L115.lean](../lean/HamiltonsCubic/Results/L115.lean) are six dimension identities for $n=6$ absent from Passage A, a function-level non-transfer witness that is an instance of no self-adjoint compression cap and so does not establish the component (A3) uses, and a tautology whose implication is vacuous. None states or proves a claim of Passage A or a component at the level Passage A uses it.

**A VALID reading needs H3**, that "L115.lean" covers [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean) as well, together with H4 for theta_ge_diag (the deduction of (A2), conditional on $\lambda_{\max}(M)\le\theta$) or H5 for theta_gt_lambda (the second clause of the heading at every global maximiser, $n\ge4$, unconditionally), and H2 for the proofs to count as machine-checked. H1 fixes the file named by the step as the OutsideItsSpace block, so H3 replaces the object of the step rather than completing it, and the verdict on the step as written stands.
