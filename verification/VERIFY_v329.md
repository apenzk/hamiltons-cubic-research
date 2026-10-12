# Verifier v329, Lemma L111: criticality as $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$, the bracket form, the coordinate-diagonal family, relation (C), and the two Lean files

*Cold brief ([BRIEF_L111.md](BRIEF_L111.md)). No numerical work was done and no scripts were written. Every value below is exact and derived by hand. The cited record lines were printed at exactly the numbers the brief names and match its quotation verbatim. Log: [agent_logs/verify-L111-v329.log](../agent_logs/verify-L111-v329.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The polarised identity gives $M_{kl}=-2(W^\#)_{kl}$, with the factor 2 matching the $\tfrac12$ in the index formula for $\#$ | CONFIRMED |
| 2 | Criticality $Q(W)=\theta W$ is equivalent to $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ | CONFIRMED |
| 3 | The "i.e." in the display: bracket form equivalent to the matrix form | REFUTED (already retracted by the record's own blockquote, but the display at line 660 still carries it) |
| 4 | The bracket form is exactly $[W,Q(W)]=0$, and criticality forces $M_{kl}=0$ for all $k\ne l$, basis-independently | CONFIRMED |
| 5 | $M_{kk}=2\lambda_k(\lambda_k-\theta)$ and relation (C) are one statement | CONFIRMED |
| 6 | The bracket form is strictly weaker than criticality (heading) | HYPOTHESIS-DEBT (true, and a closed-form witness exists, but the record's support is a measurement and the Lean witness is not a Weyl tensor) |
| 7a | Every (coordinate-)diagonal Weyl tensor satisfies the bracket form (line 660 and conventions line 151) | CONFIRMED |
| 7b | Every diagonal Weyl tensor is "nowhere near critical" | REFUTED AS STATED (the balanced products $S^2\times S^2$ and $S^3\times S^3$ are coordinate-diagonal and critical) |
| 7c | The family is $n(n-3)/2$-dimensional | CONFIRMED (for a fixed orthonormal frame of $\mathbb R^n$, $n\ge3$) |
| 8a | The diagonal entries are "$N$ constraints where the record used one" | CONFIRMED AS ALGEBRA (a count of equations. No independence argument is on file, the entries are basis-dependent inside a repeated eigenspace, and "used one" is stale against line 262) |
| 8b | Off-diagonal entries cannot be written in $T=c^2$ | CONFIRMED |
| 8c | "The off-diagonal entries are the only place the Jacobi identity can enter a bound on $D$" | GAP ($D$ is undefined in every passage and the claim has no argument on file) |
| 9a | Lean L111Statement against the record | CONFIRMED AS ALGEBRA (the polarisation identity is taken as a definition, and the strictness witness is not a Weyl tensor) |
| 9b | Lean L111.lean multiplicities $(3,3,9)$ at $n=6$ and $(1,1,4)$ at $n=4$ | REFUTED (the $\Lambda^2$ spectra of the balanced products' Weyl tensors are $(6,9)$ and $(2,4)$) |

**What the round should do:** write the closed-form witness for strict weakness into the record, strike the "i.e." from the display, replace "nowhere near critical" by a scoped statement naming the critical balanced products, correct the L111.lean multiplicities to $(6,9)$ and $(2,4)$, define "diagonal" as coordinate-diagonal, and either argue or strike the Jacobi sentence.

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with the ad-invariant inner product $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$, so $e_i\wedge e_j\mapsto E_{ij}-E_{ji}$ is orthonormal. This normalisation is the one [conventions.md line 61](../findings/conventions.md#L61) and relation (A) at [bounds.md line 262](../findings/bounds.md#L262) require: $\sum_{\beta\gamma}c_{k\beta\gamma}^2=-\operatorname{tr}_{\Lambda^2}\mathrm{ad}(v_k)^2=-(n-2)\operatorname{tr}(v_k^2)=2(n-2)$.
- $\{\varphi_k\}$ is an orthonormal eigenbasis of the symmetric operator $W$ on $\Lambda^2$, $W\varphi_k=\lambda_k\varphi_k$, and $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ is totally antisymmetric.
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ ([conventions.md line 77](../findings/conventions.md#L77)). Then $\mathrm{id}^\#=\tfrac12\cdot2(n-2)\,\mathrm{id}=(n-2)\,\mathrm{id}$, as that line pins.
- $\mathrm{ad}(v)$ has matrix $(\mathrm{ad}\,v)_{dc}=\sum_a x_ac_{acd}$ for $v=\sum_ax_a\varphi_a$. All traces in $M_{kl}$ are over $\Lambda^2$ ($N\times N$).
- Critical point: $Q(W)=W^2+W^\#=\theta W$ on $\lVert W\rVert=1$, $\theta=P(W)$ ([conventions.md line 151](../findings/conventions.md#L151)).
- Coordinate-diagonal: $W(e_i\wedge e_j)=w_{ij}\,e_i\wedge e_j$ for an orthonormal frame, $w_{ij}=w_{ji}$. The sign convention is the one in which the unit round sphere has curvature operator $\mathrm{id}$ ($Q(\mathrm{id})=(n-1)\mathrm{id}$, line 77).
- For coordinate planes, $c_{acd}=\pm1$ exactly when $a,c,d$ are the three edges $ij,jk,ik$ of a triangle on three distinct indices, and $0$ otherwise.

## Hypothesis inventory

| Hypothesis | Where stated | Object it is applied to | Used by the written proof? |
|---|---|---|---|
| $W$ symmetric on $\Lambda^2$ | brief definitions | $W\in\mathcal W_n$ | Yes. $W_{fd}=W_{df}$ in the polarisation step, and existence of an orthonormal eigenbasis |
| Orthonormal eigenbasis | brief definitions ("eigenbasis" in line 656 without "orthonormal") | $\{\varphi_k\}$ | Yes. Total antisymmetry of $c$ needs orthonormality |
| Ad-invariance of $\langle\cdot,\cdot\rangle$ | conventions line 61 | $\mathfrak{so}(n)$ with $-\tfrac12\operatorname{tr}$ | Yes. $c_{bfe}=-c_{bef}$ in the polarisation step |
| Normalisation of $\#$ with the $\tfrac12$ | conventions line 77 | index formula | Yes. It fixes the factor 2 in $M=-2W^\#$ |
| $W$ Weyl (Bianchi and Ricci-flat) | brief definitions | $W$ | **No** for claims 1 to 5. The identity $M=-2W^\#$ and the equivalence hold for every symmetric operator on $\Lambda^2$. Used only to place the witnesses of claims 6 and 7 in $\mathcal W_n$ |
| $\lVert W\rVert=1$, $\theta=P(W)$ | brief definitions | $W$ | Only to identify $\theta$. On the unit sphere $Q(W)=\theta'W$ forces $\theta'=\langle W,Q(W)\rangle=P(W)$. Requires $W\ne0$ |
| $Q(\mathcal W_n)\subset\mathcal W_n$ (so that $Q=\theta W$ is the first-order condition) | implicit in conventions line 151 | $Q(W)$ | Not used. L111 takes $Q(W)=\theta W$ as the definition of critical |
| The polarised identity $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$ | line 656, no citation, no derivation | $W$, $v\in\Lambda^2$ | Yes. It is the whole argument. Checked in section 1 |
| Relation (C) | line 262 | $W$ critical | Cited in line 662, checked against $M_{kk}$ in section 5 |
| Jacobi identity | line 662 | $c$ | Named, never used in an argument |
| "Diagonal" | line 660, conventions 151, undefined at those lines | the witness family | Used but undefined at the record. Only the coordinate-diagonal reading makes 7a true, since every symmetric $W$ is diagonal in its own eigenbasis |
| $n\ge4$ | nowhere in L111 | $\mathcal W_n$ | Not used. $\mathcal W_3=0$, so the unit sphere is empty and the lemma is vacuous at $n=3$ |

Findings from the inventory: the Weyl hypothesis is stated but unused in claims 1 to 5 (harmless, the lemma is more general than stated). "Diagonal" is used but undefined at the record.

## 1. The polarised identity and the factor 2

**Record, line 656:** "Polarising $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$ and substituting $W^\#=\theta W-W^2$ gives exactly that."

The identity is not derived on file. Following its algebra from the index formula:

$\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)=\sum(\mathrm{ad}\,v)_{dc}W_{ce}(\mathrm{ad}\,v)_{ef}W_{fd}=\sum x_ax_b\,c_{acd}c_{bfe}W_{ce}W_{fd}$.

Antisymmetry gives $c_{bfe}=-c_{bef}$ and symmetry of $W$ gives $W_{fd}=W_{df}$, so this is $-\sum x_ax_bc_{acd}c_{bef}W_{ce}W_{df}=-2\langle v,W^\#v\rangle$. The identity holds.

Both sides are quadratic forms of symmetric bilinear forms: $(u,v)\mapsto\langle u,W^\#v\rangle$ is symmetric because $W^\#$ is, and $(u,v)\mapsto\operatorname{tr}(\mathrm{ad}(u)W\mathrm{ad}(v)W)$ is symmetric by cyclicity of the trace. Polarisation is therefore valid, and directly in index form $M_{kl}=\sum c_{kcd}W_{ce}c_{lfe}W_{fd}=-\sum c_{kcd}c_{lef}W_{ce}W_{df}=-2(W^\#)_{kl}$.

In the eigenbasis $W_{ce}=\lambda_c\delta_{ce}$, so $M_{kl}=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$ and $(W^\#)_{kl}=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$.

**The factor.** $M$ is defined without reference to $\#$. The relation $M=-2W^\#$ holds with the record's halved $\#$. With the unhalved index formula it would read $M=-W^\#_{\text{unhalved}}$, and the displayed $2\lambda_k(\lambda_k-\theta)$ is correct only for the halved $\#$ that enters $Q$. The record uses the halved one. Consistent.

Hypotheses used: symmetry of $W$, orthonormality of the basis, ad-invariance. No Weyl condition. Verdict CONFIRMED.

## 2. Criticality is equivalent to the matrix form

$Q(W)=\theta W\iff W^\#=\theta W-W^2$. In the orthonormal eigenbasis $\theta W-W^2=\operatorname{diag}(\theta\lambda_k-\lambda_k^2)$. Since $M=-2W^\#$ identically, $W^\#=\theta W-W^2\iff M=\operatorname{diag}(2\lambda_k^2-2\theta\lambda_k)=\big(2\lambda_k(\lambda_k-\theta)\delta_{kl}\big)$.

Both directions are the same line read each way, since $M\mapsto-\tfrac12M$ is a bijection. The $\delta_{kl}$ is part of the equation on both sides: in the forward direction it is a conclusion (the off-diagonal entries of $W^\#$ vanish because $\theta W-W^2$ is diagonal), and in the converse it is a hypothesis carrying $N(N-1)/2$ scalar equations.

**Quantifiers.** $\theta$ is fixed first ($\theta=P(W)$, or $\exists\theta$, which agree on the unit sphere for $W\ne0$), then $\forall k,l$. The eigenbasis may be read "for every" or "for some" orthonormal eigenbasis: $W^\#=\theta W-W^2$ is basis-free, so the two readings agree. Verdict CONFIRMED.

## 3. The "i.e." in the display

**Record, line 660:** "$M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$, i.e. $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$".

By section 1 the right-hand condition is $(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l$. It drops two sets of equations from the matrix form: all $N$ diagonal entries, and the off-diagonal entries inside each eigenspace of dimension $\ge2$.

- **Locate:** line 660, the display.
- **Exhibit:** the coordinate-diagonal Weyl tensor at $n=4$ with $(w_{12},w_{13},w_{14})=(w_{34},w_{24},w_{23})=(1,-1,0)$ satisfies the right-hand side and is not critical for any $\theta$ (section 6).
- **Charitable reading:** the record's own blockquote at line 660 says "THE 'EQUIVALENTLY' IS FALSE" and the heading at line 636 says the bracket form is strictly weaker. The record has retracted the "i.e.". The defect that survives is presentational: the display still asserts it, and a reader who stops at the display takes away the false equivalence.

What it is equivalent to is in section 4. The restriction "$\lambda_k\ne\lambda_l$" is the exact content of $[W,W^\#]=0$, so it is right for the bracket form and wrong as a transcription of criticality. Verdict REFUTED, already retracted, display to be amended.

## 4. The bracket form is $[W,Q(W)]=0$, and criticality kills every off-diagonal entry

$[W,Q(W)]=[W,W^2+W^\#]=[W,W^\#]$, and in the eigenbasis $([W,W^\#])_{kl}=(\lambda_k-\lambda_l)(W^\#)_{kl}$. So $[W,Q(W)]=0\iff(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l\iff$ the bracket form. Equivalently $W^\#$ preserves every eigenspace of $W$, which is basis-free.

Criticality gives $W^\#=\theta W-W^2$, diagonal in every orthonormal eigenbasis, so $(W^\#)_{kl}=0$ for all $k\ne l$ in every such basis. "Basis-independently" holds. Verdict CONFIRMED.

## 5. Diagonal entries against relation (C)

$M_{kk}=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}$. The matrix form's diagonal is $M_{kk}=2\lambda_k(\lambda_k-\theta)$, which is $\sum\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\lambda_k(\theta-\lambda_k)$, relation (C) at [bounds.md line 262](../findings/bounds.md#L262), and the line 662 statement "$\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$". The sign flip is the single minus from antisymmetry in section 1. One statement, signs consistent.

A consistency check on the trace: $\sum_k\lambda_k\cdot(\text{C})_k$ reads $2\langle W,W^\#\rangle=2\theta\sum\lambda_k^2-2\sum\lambda_k^3$, which on $\lVert W\rVert=1$ is $P(W)=\operatorname{tr}W^3+\langle W,W^\#\rangle=\theta$. Verdict CONFIRMED.

## 6. "The bracket form is strictly weaker"

**What is on file.** Line 660: "Measured here on six diagonal elements of $\mathcal W_6$ (distance from $\mathcal W_6$ $\le5\times10^{-17}$): off-diagonal residual $0.000\times10^0$ exactly, at criticality residuals $0.527$ to $0.741$." That is a run. The Lean witness `bracket_form_strictly_weaker` uses $\lambda=(1,-1)$ on Fin 2 with $W^\#$-slot identically $0$, and it is not a Weyl tensor (section 9). No analytic argument for strict weakness is on file.

**What would have to be proved.** One $W\in\mathcal W_n$, $W\ne0$, with $[W,W^\#]=0$ and $W^\#\ne\theta W-W^2$ for every $\theta\in\mathbb R$, for each $n\ge4$.

**Test of the record's own named family against that requirement.** At $n=4$ the coordinate-diagonal Weyl tensors are $w_{12}=w_{34}=a$, $w_{13}=w_{24}=b$, $w_{14}=w_{23}=c$ with $a+b+c=0$ (section 7c). By section 7a, $(W^\#)_{ij,ij}=\sum_{k\ne i,j}w_{ik}w_{jk}$, which gives $(W^\#)_{12}=(W^\#)_{34}=2bc$, $(W^\#)_{13}=(W^\#)_{24}=2ac$, $(W^\#)_{14}=(W^\#)_{23}=2ab$. At $(a,b,c)=(1,-1,0)$: plane $12$ needs $0=\theta-1$, plane $13$ needs $0=-\theta-1$. No $\theta$ exists. Padding by zeros to $n\ge5$ keeps Ricci-flatness ($\sum_jw_{ij}$ unchanged for $i\le4$, zero for $i>4$) and leaves the planes-$12$ and $13$ equations unchanged, since $w_{ik}=0$ for $k>4$. The padded object has $\ker W\ne0$, which costs nothing here.

So the heading is true, and the debt is dischargeable by the paragraph above. As the record stands the claim rests on a measurement. Verdict HYPOTHESIS-DEBT.

## 7. The coordinate-diagonal family

### 7a. Every coordinate-diagonal Weyl tensor satisfies the bracket form

$(W^\#)_{ab}=\tfrac12\sum_{c,d}c_{acd}c_{bcd}w_cw_d$. For $c_{acd}c_{bcd}\ne0$ both $a$ and $b$ must complete the pair $\{c,d\}$ to a triangle, and that third edge is unique. So $a=b$, and $W^\#$ is diagonal in the coordinate basis, which is an orthonormal eigenbasis of $W$. Hence $[W,W^\#]=0$, which by section 4 is the bracket form in every eigenbasis. On the diagonal the ordered pairs $(ik,jk),(jk,ik)$ give $(W^\#)_{ij,ij}=\sum_{k\ne i,j}w_{ik}w_{jk}$, and $w\equiv1$ returns $n-2$, matching line 77. The argument uses no Weyl condition. Verdict CONFIRMED, with "diagonal" read as coordinate-diagonal.

### 7b. "Nowhere near critical"

- **Locate:** line 660, "every diagonal Weyl tensor satisfies it while being nowhere near critical".
- **Exhibit, $n=6$:** the product $S^3\times S^3$ (unit factors, indices $1,2,3\,|\,4,5,6$) has sectional curvatures $1$ on same-factor planes and $0$ on mixed ones, $\mathrm{Ric}=2g$, $\mathrm{scal}=12$. For a coordinate-diagonal operator, $K_W(e_i,e_j)=K_R-(\mathrm{Ric}_{ii}+\mathrm{Ric}_{jj})/(n-2)+\mathrm{scal}/((n-1)(n-2))$, giving $w=1-1+\tfrac35=\tfrac35$ on the $6$ same-factor planes and $w=-1+\tfrac35=-\tfrac25$ on the $9$ mixed planes. Ricci-flat: $2\cdot\tfrac35+3\cdot(-\tfrac25)=0$. Scale to $s=3$, $m=-2$. Plane $12$: $(W^\#)_{12}=w_{13}w_{23}+\sum_{k=4}^6w_{1k}w_{2k}=9+12=21=3\theta-9$, so $\theta=10$. Plane $14$: $\sum_{k=2,3}w_{1k}w_{4k}+\sum_{k=5,6}w_{1k}w_{4k}=-12-12=-24=-2\theta-4$, so $\theta=10$. Every plane is one of these two types by symmetry, so $W^\#=10W-W^2$: critical, with $P=10/\sqrt{90}=\sqrt{10}/3$ after normalising ($\lVert W\rVert^2=6\cdot9+9\cdot4=90$).
- **Exhibit, $n=4$:** $(a,b,c)=(1,1,-2)$, the Weyl tensor of $S^2\times S^2$ up to scale. Plane $12$: $2bc=-4=\theta-1$, $\theta=-3$. Plane $13$: $2ac=-4=\theta-1$. Plane $14$: $2ab=2=-2\theta-4=2$. Critical with $\theta=-3$.
- **Charitable reading:** "nowhere near critical" describes the six measured elements, or generic members, and strict weakness needs only one non-critical member. Under that reading the logic of the heading is intact. The sentence as written quantifies "every" over both conjuncts, and it is false for the balanced products, which are the programme's standard critical candidates. Verdict REFUTED AS STATED. Impact on the heading: none.

### 7c. "An $n(n-3)/2$-dimensional family"

For a fixed orthonormal frame, a coordinate-diagonal operator has $N=n(n-1)/2$ free values $w_{ij}$. The first Bianchi identity involves only components with four distinct slots in positions that are zero for a diagonal operator, or repeats indices where it is automatic, so it imposes nothing. Ricci-flatness is $\sum_jw_{ij}=0$ for each $i$: the unsigned incidence matrix of $K_n$, rank $n$ for $n\ge3$ ($K_n$ contains a triangle, so it is non-bipartite). Dimension $n(n-1)/2-n=n(n-3)/2$: $0,2,5,9$ at $n=3,4,5,6$. The union over frames is larger, so the count holds per frame. Verdict CONFIRMED with that scope.

## 8. Line 662

### 8a. "$N$ constraints where the record used one"

The diagonal entries are $N$ equations (C)$_k$. The "one" is recovered as $\sum_k\lambda_k(\text{C})_k$, which is $P=\theta$ (section 5). Three qualifications:

- No independence argument is on file. The line counts equations and asserts nothing about independence, so there is nothing to refute, but a route may not read "$N$ constraints" as $N$ independent ones.
- Inside an eigenspace $E$ of dimension $m\ge2$ the individual diagonal entries depend on the orthonormal basis of $E$. Only their sum over $E$ and the full block $W^\#|_E=(\theta\lambda-\lambda^2)\mathrm{id}_E$ are basis-free.
- Line 262 already holds (C) "for every $k$", so "where the record used one" is stale as a description of the record.

Verdict CONFIRMED AS ALGEBRA.

### 8b. Off-diagonal entries in $T=c^2$

$M_{kl}=-\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$ for $k\ne l$. Replacing $\varphi_k$ by $-\varphi_k$ gives another orthonormal eigenbasis, flips $c_{k\alpha\beta}$ for all $\alpha,\beta$, leaves every $T_{abc}$ unchanged and flips $M_{kl}$. So $M_{kl}$ is not a function of $T$ (unless it vanishes, as it does at criticality). Verdict CONFIRMED.

### 8c. "The only place the Jacobi identity can enter a bound on $D$"

- **Locate:** line 662.
- **Exhibit:** $D$ is not defined in any passage the brief quotes, so the claim cannot be tested against an object. It is a universal negative over all ways the Jacobi identity could enter, with no argument on file.
- **Charitable reading:** among the entries of $M$, only the off-diagonal ones carry sign information beyond $T$, and the Jacobi identity is a sign-sensitive quadratic relation in $c$. That supports "the off-diagonal entries are a place Jacobi can enter", but "the only place" would need every Jacobi-derived relation relevant to $D$ to factor through $\{M_{kl}\}_{k\ne l}$. Quartic contractions such as $\sum\lambda_\alpha\lambda_\beta\lambda_\gamma\lambda_\delta c_{\alpha\beta\epsilon}c_{\epsilon\gamma\delta}c_{\cdots}c_{\cdots}$ are not entries of $M$, and nothing on file excludes them.

Verdict GAP. What would have to be proved: a definition of $D$, and that every identity on $c$ derived from Jacobi and bearing on $D$ is a consequence of the off-diagonal $M_{kl}$ together with (A), (B), (C).

## 9. The Lean files against the record

### 9a. L111Statement

- `Qmat lam Ws k l = (if k = l then lam k ^ 2 else 0) + Ws k l` models $Q(W)$ in the eigenbasis with `Ws` in the $W^\#$ slot. `Ws` is an arbitrary function, neither symmetric nor tied to `lam` through structure constants. The type `κ` has no `Fintype` and no link to $N=\binom n2$.
- `Mmat Ws k l = -2 * Ws k l` takes $M=-2W^\#$ as a definition. The polarisation identity, which is the load-bearing algebra of claim 1, is assumed and not machine-checked.
- `matrix_form_is_criticality` is then the rearrangement of section 2. Binders `(lam) (Ws) (θ)`, both directions, direction and types match the record. CONFIRMED as the rearrangement.
- `BracketForm` is `∀ k l, lam k ≠ lam l → Ws k l = 0`, the record's bracket form under section 1. `CommutesWithW` is $(WQ)_{kl}=(QW)_{kl}$ in the eigenbasis. `commutes_iff_bracket_form`, `critical_forces_all_offdiagonal` and `critical_imp_bracket_form` match sections 4 and the record's "for all $k\ne l$".
- `bracket_form_strictly_weaker` uses `![1, -1] : Fin 2 → ℝ` and `Ws = fun _ _ => 0`. $N=2$ is not $\binom n2$ for any $n$, and no Weyl tensor sits behind the pair. It proves that the two propositions differ over free data, which is weaker than the heading's claim over $\mathcal W_n$. The `¬ ∃ θ` binder is the right one.
- `dropped_count_identity`, `counts_at_balanced_products` and `dropped_fractions` are correct arithmetic. $(6,9)$ at $n=6$ and $(30,36)$ at $n=12$ are the balanced products' same-factor and mixed plane counts. The subtraction of one in $1130/2210$ is not explained in any quoted passage, and none of these counts appears in Passage A.

### 9b. L111.lean

- **Locate:** `multiplicities_six : 3 + 3 + 9 = Nat.choose 6 2`, `dropped_six : dropped 3 + dropped 3 + dropped 9 = 57`, `share_six : 57 / 120 = 19 / 40`, and `multiplicities_four : 1 + 1 + 4 = Nat.choose 4 2`, `dropped_four ... = 12`.
- **Exhibit:** section 7b gives the $\Lambda^2$ spectrum of the unit Weyl tensor of $S^3\times S^3$ as $1/\sqrt{10}$ on all $6$ same-factor planes and $-2/\sqrt{90}$ on the $9$ mixed planes, so the multiplicities are $(6,9)$. The two factors' $\Lambda^2$ blocks share one eigenvalue. This holds for every pair of radii: with curvatures $1$ and $\kappa$ both same-factor values are $3(1+\kappa)/10$ and the mixed value is $-(1+\kappa)/5$. At $n=4$, $S^2\times S^2$ gives $\tfrac23$ on planes $12,34$ and $-\tfrac13$ on the four mixed planes, multiplicities $(2,4)$. The correct dropped counts are $\binom72+\binom{10}2=21+45=66$ of $120$ and $\binom32+\binom52=3+10=13$ of $21$, against the file's $57$ and $12$.
- **Charitable reading:** $(3,3,9)$ would be right for an object whose two same-factor blocks carry different eigenvalues. No product of two 3-spheres is such an object, and the file's names (`split_from_L76`, `multiplicities_six`) and L111Statement's `counts_at_balanced_products` both point at the balanced product. The two files disagree on the same object, and L111Statement is the correct one.

Verdict REFUTED for L111.lean's multiplicities. `cross_dominates` and `share_in_range` inherit the wrong totals. The arithmetic inside each theorem is correct.

## 10. Boundaries and traps, by name

- **$\ker W\ne0$ and $\lambda_k=0$.** Claims 1 to 5 involve no division by $\lambda$. At $\lambda_k=0$ the matrix form reads $M_{kk}=0$ and $M_{kl}=0$, and (C) reads $\sum\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=0$. The padded witness of section 6 has $\ker W\ne0$ and remains valid. No finding.
- **Repeated eigenvalues.** Claims 2 and 4 are basis-free. The bracket form's gap from criticality grows with multiplicity (section 3), and the diagonal entries of 8a become basis-dependent. Recorded under 8a.
- **Smallest dimension.** $\mathcal W_3=0$, so the lemma is vacuous at $n=3$. At $n=4$ the family has dimension $2$ and contains both a critical member ($S^2\times S^2$) and a non-critical one. At $n=5$ the padded witness applies and the family has dimension $5$. No finding.
- **Odd $n$.** Nothing in the lemma depends on parity. The padded witness covers odd $n$.
- **Crossover $n=6+2\sqrt7$.** No step of L111 depends on $n$ beyond relation (A), which the lemma does not use. No finding.
- **Subfamily stated in general.** 7a is proved for coordinate-diagonal $W$ and stated for "diagonal", which read literally covers every $W$ and is then false (the record's own random screen gives nonzero off-diagonal entries). Finding under the inventory: define "diagonal".
- **Hypothesis stated but unused, or used but unstated.** The Weyl condition is unused in claims 1 to 5. "Diagonal" and the orthonormality of the eigenbasis at line 656 are used and not stated at the record lines.
- **Universal claim with no witness.** "Nowhere near critical" (7b) fails on the sphere products. "The only place the Jacobi identity can enter" (8c) has no argument. $\mathbb{CP}^m$ is outside the coordinate-diagonal family and was not needed.
- **Imported theorem with unchecked hypotheses.** The polarised identity is uncited. Its hypotheses (symmetric $W$, ad-invariant form, orthonormal basis) were checked in section 1 and hold. The Böhm–Wilking normalisation of $\#$ is fixed by line 77 and consistent.

## Withdrawn candidates

- **The polarised identity needs the Weyl condition.** Withdrawn: section 1 uses only symmetry of $W$ and antisymmetry of $c$.
- **The factor 2 in $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ clashes with the $\tfrac12$ in the index formula.** Withdrawn: $M=-2W^\#$ exactly with the halved $\#$, which is the one in $Q$.
- **The signs of $M_{kk}$ and (C) disagree.** Withdrawn: they differ by the one minus sign from antisymmetry, and state the same equation (section 5).
- **"Basis-independently" fails at repeated eigenvalues.** Withdrawn: $\theta W-W^2$ is diagonal in every orthonormal eigenbasis.
- **The $n(n-3)/2$ count ignores the Bianchi identity.** Withdrawn: Bianchi is automatic on coordinate-diagonal operators, and the count is correct per frame.
- **The balanced product's same-factor blocks split, making $(3,3,9)$ correct.** Withdrawn: the Weyl values on the two blocks coincide for all radii (section 9b).

## 11. The falsifying object

The heading would be falsified by a $W\in\mathcal W_n$ that satisfies the matrix form without being critical (impossible by section 2, an identity), or by the bracket form implying criticality on all of $\mathcal W_n$ (falsified by the $n=4$ coordinate-diagonal tensor $(1,-1,0)$ and its zero-padding). I checked the coordinate-diagonal family, where the bracket form is automatic, at $n=4$ in full ($a+b+c=0$) and at the balanced products $S^2\times S^2$ and $S^3\times S^3$. The polarisation identity was followed index by index. No object falsifies claims 1, 2, 4, 5 or the heading. The objects found falsify 7b as stated and the L111.lean multiplicities.

## Overall verdict: HYPOTHESIS-DEBT

- The matrix form is criticality, in both directions, for every symmetric $W$ on $\Lambda^2$, and its diagonal is relation (C).
- The heading's "strictly weaker" is true, but the record supports it only by a measurement and a Lean witness that is not a Weyl tensor. The closed-form witness in section 6 discharges it.
- To correct in the round: the display's "i.e.", the universal "nowhere near critical" (sphere products are critical), the undefined "diagonal", the unargued Jacobi sentence, and L111.lean's multiplicities $(3,3,9)$ and $(1,1,4)$, which should be $(6,9)$ and $(2,4)$.
