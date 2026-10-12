# Verifier v318, Lemma L101: the three-term invariance identity, the diagonal vanishing $T(x,x,[\rho(A),u])=0$, $Q(x)\perp T_u(SO(n).u)$, the general form $(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$, the value $0.91$, $P\equiv0$ on $V_{1/2}$, and the Lean statements

Cold brief ([BRIEF_L101.md](BRIEF_L101.md)). No numerical work was done, no scripts were written, no Lean build was run, and every value below is exact. The Lean proofs were followed by hand. Log: [agent_logs/verify-L101-v318.log](../agent_logs/verify-L101-v318.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Three-term identity $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ from $SO(n)$-invariance | CONFIRMED |
| C2 | Diagonal chain $T(x,x,[A,u])=-2T(A\cdot x,x,u)=-2\lambda\langle A\cdot x,x\rangle=0$ | CONFIRMED (typing of $[A,u]$ and the normalisation of $\lambda$ to be corrected) |
| C3 | $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$, every dimension, no hypothesis, criticality unused | CONFIRMED, and it holds for every base point $u\in\mathcal W_n$ |
| C4 | General form $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$ for $x\in V_\lambda$, $y\in V_\mu$ | CONFIRMED with $V_\lambda$ read in $\theta^*$ units as in Passage C, off by the factor $\theta^*$ under Passage A's literal $F_ux=\lambda x$ |
| C5 | "vanishing on the diagonal and reaching $0.91$ off it" | Vanishing CONFIRMED, the value $0.91$ HYPOTHESIS-DEBT (no argument, no normalisation stated) |
| C6 | "It also gives $P\equiv0$ on $V_{1/2}$" | GAP |
| C7 | The heading against the body | GAP (the heading carries C6, which the body does not prove, and no range of $n$ for it) |
| C8 | Lean statements in [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean) lines 92-153 | CONFIRMED AS ALGEBRA |

**The round should:** write the two-line argument for $P\equiv0$ on $V_{1/2}$ with its hypotheses ($u$ critical, $n\ge9$, Theorem 4.14's completeness at eigenvalue $\tfrac12\theta^*$), fix one normalisation of $\lambda$ across the block and write $[\rho(A),u]$ throughout, and either give $0.91$ a normalisation and a closed form or withdraw it.

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with $\langle X,Y\rangle=\operatorname{tr}(XY)$.
- $SO(n)$ acts by $g\cdot W=\rho(g)W\rho(g)^{-1}$, so $\mathfrak{so}(n)$ acts by $A\cdot W=[\rho(A),W]$, and $T_u(SO(n).u)=\{[\rho(A),u]:A\in\mathfrak{so}(n)\}$.
- $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))=\tfrac12(XY+YX)+X\#Y$, since $\#$ is symmetric bilinear. Hence $F_u=u\circ(\cdot)$, $Q(x)=x\circ x$, and with $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ (fully symmetric, [conventions.md](../findings/conventions.md) line 24): $T(x,z,u)=\langle F_ux,z\rangle$ and $T(x,x,z)=\langle Q(x),z\rangle$.
- **Two normalisations of eigenvalues occur in the passages.** Literal: $F_ux=\lambda x$ (Passage A, diagonal chain). $\theta^*$ units: $x\in V_\lambda$ means $F_ux=\lambda\theta^*x$ (Passage C, "$V_{1/3}$" with $F_uW_1=\tfrac13\theta^*W_1$, and Theorem 4.14's spectrum $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\sqrt{3/2}$). Below, $V_\lambda$ always means $\theta^*$ units and a literal eigenvalue is written $\ell$.
- $u=W_{\mathbb{CP}^2}$ padded, unit, $\theta^*=\sqrt{3/2}$, when a specific base point is needed. C1 to C4 hold for arbitrary $u\in\mathcal W_n$.

## 1. Hypothesis inventory

**Carried by the statement (Passage A).**

| Hypothesis | Where stated | Used by |
|---|---|---|
| $T$ is $SO(n)$-invariant | "The trilinear form $T$ is $SO(n)$-invariant" | C1, hence C2 to C4 |
| $T$ fully symmetric | Passage B line 24, and "since $F_u$ is symmetric" | C2 (slot swaps), C4 |
| $A\cdot$ is a Frobenius-skew derivation | "the derivation $X\mapsto[\rho(A),X]$ is Frobenius-skew" | C2, C4 |
| $x$ (and $y$) eigenvectors of $F_u$ | "$F_ux=\lambda x$", "$x\in V_\lambda$, $y\in V_\mu$" | C2, C3, C4 |
| $u$ is the padded $\mathbb{CP}^2$ operator, $\theta^*=\sqrt{3/2}$ | section context, Passage B line 64 | only through the symbol $\theta^*$ in C4 |
| $u$ critical ($Q(u)=\theta^*u$) | explicitly disclaimed for C3 | unused by C1 to C4, **needed by C6 and never stated there** |
| a range of $n$ | "in every dimension" | C1 to C4 need none. **C6 needs $n\ge9$ and none is stated** |

**Imported, each checked against its object.**

- **$SO(n)$-equivariance of $Q$** (asserted, no argument in the block). Checked: $W\mapsto W^2$ commutes with conjugation by the orthogonal $\rho(g)$. $W\#V$ is built from the Lie bracket of $\mathfrak{so}(n)\cong\Lambda^2$, and $\rho=\mathrm{Ad}$ satisfies $[\mathrm{Ad}_ga,\mathrm{Ad}_gb]=\mathrm{Ad}_g[a,b]$, so $\#$ is equivariant. The inner product is invariant. So $T(gX,gY,gZ)=T(X,Y,Z)$. Holds for every $n$ and every $u$.
- **Full symmetry of $T$**, from [conventions.md](../findings/conventions.md) line 24. Used in C2 and C4 to move $u$ between slots. Accepted as the record's definition, and its two-part argument ($W^2$ part as symmetrised $\operatorname{tr}(XYZ)$, $\#$ part with sign $(-1)^2$) reads correctly.
- **Frobenius skewness of $[\rho(A),\cdot]$.** $\langle[\rho A,X],Y\rangle=\operatorname{tr}(\rho A\,XY)-\operatorname{tr}(X\rho A\,Y)$ and $\langle X,[\rho A,Y]\rangle=\operatorname{tr}(X\rho A\,Y)-\operatorname{tr}(XY\rho A)$, so by cyclicity the sum is $0$. This uses only trace cyclicity. That $[\rho A,X]$ is again a symmetric Weyl operator uses $\rho(A)^T=-\rho(A)$ and $SO(n)$-invariance of $\mathcal W_n$. Holds in every $n$.
- **Theorem 4.14 and Remark 4.16** ([Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md), source text lines 4365-4411 and 4657-4671). Theorem 4.14 carries $n\ge9$. Remark 4.16 shows $F(W)=\tfrac12\sqrt{3/2}\,W$ on $T_{W_{\mathbb{CP}^2}}SO(n).W_{\mathbb{CP}^2}$ by differentiating $Q(W(t))=\sqrt{3/2}\,W(t)$ along the orbit (this is criticality), and identifies the tangent space with case (b)'s summands $\mathrm{Weyl}^{-,1}_4\oplus X^{-,2}_4\otimes\mathbb R^{n-4}$ by dimension comparison. Neither is used by C1 to C4. Both are needed by C6, which does not cite them. Passage C cites them for $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$. The record's own notes on Lemma 4.13 flag that Theorem 4.14's proof inherits a multiplicity-free hypothesis. That is an inherited dependency of C6 through Passage C, outside L101's own text.
- **Lemma L21** (Passage D). Given. Used by nothing in L101.

**Unused or unstated.** Unused hypotheses: the specific $u$ and $\theta^*=\sqrt{3/2}$ are unused by C1 to C4 (the result is base-point free). Used but unstated: criticality of $u$ and $n\ge9$, both by C6.

## 2. Quantifier order and scope

The block's claims read: for all $u\in\mathcal W_n$ (the argument never specialises $u$), for all $A\in\mathfrak{so}(n)$, for all eigenvalues and all $x\in V_\lambda$, $y\in V_\mu$. No existential sits inside, and nothing depends on the order. $Q(x)\perp T_u(SO(n).u)$ is "for all $A$, $\langle Q(x),[\rho A,u]\rangle=0$", which is what the diagonal case gives with $A$ free. "Every eigenvector" is exactly the right scope: for $x=x_1+x_2$ with $x_i\in V_{\lambda_i}$, $\lambda_1\ne\lambda_2$, the three-term identity gives $T(x,x,[\rho A,u])=-2\langle F_ux,A\cdot x\rangle=2(\lambda_1-\lambda_2)\theta^*\langle A\cdot x_1,x_2\rangle$ (from C4 and bilinearity), which need not vanish. So the claim is neither over- nor under-quantified. $P\equiv0$ on $V_{1/2}$ is a statement at one fixed $u$ and carries an implicit $n$.

## 3. Edges of range

- **Smallest dimension, odd $n$.** C1 to C4 use no dimension count and hold for every $n$ (vacuously at $n\le3$, where $\mathcal W_n=0$). Odd $n$ changes nothing. C6 imports Theorem 4.14, stated for $n\ge9$ (both parities). For $5\le n\le8$ the notes record the decomposition (Remark 4.12) but no eigenvalue theorem, so C6 has no support there.
- **The crossover $n=6+2\sqrt7$.** No step of L101 depends on it. Nothing to check.
- **$\ker u\ne0$ (padding).** No step inverts $u$ or $F_u$. At $x\in\ker F_u$ ($\ell=0$) the chain gives $T(x,x,[\rho A,u])=-2\langle F_ux,A\cdot x\rangle=0$ directly. Checked below in §9 with closed-form witnesses.
- **$\lambda=\mu$, $x\ne y$.** C4 gives $T(x,y,[\rho A,u])=0$. The derivation in §5 applies verbatim with $\mu=\lambda$ and never uses $x=y$. Confirmed.

## 4. Proven against claimed or used

- Proven in the block: C1, C2, C3, and C4 (C4 as "the general form is exact", whose derivation is one line from C1, written out in §5).
- Claimed without argument: C5's $0.91$ and C6.
- Used downstream: the block says it "does not tighten the bound". Within the lines this brief allows me to read, nothing downstream cites L101, so no use can be checked against the proof.
- Proven more generally than stated: C3 holds at every $u\in\mathcal W_n$, as the Lean docstring's "any base point" also says.

## 5. Claims C1 to C4

### C1. The three-term identity

$T$ is trilinear and $T(g\cdot X,g\cdot Y,g\cdot Z)=T(X,Y,Z)$ (§1). Put $g=\exp(tA)$, acting by $\rho(\exp tA)(\cdot)\rho(\exp tA)^{-1}$, and differentiate at $t=0$. Trilinearity gives $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ with $A\cdot=[\rho(A),\cdot]$. It uses invariance only, and no symmetry of $T$. **Attack item 1 answered:** invariance of $T$, i.e. equivariance of $Q$ and of the inner product. The action is the derivative of conjugation through $\rho$. No symmetry is needed for C1 itself. CONFIRMED.

### C2. The diagonal chain

- First equality, $T(x,x,A\cdot u)=-2T(A\cdot x,x,u)$: C1 at $y=x$, $z=u$, and $T(x,A\cdot x,u)=T(A\cdot x,x,u)$, which is symmetry in slots 1 and 2 (symmetry of $\circ$).
- Second equality, $T(A\cdot x,x,u)=\langle F_ux,A\cdot x\rangle=\ell\langle A\cdot x,x\rangle$: full symmetry moves $u$ into slot 2, $T(A\cdot x,x,u)=T(x,u,A\cdot x)=\langle x\circ u,A\cdot x\rangle$. Then $F_ux=\ell x$. In Passage A's normalisation $\lambda=\ell$. In the section's $\theta^*$ units this factor is $\lambda\theta^*$.
- Third equality, $\langle A\cdot x,x\rangle=0$: Frobenius skewness at $X=Y=x$.

**Attack item 2.** "$A\cdot u=[A,u]$" is ill-typed as written: $A$ is an $n\times n$ matrix and $u$ an operator on $\Lambda^2\mathbb R^n$ of size $\binom n2$. It is correct only read as $[\rho(A),u]$, which is what the general form writes. Charitable reading holds (the block's own next sentence names the derivation $X\mapsto[\rho(A),X]$), so this is a notational correction, recorded in §7 as withdrawn as a defect. **Attack item 3:** each equality verified, symmetries named above. The chain's $\lambda$ is literal. CONFIRMED.

### C3. $Q(x)\perp T_u(SO(n).u)$

$\langle Q(x),[\rho A,u]\rangle=T(x,x,[\rho A,u])=0$ by C2, for every $A$, so $Q(x)$ is orthogonal to every tangent vector. **Attack item 4.** What the argument uses: $SO(n)$-invariance and full symmetry of $T$, skewness of $A\cdot$, and $F_ux=\ell x$ for some real $\ell$. It uses neither criticality of $u$, nor the specific $u$, nor $\theta^*$, nor any $n$, nor $u$ invertible. So the conclusion holds **more generally** than the section's setting: at every $u\in\mathcal W_n$ in every $n$. "No hypothesis" is accurate once read as "no hypothesis on $u$ or $n$". The hypothesis "$x$ is an eigenvector" is essential (§2). CONFIRMED.

### C4. The general form

C1 at $z=u$: $T(x,y,A\cdot u)=-T(A\cdot x,y,u)-T(x,A\cdot y,u)$. With $F_ux=\lambda\theta^*x$, $F_uy=\mu\theta^*y$ and full symmetry:

- $T(A\cdot x,y,u)=\langle F_uy,A\cdot x\rangle=\mu\theta^*\langle A\cdot x,y\rangle$.
- $T(x,A\cdot y,u)=\langle F_ux,A\cdot y\rangle=\lambda\theta^*\langle x,A\cdot y\rangle=-\lambda\theta^*\langle A\cdot x,y\rangle$.

So $T(x,y,[\rho A,u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$, sign and factor as recorded. **Attack item 5.** In $\theta^*$ units (Passage C's $V_{1/3}$) the display is exact. Under Passage A's literal "$F_ux=\lambda x$" the same derivation gives $(\lambda-\mu)\langle A\cdot x,y\rangle$ without $\theta^*$. The two displays of the block use one letter in two normalisations.

Candidate finding, three steps.
- *Locate:* "since $F_u$ is symmetric with $F_ux=\lambda x$" followed by "$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle\qquad (x\in V_\lambda,\;y\in V_\mu)$".
- *Exhibit:* at $u=W_{\mathbb{CP}^2}$ padded, take $x=u$ and $y=[\rho A,u]\ne0$ ($A$ outside $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$). Criticality $Q(u)=\theta^*u$ gives $F_uu=\theta^*u$, and Remark 4.16 gives $F_uy=\tfrac12\theta^*y$. Directly, $T(u,y,y)=\langle F_uy,y\rangle=\tfrac12\theta^*|y|^2$. The display in $\theta^*$ units ($\lambda=1$, $\mu=\tfrac12$) gives $(1-\tfrac12)\theta^*|y|^2=\tfrac12\theta^*|y|^2$, which agrees. With literal eigenvalues ($\lambda=\theta^*$, $\mu=\tfrac12\theta^*$) the display gives $\tfrac12\theta^{*2}|y|^2=\tfrac34|y|^2\ne\tfrac12\theta^*|y|^2$.
- *Opposite:* the display is attached to "$x\in V_\lambda$", and the section's $V$ subscripts are in $\theta^*$ units (Passage C). Under that reading the identity is exact, and C2's conclusion is $0$ in either normalisation.

The charitable reading survives, so "the general form is false" is **withdrawn**. What remains is a presentation correction: state the normalisation once and write the chain's middle term as $-2\lambda\theta^*\langle A\cdot x,x\rangle$. CONFIRMED.

## 6. Claims C5 to C7

### C5. "vanishing on the diagonal and reaching $0.91$ off it"

Vanishing on the diagonal ($x=y$, or $\lambda=\mu$) is C4 with $\lambda=\mu$. Confirmed. **Attack item 6.** The value $0.91$ has no argument on file in the passages. It also has no stated normalisation, and the quantity it would bound is homogeneous: $A\mapsto tA$ multiplies $T(x,y,[\rho A,u])$ by $t$, and the same holds for $x$, $y$. The closed-form witness of §5 ($x=u$, $y=[\rho A,u]/|[\rho A,u]|$) gives $\tfrac12\theta^*|[\rho A,u]|$, which is non-zero and unbounded in $|A|$. So "$0.91$" is a well-defined number only after fixing unit $x$, $y$ and a norm on $A$, and then it is a supremum that would need a closed-form maximiser. Three-step record: located (quoted above), exhibited (the scaling), opposite argued (a charitable reading with unit $A$, $x$, $y$ still leaves the value unsupported by any argument). HYPOTHESIS-DEBT. What would have to be proved: the normalisation, the maximising $(A,x,y)$, and the value in closed form.

### C6. "It also gives $P\equiv0$ on $V_{1/2}$"

**This claim has no argument on file.** **Attack item 7.** What would have to be proved, and what it needs:

1. $V_{1/2}\subseteq T_u(SO(n).u)$. Then each $W\in V_{1/2}$ is $[\rho A,u]$ for some $A$, and $P(W)=\langle W,Q(W)\rangle=T(W,W,[\rho A,u])=0$ by C2 with $x=W$.
2. Step 1 is not a consequence of the identity. It needs the eigenspace $V_{1/2}$ of $F_u$ to be exactly case (b) of Theorem 4.14, i.e. the theorem's list to be complete at eigenvalue $\tfrac12\theta^*$, plus Remark 4.16's identification of case (b) with the tangent space. Theorem 4.14 is stated for $n\ge9$.
3. Remark 4.16's inclusion $T_uO\subseteq V_{1/2}$ uses criticality $Q(u)=\theta^*u$. On $T_uO$ itself, $P\equiv0$ follows from C2 plus this inclusion at any critical $u$ in any $n$, and without Theorem 4.14. The extension to all of $V_{1/2}$ is what needs step 2.

Three-step record. *Locate:* "It also gives $P\equiv0$ on $V_{1/2}$." *Exhibit the gap concretely:* the identity alone constrains $T(x,x,[\rho A,u])$, and a vector $W\in V_{1/2}$ orthogonal to $T_uO$ would not be of the form $[\rho A,u]$, so the identity says nothing about $T(W,W,W)$. Such a $W$ is excluded only by the multiplicity statement $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$, which is imported (Passage C, via Theorem 4.14 at $n\ge9$), not derived in L101. *Opposite:* Passage C in the same section asserts $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$ ($26,34,42,50$ at $n=10,\dots,16$, consistent with $\dim\mathcal O=\dim\mathfrak{so}(n)-\dim(\mathfrak u(2)\oplus\mathfrak{so}(n-4))=4n-14$), so a reader of the section can assemble steps 1 to 3. That makes the gap closable with on-file inputs, but the argument is still unwritten, its dependence on criticality contradicts the block's "never uses criticality" framing if read as covering this sentence, and its range $n\ge9$ is unstated. The finding survives as a GAP.

A notational side: with literal eigenvalues, "$V_{1/2}$" would be the $\tfrac12$-eigenspace, which is $\{0\}$ because $\tfrac12\notin\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\sqrt{3/2}$. The $\theta^*$-units reading is the only meaningful one, which again says the block needs one normalisation.

### C7. The heading against the body

**Attack item 8.** The heading names three things: the general form (C4, proven), $Q(x)\perp T_u(SO(n).u)$ "for every eigenvector in every dimension" (C3, proven and true as quantified), and $P\equiv0$ on $V_{1/2}$ (C6, unproven, with an unstated $n\ge9$ and an unstated criticality hypothesis). The heading also carries $\theta^*$, which is specific to the padded $\mathbb{CP}^2$ base point, while "every dimension" is attached to the base-point-free claim. The heading therefore states more than the body proves, by exactly C6. GAP, closed when C6 is.

## 7. C8. The Lean statements

**Attack item 9.** Read at [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean) lines 92-153 and the tail through line 178. The file is imported at [HamiltonsCubic.lean:392](../lean/HamiltonsCubic.lean#L392). No `sorry` appears in any declaration. A grep for the word also surfaced one line of the withheld module docstring (line 60), which I record and did not rely on.

- **Types and binders.** $E$ is an arbitrary real inner product space. `T : E → E → E → ℝ` with no linearity, `D : E → E` with no linearity. `hskew` forces $D$ linear anyway (non-degeneracy), and `T` needs no linearity for these proofs. This is strictly more general than the record.
- **`hsym`** swaps slots 1 and 2 only. It is used, in `e1` (`hsym (D x) y u`). The slot-2/slot-3 symmetry the record uses in C2 and C4 is absorbed into `hx`, `hy`: `∀ z, T x z u = lam * ⟪x, z⟫` is "$F_ux=\ell x$ read through full symmetry". Matches Passage B once $T(x,z,u)=\langle F_ux,z\rangle$ is granted.
- **`hder`** is the three-term identity taken as a hypothesis, with one `D` in all three slots. C1's derivation from $SO(n)$-invariance is not typed.
- **`invariance_identity_general`**, proof followed: `e1` gives $\mu\langle Dx,y\rangle$, `e2` gives $-\lambda\langle Dx,y\rangle$ via `hskew x y`, and `hder x y u` yields $T(x,y,Du)=(\lambda-\mu)\langle Dx,y\rangle$. Direction and sign match C4 in the literal normalisation. Correct.
- **`invariance_identity_record_normalisation`**: `hx` with `lam * ths`, conclusion `(lam - mu) * ths * ⟪D x, y⟫`. Matches C4 in $\theta^*$ units. `ths` is an arbitrary real, not tied to $\sqrt{3/2}$, which is harmless.
- **`invariance_identity_diagonal`** specialises `mu := lam`, `y := x`. Correct. `skew_self_inner_zero` is proved but not used by it, since the Lean route goes through $(\lambda-\lambda)=0$ rather than C2's $\langle A\cdot x,x\rangle=0$. Both are valid.
- **`Q_perp_orbit_tangent`**: `hQ : ∀ z, ⟪Qx, z⟫ = T x x z`, conclusion `⟪Qx, D u⟫ = 0` for the given `D`. Since `D` is universally bound at the call site, instantiating at every $[\rho(A),\cdot]$ gives orthogonality to the whole tangent space. No criticality hypothesis, matching C3.
- **Not typed:** C1's derivation from invariance; that the record's $T$ satisfies `hsym`, `hder` and the full symmetry inside `hx`; that $[\rho(A),\cdot]$ satisfies `hskew`; that $\{[\rho A,u]\}$ is the tangent space; C5's $0.91$; C6's $P\equiv0$ on $V_{1/2}$. The two arithmetic theorems in the tail (`norm_identity_closed_form`, `Qu_norm_exceeds_one`) concern the section's table and no claim of Passage A.

The Lean statements are faithful abstract forms of C2, C3, C4 and are correct as algebra. CONFIRMED AS ALGEBRA.

## 8. The traps, by name

- **$\ker W\ne0$.** No step inverts anything. Tested at $x\in\ker F_u$ in §9. Nothing found.
- **Boundary of every range.** C1 to C4 have no range. C6's range is $n\ge9$ and unstated (finding C6).
- **Proven on a subfamily, stated in general.** Reversed here: C3 is proven in general and stated at one base point, which is harmless. C6 is true (given Theorem 4.14) only at critical $u$ with $n\ge9$, and the block's "no hypothesis, never uses criticality" sits next to it (finding C6).
- **Hypothesis stated but unused, or used but unstated.** The specific $u$ and $\theta^*$ are unused by C1 to C4 (harmless). Criticality and $n\ge9$ are used by C6 and unstated (finding C6).
- **Universal claim with no witness.** C3 and C4 tested at the diagonal $x=u$, at tangent vectors, at kernel vectors, all in closed form (§9). Sphere products and $\mathbb{CP}^m$ as base points: the argument of C1 to C4 is uniform in $u$, so a counterexample at those base points would have to break invariance or full symmetry of $T$, both of which hold for every $u$. Nothing found.
- **Imported theorem whose hypotheses were never checked.** Theorem 4.14 ($n\ge9$, and per the notes a multiplicity-free Schur step) is needed by C6 and cited only in Passage C, not by L101 (finding C6).

## 9. Withdrawn candidates

- **"$A\cdot u=[A,u]$ is ill-typed, so the chain is wrong."** Located in Passage A. Exhibited: $A$ is $n\times n$, $u$ is $\binom n2\times\binom n2$. Opposite: the same sentence names the derivation $X\mapsto[\rho(A),X]$ and the general form writes $[\rho(A),u]$, so the intended object is unambiguous and the chain is correct for it. Withdrawn as a defect, kept as a notational correction.
- **"The general form is off by $\theta^*$."** Withdrawn in §5: correct in the section's $\theta^*$ units, verified at $x=u$, $y=[\rho A,u]$.
- **"C3 fails at kernel vectors of a padded $u$."** Tested: $x\in\ker F_u$ gives $T(x,x,[\rho A,u])=-2\langle F_ux,A\cdot x\rangle=0$. And in C4 with $x\in\ker F_u$ ($\lambda=0$), $y=u$ ($\mu=1$): the display gives $-\theta^*\langle A\cdot x,u\rangle=\theta^*\langle x,[\rho A,u]\rangle$, which is $0$ because $[\rho A,u]\in V_{1/2}\perp V_0$. Directly, $T(x,u,[\rho A,u])=\langle F_ux,[\rho A,u]\rangle=0$. Agreement, no failure. Withdrawn.
- **"C4 fails between two eigenspaces at the base point."** Tested at $x=[\rho B,u]\in V_{1/2}$, $y=u\in V_1$: the display gives $(\tfrac12-1)\theta^*\langle[\rho A,[\rho B,u]],u\rangle=\tfrac12\theta^*\langle[\rho B,u],[\rho A,u]\rangle$ by skewness, and directly $T(x,u,[\rho A,u])=\langle F_ux,[\rho A,u]\rangle=\tfrac12\theta^*\langle[\rho B,u],[\rho A,u]\rangle$. Agreement. Withdrawn.
- **"'Every eigenvector' overreaches to all $x$."** The statement says eigenvector, and §2 shows it is sharp. Withdrawn.

## 10. The falsifying object

- **For C1 to C4:** an element $u\in\mathcal W_n$, $A\in\mathfrak{so}(n)$ and eigenvectors $x,y$ of $F_u$ violating the identity. Such an object would have to break $SO(n)$-invariance or full symmetry of $T$, or Frobenius skewness of $[\rho(A),\cdot]$. I checked each at source (§1) and tested the identity in closed form at the padded $\mathbb{CP}^2$ base point for the pairs (eigenvector, itself), ($u$, tangent), (kernel, $u$), (tangent, $u$). None fails.
- **For C6:** a $W\in V_{1/2}$ at $u=W_{\mathbb{CP}^2}$ padded with $W\perp T_u(SO(n).u)$, $W\neq0$, for which $P(W)\ne0$. It exists only if Theorem 4.14's case list is incomplete at eigenvalue $\tfrac12\sqrt{3/2}$ (for instance through a summand isomorphic to a case (b) summand, where Lemma 4.13's multiplicity-free Schur step would not apply), or at some $n<9$ where no eigenvalue theorem is on file. I read Theorem 4.14 and Remark 4.16 at source and found no such summand named, but checking completeness of Theorem 4.14 is outside L101 and was not done. A closed-form $W$ was not found.

## 11. Overall verdict

**GAP.** The identity, its diagonal case, and $Q(x)\perp T_u(SO(n).u)$ are correct, base-point free, and dimension free (C1 to C4), and the Lean forms are correct algebra (C8). The heading's $P\equiv0$ on $V_{1/2}$ has no argument on file. It is closable in two lines from C2 plus $V_{1/2}=T_uO$, which needs criticality of $u$ and Theorem 4.14 at $n\ge9$, and both should be stated. The value $0.91$ is HYPOTHESIS-DEBT with no normalisation. The block uses $\lambda$ in two normalisations and writes $[A,u]$ for $[\rho(A),u]$.
