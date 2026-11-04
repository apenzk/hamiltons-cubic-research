# Verifier v399, adjudication of step J1 in round L65-r2

Cold brief ([ADJ_L65r2_J1.md](ADJ_L65r2_J1.md)) and standard mathematics only. No numerical work was done and no scripts were written or run. Log: [agent_logs/verify-L65-v399.log](../agent_logs/verify-L65-v399.log).

| Claim | Verdict |
|---|---|
| C1. $\mathrm{cup}$ is $O(n)$-invariant | VALID |
| C2. $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is $O(n)$-equivariant $V_\lambda\to V^{\otimes12}$ | VALID |
| C3. $c_0\ne0$ for every admissible block label | VALID |
| C4. Admissibility holds whenever $\lvert\lambda\rvert\le n$ | VALID |
| C5. The seed is given in closed form, relative to the realisation $\iota_\lambda$ | VALID |
| C6. The seed is obtained without a search over $M_\lambda$ | VALID |
| Step J1 as a whole | VALID |

**Summary: under the reading the passages fix, with $V_\lambda$ realised as Weyl's subspace of traceless tensors of symmetry type $\lambda$ so that $\iota_\lambda$ is a subspace inclusion, $c_0$ is an explicit nonzero equivariant map for every admissible block label, and the step "given in closed form and need not be searched for" follows.**

## 0. Conventions, fixed once

Quoted from the brief.

- "$V=\mathbb R^n$ with the standard action of $O(n)$, and $V^{\otimes m}$ with the diagonal action $g\cdot(v_1\otimes\dots\otimes v_m)=gv_1\otimes\dots\otimes gv_m$ and the induced inner product."
- "A **block label** is a partition $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. $\lambda'$ is the conjugate partition, so $\lambda'_1$ is the number of nonzero parts of $\lambda$ and $\lambda'_2$ the number of parts of size at least $2$. $\lambda$ is **$O(n)$-admissible** when $\lambda'_1+\lambda'_2\le n$."
- "$V_\lambda$ is the $O(n)$-representation labelled by $\lambda$, and $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$."
- Passage A: "let $\iota_\lambda:V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion given by Weyl's construction of $V_\lambda$ as the traceless tensors of symmetry type $\lambda$ (classical, unfiled), and let $\mathrm{cup}=\sum_a e_a\otimes e_a\in V\otimes V$ be the invariant metric element."
- Passage A: "The realisation theorem says one nonzero seed per block generates that block."
- $k=(12-\lvert\lambda\rvert)/2$.

## 1. Hypothesis inventory

- **H1. $n\ge1$.** Stated in every passage. Used for $\mathrm{cup}\ne0$. Checked: $\mathrm{cup}$ has coefficient $1$ on $e_1\otimes e_1$.
- **H2. $\lambda$ is $O(n)$-admissible.** Stated in every passage. Used for $V_\lambda\ne0$, so that a nonzero $x\in V_\lambda$ exists. Checked against the classical theorem in H3.
- **H3. Weyl's realisation (standard mathematics).** For $d\ge0$ let $V^{[d]}\subseteq V^{\otimes d}$ be the traceless tensors, the common kernel of the $\binom d2$ contractions. For a Young symmetriser $c_\lambda\in\mathbb Q[S_d]$ with $\lvert\lambda\rvert=d$, the space $V^{[d]}c_\lambda$ is an irreducible $O(n)$-representation, and it is nonzero exactly when $\lambda'_1+\lambda'_2\le n$ (Weyl, *The Classical Groups*, Ch. V, and Fulton and Harris, *Representation Theory*, Theorem 19.19, stated over $\mathbb C$). The contractions and $c_\lambda$ are defined over $\mathbb Q$, so the real subspace and its complexification have the same dimension, and the statement holds over $\mathbb R$. $V^{[d]}$ is $O(n)$-stable because contraction commutes with the diagonal action (the metric is $O(n)$-invariant), and right multiplication by $c_\lambda$ commutes with the diagonal action. Checked.
- **H4. The realisation is fixed.** $V_\lambda$ is taken to be the subspace $V^{[d]}c_\lambda$ itself, so $\iota_\lambda$ is the tautological inclusion. Passage A states this. Passages B and C write "the inclusion", which presupposes a fixed realisation as a subspace and so carries H4 implicitly. This is the one hypothesis the strongest reading needs beyond what B and C write.
- **H5. The realisation theorem accepts any nonzero element of $M_\lambda$ as a seed.** Quoted from Passage A, taken as given by the brief. Checked only for consistency: the step claims a nonzero element, which is what H5 asks for.
- **H6. Degree count.** $\lvert\lambda\rvert+2k=12$ with $k\in\{0,\dots,6\}$ an integer, because $\lvert\lambda\rvert$ is even and at most $12$. Checked.

## 2. The argument

**C1, invariance of cup.** For $g\in O(n)$, $g\cdot\mathrm{cup}=\sum_a ge_a\otimes ge_a=\sum_{b,c}(\sum_a g_{ba}g_{ca})\,e_b\otimes e_c=\sum_{b,c}(gg^{\mathsf T})_{bc}\,e_b\otimes e_c=\mathrm{cup}$, using $gg^{\mathsf T}=I$, which holds for all of $O(n)$, reflections included. VALID.

**C2, equivariance.** Under H6, $V^{\otimes\lvert\lambda\rvert}\otimes(V\otimes V)^{\otimes k}=V^{\otimes12}$ with the diagonal action. For $x\in V_\lambda$ and $g\in O(n)$, $g\cdot c_0(x)=g\iota_\lambda(x)\otimes(g\cdot\mathrm{cup})^{\otimes k}=\iota_\lambda(gx)\otimes\mathrm{cup}^{\otimes k}=c_0(gx)$, by equivariance of the inclusion of an $O(n)$-stable subspace (H3, H4) and by C1. Linearity of $c_0$ is linearity of $v\mapsto v\otimes w$ for fixed $w$. VALID.

**C3, nonvanishing.** By H2 and H3, $V_\lambda\ne0$, so pick $x\ne0$. Then $\iota_\lambda(x)\ne0$ because $\iota_\lambda$ is injective, and $\mathrm{cup}\ne0$ by H1. Over a field, a tensor product of nonzero vectors is nonzero (extend each to a basis, the product is a basis element of the tensor product). So $c_0(x)\ne0$ and $c_0\ne0$ in $M_\lambda$, a space of maps. The alternative route in Passage A also checks: contracting the two slots of one cup sends $w\otimes\mathrm{cup}$ to $\sum_a\langle e_a,e_a\rangle w=nw$, so contracting all $k$ cups returns $n^k\iota_\lambda(x)\ne0$ since $n\ge1$. The edge cases hold: at $\lvert\lambda\rvert=0$, $V_\emptyset=V^{\otimes0}=\mathbb R$ (H3 gives $V^{[0]}=\mathbb R$, $c_\emptyset=1$), $\iota_\emptyset$ is the identity and $c_0(1)=\mathrm{cup}^{\otimes6}\ne0$. At $\lvert\lambda\rvert=12$, $k=0$ and $c_0=\iota_\lambda$. VALID.

**C4, admissibility for small labels.** $\lambda'_1+\lambda'_2=\sum_i\min(\lambda_i,2)\le\sum_i\lambda_i=\lvert\lambda\rvert$, since each part $p\ge1$ contributes $1$ to $\lambda'_1$ and $1$ to $\lambda'_2$ exactly when $p\ge2$. So $\lvert\lambda\rvert\le n$ implies admissibility. This is a sufficient condition and is stated as one ("holds whenever"). VALID.

**Hand screen, reported as a screen.** At $n=2$, $\lambda=(2)$, $k=5$: $\lambda'=(1)$, admissible, and $V_{(2)}$ is spanned by $e_1\otimes e_1-e_2\otimes e_2$ and $e_1\otimes e_2+e_2\otimes e_1$, both traceless and symmetric, so $c_0$ sends each to a nonzero tensor. At $n=3$, $\lambda=(2,2)$: $\lambda'=(2,2)$, sum $4>3$, not admissible, matching Passage A's witness that no seed exists there. The screen agrees with C3 and C4 and is not evidence for them.

**C5, closed form.** The seed is the explicit formula $x\mapsto\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ built from two named objects. $\mathrm{cup}$ is an explicit tensor. $\iota_\lambda$ is, under H4, the inclusion of the subspace $V^{[\lvert\lambda\rvert]}c_\lambda$, which is defined by explicit rational data: finitely many contraction equations and a Young symmetriser. Passage A qualifies the claim as "closed form relative to $\iota_\lambda$" and says that at $\lvert\lambda\rvert=12$ "the content is Weyl's construction", which is accurate. Passages B and C drop the qualifier, and the strongest reading restores it through H4, which "the inclusion" already presupposes. VALID.

**C6, no search.** The obligation Passage A names is finding a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes12})$ "once per block". C3 exhibits one uniformly in $\lambda$ and $n$, with no enumeration of candidates and no dependence on trial. Writing $\iota_\lambda$ in coordinates, if a pipeline needs a basis of $V_\lambda$, is a finite deterministic linear-algebra step (a kernel intersected with an image), with its output guaranteed nonzero by H3 before it is run. That is computation of a determined object, and it is distinct from the search the passages rule out. VALID.

**Strongest defence attempted against, and why it does not break the step.**

- *Objection 1: the inclusion is not unique.* $V_\lambda$ occurs in $V^{[\lvert\lambda\rvert]}$ with multiplicity equal to the number of standard tableaux of shape $\lambda$, so abstractly there are many embeddings and choosing one could be called a search. Answer: H4 fixes $V_\lambda$ as one specific subspace (one fixed $c_\lambda$), and C2, C3 hold for every such choice. The step needs one seed per block (H5), and any fixed Young symmetriser supplies it with no selection criterion to meet.
- *Objection 2: if $V_\lambda$ is given abstractly elsewhere, identifying it with Weyl's subspace is itself a Hom-construction problem.* Answer: this would break the step only under a reading where $V_\lambda$ carries a prior model different from Weyl's. Passage A defines $\iota_\lambda$ through Weyl's construction, and the brief's definition of $V_\lambda$ as "the representation labelled by $\lambda$" is an isomorphism class, which Weyl's subspace realises. Under the reading the passages fix, no identification is required.
- *Objection 3: at $k=0$ the lemma adds nothing.* Correct, and Passage A says so. The step claims that the seed is given in closed form, which remains true there with Weyl's construction as the closed form.
- *Objection 4: non-admissible block labels have no seed.* Correct, and the step is restricted to "every block label covered by the lemma", which are the admissible ones. For a non-admissible label $V_\lambda=0$ and there is no block to seed.

No location was found where the step fails, so the three FAILS checks do not arise.

**Verdict: VALID**
