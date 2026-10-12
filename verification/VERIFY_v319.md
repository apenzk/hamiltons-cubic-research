# Verifier v319, Lemma L101: the three-term invariance identity, the diagonal chain, Q(x) orthogonal to the orbit tangent space, the general form with θ*, the value 0.91, P ≡ 0 on V_{1/2}, and the Lean statements

Cold brief ([BRIEF_L101.md](BRIEF_L101.md)). No numerical work was done, no scripts were written, no computation was run, and the Lean file was read and not compiled. Every value below is exact. The only sources opened were the passages the brief quotes, [findings/conventions.md](../findings/conventions.md) lines 24, 64 and 136, [findings/route-a.md](../findings/route-a.md) lines 174, 404-408, 423 and 441-449, [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean) from line 92, and [Nienhaus's notes](../references/nienhaus-2023-second-best-einstein/notes.md) with the paper text [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) at Theorem 4.14 (L4365), its proof (L4475-4530), Remark 4.16 (L4657) and Remark 4.12 (L4264). Log: [agent_logs/verify-L101-v319.log](../agent_logs/verify-L101-v319.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $T$ is $SO(n)$-invariant and satisfies $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ | CONFIRMED |
| 2 | The diagonal chain $T(x,x,[\rho(A),u])=-2T(A\cdot x,x,u)=-2\lambda\langle A\cdot x,x\rangle=0$ | CONFIRMED |
| 3 | $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$, in every dimension, without criticality of $u$ | CONFIRMED |
| 4 | The general form $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$ for $x\in V_\lambda$, $y\in V_\mu$ | CONFIRMED (with $\lambda,\mu$ read as the $\theta^*$-normalised labels) |
| 5 | "reaching $0.91$ off it" | HYPOTHESIS-DEBT |
| 6 | "It also gives $P\equiv0$ on $V_{1/2}$" | GAP |
| 7 | Passage E, the Lean statements, against Passages A and B | CONFIRMED AS ALGEBRA |

**What the round should do:** keep the identity and the orthogonality as proven, write the two missing steps for $P\equiv0$ on $V_{1/2}$ with Remark 4.16 and Theorem 4.14 cited and the range stated as $n\ge9$ (plus $n=4$), delete or support the value $0.91$ with its normalisation, and unify the eigenvalue normalisation inside the paragraph.

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors, read as symmetric operators on $\Lambda^2\mathbb R^n$ with the Frobenius inner product. $N=\binom n2$.
- $\rho:SO(n)\to O(\Lambda^2\mathbb R^n)$ is the induced action, and $\rho(A)$ for $A\in\mathfrak{so}(n)$ denotes its differential, a skew operator on $\Lambda^2$. The action on $\mathcal W_n$ is $g\cdot W=\rho(g)W\rho(g)^{-1}$, with infinitesimal form $A\cdot W=[\rho(A),W]$.
- $Q(W)=W^2+W^\#$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))=\tfrac12(XY+YX)+X\#Y$, and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ (Passage B). Then $P(W)=T(W,W,W)$ and $\langle Q(x),z\rangle=T(x,x,z)$.
- $F_u(h)=u\circ h=\tfrac12(uh+hu)+u\#h$, so $\langle F_uh,z\rangle=T(u,h,z)=T(h,z,u)$ by full symmetry.
- **Two normalisations of an eigenvalue occur in the lemma.** "Unnormalised": $F_ux=\lambda x$ (Passage A's diagonal chain). "Label": $x\in V_\lambda$ means $F_ux=\lambda\theta^*x$, as in $V_{1/2}$, $V_{1/3}$ and Passage C's $F_uW_1=\tfrac13\theta^*W_1$. Below, $\lambda$ is unnormalised unless $V_\lambda$ is written.
- $\mathcal O=SO(n).u$, and $T_u\mathcal O=\{[\rho(A),u]:A\in\mathfrak{so}(n)\}$ (the image of the infinitesimal action of a compact group, as Remark 4.16 also writes it).
- $\theta^*=P(u)=\sqrt{3/2}$ for $u=W_{\mathbb{CP}^2}$ padded, unit.

## Hypothesis inventory

| Hypothesis | Where it enters | Checked against the object | Used by the written proof |
|---|---|---|---|
| $T$ trilinear on $\mathcal W_n$ | three-term identity (differentiation) | yes, by definition | yes |
| $T$ is $SO(n)$-invariant | three-term identity | yes: $\rho(g)$ is orthogonal on $\Lambda^2$, so the $\operatorname{tr}(XYZ)$ part is invariant, and $\rho(g)=\mathrm{Ad}_g$ is a Lie algebra automorphism of $\mathfrak{so}(n)\cong\Lambda^2$, so $\#$, built from the structure constants, is equivariant. **Asserted in Passage A without these two lines** | yes |
| $SO(n)$ preserves $\mathcal W_n$ | $A\cdot x\in\mathcal W_n$ so that $T(A\cdot x,\cdot,\cdot)$ is defined | yes (standard) | yes, silently |
| $T$ symmetric in slots 1 and 2 | $T(x,A\cdot x,u)=T(A\cdot x,x,u)$ | yes, Passage B | yes |
| $T$ symmetric in slots 2 and 3, equivalently $F_u$ self-adjoint and $T(h,z,u)=\langle F_uh,z\rangle$ | $T(A\cdot x,x,u)=\lambda\langle A\cdot x,x\rangle$ | yes, Passage B's argument: $\tfrac12\operatorname{tr}(XYZ+YXZ)$ is $S_3$-symmetric for symmetric matrices, and the $\#$ part carries two antisymmetric $c$'s | yes ("$F_u$ is symmetric") |
| $X\mapsto[\rho(A),X]$ is Frobenius-skew | $\langle A\cdot x,x\rangle=0$ | yes: $\langle[\rho A,X],Y\rangle=\operatorname{tr}(\rho A\,XY)-\operatorname{tr}(\rho A\,YX)=-\langle X,[\rho A,Y]\rangle$ | yes |
| $x$ an eigenvector of $F_u$ | diagonal chain | the lemma's quantifier | yes |
| $u$ critical, $Q(u)=\theta^*u$ | nowhere in the orthogonality | Theorem 4.14(a) supplies it for $u=W_{\mathbb{CP}^2}$ | **not used**, correctly, by claims 1-4. **Needed and not stated** by claim 6 |
| $V_{1/2}=T_u\mathcal O$ | claim 6 | Remark 4.16 plus Theorem 4.14, $n\ge9$ | **used and not stated** (claim 6) |
| Theorem 4.14, $n\ge9$, and the Schur step of its proof (Lemma 4.13, valid on multiplicity-free components per the notes, line 60) | Passage C, and the fill of claim 6 | the multiplicity-free hypothesis is not verified at source in the passages I read | not cited by L101 |
| L21 ($n\ge9$, unit norm, $\theta^*=\sqrt{3/2}$) | given in the brief | n/a | **not used** by L101. $\theta^*$ enters only as a normalisation label, never through its value |
| $\ker u\ne0$ (padding) | nowhere | no invertibility of $u$ or $F_u$ is used | n/a |

Findings from the inventory: two used-but-unstated inputs, both in claim 6 (criticality and $V_{1/2}=T_u\mathcal O$). The invariance of $T$ has no written argument, and the fill is the two standard lines in the table. That is recorded as a presentational omission, and claim 1 stays CONFIRMED.

## 1. The three-term identity

**Instruction 2, quantifiers.** For fixed $A\in\mathfrak{so}(n)$ and all $x,y,z\in\mathcal W_n$. No existential.

**Derivation.** $t\mapsto T(e^{tA}\cdot x,e^{tA}\cdot y,e^{tA}\cdot z)$ is constant by invariance. Its derivative at $t=0$, by trilinearity and $\tfrac{d}{dt}\big|_0\rho(e^{tA})X\rho(e^{tA})^{-1}=[\rho(A),X]$, is the three-term sum. The identity uses invariance under simultaneous action on all three slots and trilinearity. **It uses no symmetry of $T$.** "$A\cdot$" is $X\mapsto[\rho(A),X]$ on $\mathcal W_n$ (brief item 1).

**Brief item 2, typing.** "$A\cdot u=[A,u]$" is, read literally, a commutator of an $n\times n$ matrix with an $N\times N$ matrix, which is ill-typed for every $n\ge4$ (where $N>n$). "$[\rho(A),u]$" is well-typed. See withdrawn candidate W1.

Verdict: CONFIRMED.

## 2. The diagonal chain

Equality by equality (brief item 3):

1. $T(x,x,[\rho A,u])=-T(A\cdot x,x,u)-T(x,A\cdot x,u)$: the three-term identity with $y=x$, $z=u$.
2. $=-2T(A\cdot x,x,u)$: symmetry in slots 1 and 2.
3. $T(A\cdot x,x,u)=\langle F_u(A\cdot x),x\rangle=\langle A\cdot x,F_ux\rangle=\lambda\langle A\cdot x,x\rangle$: symmetry in slots 2 and 3 (to reach $F_u$), self-adjointness of $F_u$, and $F_ux=\lambda x$ with $\lambda$ **unnormalised**. Under the label normalisation it reads $\lambda\theta^*\langle A\cdot x,x\rangle$, and the conclusion is the same.
4. $\langle A\cdot x,x\rangle=0$: Frobenius-skewness.

If $F_u$ is read as the $\mathcal W_n$-projection of $u\circ h$, step 3 is unchanged, since $A\cdot x,x\in\mathcal W_n$ and the projection is self-adjoint.

Verdict: CONFIRMED.

## 3. Q(x) orthogonal to the orbit tangent space

**What the argument uses** (brief item 4): $u\in\mathcal W_n$ arbitrary, $x$ an eigenvector of $F_u$, and the inputs of claims 1-2. Then $\langle Q(x),[\rho A,u]\rangle=T(x,x,[\rho A,u])=0$ for every $A$, which is orthogonality to $T_u\mathcal O$. It uses neither criticality of $u$, nor $u=W_{\mathbb{CP}^2}$, nor any $n$. **The conclusion holds more generally than the section's setting: at every $u\in\mathcal W_n$.**

**It is sharp in $x$: it fails for sums of eigenvectors from different eigenspaces.** Candidate record:

- *Locate.* "So $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$". Checking whether "eigenvector" can be weakened.
- *Exhibit, closed form.* Take $u=W_{\mathbb{CP}^2}$ (critical by Theorem 4.14(a)), $A$ with $v:=[\rho A,u]\ne0$ (exists because $\mathcal W_n$, $n\ge4$, has no nonzero $SO(n)$-fixed vector). By Remark 4.16, $F_uv=\tfrac12\theta^*v$. For $x=u+v$: $T(x,x,v)=T(u,u,v)+2T(u,v,v)+T(v,v,v)=\theta^*\langle u,v\rangle+2\langle F_uv,v\rangle+0=\theta^*|v|^2\ne0$, using $\langle u,v\rangle=0$ by skewness and claim 3 for the eigenvector $v$. The general form gives the same: $2(1-\tfrac12)\theta^*\langle A\cdot u,v\rangle=\theta^*|v|^2$.
- *Argue the opposite.* The record says "eigenvector", and this is a sum across eigenspaces, so the record's claim is untouched. This is a scope statement, recorded as confirmation that the hypothesis is needed, and it is not a defect.

**Boundary** (instruction 3): $n\le3$ gives $\mathcal W_n=0$ and a vacuous statement. $n=4$, odd $n$, $n=6+2\sqrt7$ and padded $u$ with $\ker u\ne0$ change nothing, because no step depends on $n$ or on invertibility. Eigenvalue $0$ ($x\in\ker F_u$) is included.

Verdict: CONFIRMED.

## 4. The general form

**Derivation from claim 1** (brief item 5). With $F_ux=\lambda x$, $F_uy=\mu y$ unnormalised, $z=u$:
$T(x,y,[\rho A,u])=-T(A\cdot x,y,u)-T(x,A\cdot y,u)=-\langle A\cdot x,F_uy\rangle-\langle F_ux,A\cdot y\rangle=-\mu\langle A\cdot x,y\rangle-\lambda\langle x,A\cdot y\rangle=(\lambda-\mu)\langle A\cdot x,y\rangle$.
Under the labels $x\in V_\lambda$, $y\in V_\mu$ ($F_u=\lambda\theta^*$ on $V_\lambda$) this is $(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$, which is Passage A's display.

**Normalisation.** The display writes $x\in V_\lambda$, which in the section is the label convention (Passage C: $V_{1/3}$ with $F_uW_1=\tfrac13\theta^*W_1$). Two sentences earlier the same letter is unnormalised ("$F_ux=\lambda x$"). Candidate record:

- *Locate.* "since $F_u$ is symmetric with $F_ux=\lambda x$" followed by "$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle\qquad (x\in V_\lambda,\;y\in V_\mu)$".
- *Exhibit, closed form.* $x=v=[\rho A,u]$, $y=u$, with $u=W_{\mathbb{CP}^2}$. Left side: $T(v,u,v)=\langle F_uv,v\rangle=\tfrac12\theta^*|v|^2$. Label reading: $(\tfrac12-1)\theta^*\langle A\cdot v,u\rangle=-\tfrac12\theta^*(-\langle v,A\cdot u\rangle)=\tfrac12\theta^*|v|^2$, which agrees. Unnormalised reading ($\lambda=\tfrac12\theta^*$, $\mu=\theta^*$): $(-\tfrac12\theta^*)\theta^*(-|v|^2)=\tfrac34|v|^2$, against $\tfrac12\theta^*|v|^2=\tfrac{\sqrt6}4|v|^2$. These differ, since $3\ne\sqrt6$.
- *Argue the opposite.* The display explicitly writes $x\in V_\lambda$, and $V_\lambda$ is the label convention throughout the section. On the diagonal the normalisation is irrelevant. The charitable reading is fully consistent, so the candidate is withdrawn as a defect (W2) and kept as an editorial request: write $F_ux=\lambda\theta^*x$ in the chain.

**$\lambda=\mu$, $x\ne y$** (brief item 10): the form gives $T(x,y,[\rho A,u])=0$. This is consistent with polarising claim 2 over the eigenvector $x+y\in V_\lambda$.

Verdict: CONFIRMED, with $\lambda,\mu$ the $\theta^*$-normalised labels.

## 5. "Reaching 0.91 off it"

- *Locate.* "vanishing on the diagonal and reaching $0.91$ off it."
- **No argument on file.** Passage A offers no derivation, no witness $(A,x,y)$, and no normalisation. Brief item 6: nothing in the quoted record supports the value.
- **As stated the quantity is not determined.** The left side is linear in $A$, $x$ and $y$ separately. With the witness of section 4 ($x=[\rho A_0,u]$ fixed, $y=u$) and $A=tA_0$, the value is $t\cdot\tfrac12\theta^*|[\rho A_0,u]|^2$, unbounded in $t$. A value is "reached" only after $A$, $x$, $y$ are normalised, and the norm on $\mathfrak{so}(n)$ is unstated (the matrix Frobenius norm and the $\Lambda^2$ norm differ by a factor $\sqrt2$).
- *Argue the opposite.* The most charitable reading is $\sup|T(x,y,[\rho A,u])|$ over unit $x\in V_\lambda$, $y\in V_\mu$, $\lambda\ne\mu$, and unit $A$ in some fixed norm. That supremum is finite, but it has no closed-form value on file, so the reading still leaves a claim supported, if at all, only by a run.

What would have to be proved: fix the norm on $A$, then compute $\max_{\lambda\ne\mu}|\lambda-\mu|\theta^*\max\langle A\cdot x,y\rangle$ over unit vectors, in closed form, at a stated $n$. The value $0.91$ plays no role in any other claim of L101.

Verdict: HYPOTHESIS-DEBT.

## 6. P ≡ 0 on V_{1/2}

**The written proof is the sentence "It also gives $P\equiv0$ on $V_{1/2}$."** The identity controls $T(x,x,z)$ only for $z\in T_u\mathcal O$, while $P(x)=T(x,x,x)$ needs $x$ itself in $T_u\mathcal O$. Two steps are missing (brief item 7):

- **(i) $T_u\mathcal O\subseteq V_{1/2}$.** This needs criticality: differentiate $Q(e^{tA}\cdot u)=e^{tA}\cdot Q(u)=\theta^*e^{tA}\cdot u$ to get $2F_u[\rho A,u]=\theta^*[\rho A,u]$. This is Remark 4.16 (L4657), and it holds at every $n$ for any critical $u$. **It uses the criticality of $u$ that the paragraph says the argument never uses.** That remark is true of claim 3 and false of claim 6.
- **(ii) $V_{1/2}\subseteq T_u\mathcal O$.** From Theorem 4.14 (L4365), stated for $n\ge9$: case (b) lists $\mathrm{Weyl}^{-,1}_4\oplus X^{-,2}_4\otimes\mathbb R^{n-4}$, and no other case has eigenvalue $\tfrac12\sqrt{3/2}$. Remark 4.16 identifies exactly that space with $T_u\mathcal O$ "by dimension comparison". Theorem 4.14's exhaustiveness rests on its Schur step (Lemma 4.13), which the notes (line 60) record as valid only on multiplicity-free components. The passages I read do not verify multiplicity-freeness.

Given (i) and (ii): for $x\in V_{1/2}$, $x=[\rho A,u]$ for some $A$, and $P(x)=T(x,x,[\rho A,u])=0$ by claim 2.

**The range** (instruction 3, brief item 7):

- $n\ge9$: fillable by citing Remark 4.16 and Theorem 4.14, conditional on the latter's Schur step.
- $n=4$, closed form. $u=W_{\mathbb{CP}^2}\in\mathcal W^-_4\cong\mathrm{Sym}_0(\mathbb R^3)$, $u=\operatorname{diag}(2,-1,-1)/\sqrt6$. On $\mathfrak{so}(3)$ the $\#$ product is a multiple of the polarised cofactor. Fixing the multiple by $Q(u)=\sqrt{3/2}\,u$ gives $Q(W)=3W^2-\operatorname{tr}(W^2)I$ on traceless $W$, and $X\circ Y=\tfrac32(XY+YX)-\operatorname{tr}(XY)I$. Then $F_u$ has eigenvalue $\tfrac12\theta^*$ on $E_{12},E_{13}$ ($\tfrac32\cdot\tfrac1{\sqrt6}=\tfrac12\cdot\tfrac3{\sqrt6}$), $-\theta^*$ on $E_{23}$ and on $\operatorname{diag}(0,1,-1)$, $\theta^*$ on $u$, and $0$ on $\mathcal W^+_4$ (the blocks multiply to zero and $[\Lambda^+,\Lambda^-]=0$). So $V_{1/2}=\operatorname{span}(E_{12},E_{13})=T_u\mathcal O$, of dimension $2=4n-14$. Directly, $P(aE_{12}+bE_{13})=3\operatorname{tr}(h^3)=0$, since $h_{23}=0$ and the diagonal vanishes. The claim holds at $n=4$.
- $5\le n\le8$: Theorem 4.14 is stated for $n\ge9$ only. Remark 4.12 gives the decompositions for $n=5,\dots,8$ (at $n=8$ with extra summands such as $\mathrm{Weyl}^+_4$ on the second factor and $\Lambda^2_{-,1}(\mathbb R^4)\otimes\Lambda^2_\pm(\mathbb R^4)$) but no eigenvalues. Step (ii) has no argument on file there. I exhibited no failure.

Candidate record:

- *Locate.* "It also gives $P\equiv0$ on $V_{1/2}$", and the heading's "and $P\equiv0$ on $V_{1/2}$" with no range.
- *Exhibit.* No closed-form object with $P\ne0$ on $V_{1/2}$ was found. The finding is the absence of an argument for (i) and (ii), and the unstated range.
- *Argue the opposite.* The section's standing setting is L21's $n\ge9$, where Remark 4.16 and Theorem 4.14 supply both steps. On that reading the claim is true modulo Theorem 4.14's Schur step, but L101 cites neither source, and its heading inherits "in every dimension" by proximity. The finding stands as a GAP. It is not a refutation.

Verdict: GAP. Fix: state $n\ge9$ (and $n=4$), write steps (i) and (ii) with Remark 4.16 and Theorem 4.14 cited, and delete "the argument never uses criticality of $u$" from anything that covers this claim.

## 7. The Lean statements against the record

Brief item 9, instruction 5.

- **Binders.** $T$, $D$, $u$, $x$, $y$, `lam`, `mu`, `ths` are all implicit, universally quantified, and free: nothing ties $T$ to $\langle X\circ Y,Z\rangle$ on $\mathcal W_n$, $D$ to $[\rho(A),\cdot]$, or $E$ to $\mathcal W_n$. $E$ is any real inner product space, so the statements are dimension-free, which is stronger than "every dimension".
- **Hypotheses.** `hder` *assumes* the three-term identity (claim 1 is not typed). `hskew` assumes Frobenius-skewness. `hsym` assumes symmetry in slots 1 and 2 only, and that suffices because `hx`/`hy` put the eigen-relation in the form `T x z u = lam * ⟪x, z⟫`. That form silently absorbs slot 2-3 symmetry and the definition of $F_u$ (the docstring's "read here through `T · · u = ⟪F_u ·, ·⟫`"). $F_u$ does not appear. All hypotheses are jointly satisfiable ($T=0$, $D=0$), and the real object satisfies them, so nothing is vacuous.
- **Normalisation.** `invariance_identity_general` uses unnormalised `lam` (Passage A's chain). `invariance_identity_record_normalisation` puts `lam * ths` in `hx` and gives $(\lambda-\mu)\,\mathrm{ths}\,\langle Dx,y\rangle$, which is Passage A's display under the label convention of section 4, with `ths` a free real rather than $P(u)$. Direction and types match.
- **Q orthogonality.** `Q_perp_orbit_tangent` concludes $\langle Q_x,Du\rangle=0$ for each admissible $D$. Orthogonality to $T_u\mathcal O$ follows once every $[\rho(A),\cdot]$ satisfies `hder` and `hskew` and $T_u\mathcal O=\{[\rho A,u]\}$, and both of those are untyped.
- `skew_self_inner_zero` is Passage A's last step. The diagonal theorem does not use it and reaches $0$ through $\lambda-\lambda=0$, which is a valid alternative.
- **Untyped claims of Passage A:** the $SO(n)$-invariance of $T$ and the derivation of `hder` from it, the full symmetry of $T$, the skewness of $[\rho(A),\cdot]$, $T_u\mathcal O$ as the image of the infinitesimal action, the value $0.91$, and $P\equiv0$ on $V_{1/2}$.
- The file also carries `norm_identity_closed_form` and `Qu_norm_exceeds_one` (lines 155-171), which concern $\|Q(u)\|=\theta^*$ and a $\tfrac16$ share. Neither is a claim of Passage A.

Verdict: CONFIRMED AS ALGEBRA.

## Heading against body

Brief item 8.

- The heading's "$Q(x)\perp T_u(SO(n).u)$ for every eigenvector in every dimension" is what the body proves (claim 3), and the body proves it more generally, at every $u$.
- The heading's "$P\equiv0$ on $V_{1/2}$" has no argument and no range (claim 6).
- The heading writes $[\rho(A),u]$ while the body also writes $[A,u]$ (W1). The heading omits "of $F_u$".

## Brief item 10 and instruction 7, the traps by name

- **$\ker W\ne0$.** The padded $u$ has a large kernel. No step inverts $u$ or $F_u$, and $\ker F_u$ eigenvectors are covered. Nothing found.
- **The boundary of every range.** Claims 1-4 have no range. $n\le3$ is vacuous. $n=4$ was checked in closed form for claim 6. $5\le n\le8$ is a gap for claim 6. $n=6+2\sqrt7$ and odd $n$ enter nowhere.
- **Proven on a subfamily, stated in general.** Claim 6 is supportable at $n\ge9$ and $n=4$ and stated without range. Claim 3 is the reverse: proven for all $u$ and stated for the section's $u$.
- **Hypothesis stated but unused.** L21's hypotheses and the value of $\theta^*$ are unused, harmlessly.
- **Hypothesis used but unstated.** Criticality and $V_{1/2}=T_u\mathcal O$ in claim 6. The invariance of $T$ in claim 1 is asserted without its two-line argument.
- **A universal claim with no witness.** I tried: a diagonal-type witness ($x=u+[\rho A,u]$, section 3, confirming sharpness), a padded object (no step sensitive to padding), $\mathbb{CP}^m$ via $m=2$ at $n=4$ (section 6), and sphere products ($T_{W_{S^4\times S^{n-4}}}$ lies in $\ker F_u$ by Theorem 4.14(d), eigenvalue $0$, covered by claim 3). None breaks claims 1-4.
- **An imported theorem whose hypotheses were never checked.** L101 imports nothing explicitly. The fill of claim 6 imports Theorem 4.14, whose Schur step needs multiplicity-free isotypic components, unverified in what I read.

## Withdrawn candidates

- **W1, "$A\cdot u=[A,u]$" is ill-typed.** *Located* at "using $A\!\cdot\!u=[A,u]$". *Exhibited:* $A$ is $n\times n$ and $u$ is $\binom n2\times\binom n2$, so the literal commutator is undefined for $n\ge4$. *Opposite:* the same paragraph writes $[\rho(A),u]$, and Nienhaus writes $[\mathrm{ad}_v,W]$. The abbreviation is unambiguous, so the candidate is withdrawn as a mathematical defect. Editorial request: write $[\rho(A),u]$ throughout.
- **W2, the general form is off by $\theta^*$.** Withdrawn in section 4: correct under the section's label convention for $V_\lambda$, and wrong only if "$F_ux=\lambda x$" is carried into it. Editorial request: write $F_ux=\lambda\theta^*x$ in the chain.

## The falsifying object, and the search for it

- **Claims 1-4:** a $u\in\mathcal W_n$, an eigenvector $x$ of $F_u$ and an $A$ with $\langle Q(x),[\rho A,u]\rangle\ne0$. None can exist, because the derivation is complete and uses only invariance, symmetry and skewness. What I did: followed each step's algebra, checked both normalisations against the closed-form pair $(x,y)=([\rho A,u],u)$, and checked that weakening "eigenvector" to a sum does fail.
- **Claim 6:** some $n$ with $x\in V_{1/2}\setminus T_u\mathcal O$ and $P(x)\ne0$. It must lie at $5\le n\le8$, or at $n\ge9$ if Theorem 4.14's list is not exhaustive through a multiplicity. What I did: read Theorem 4.14, its proof of (b), Remark 4.16 and Remark 4.12 at source, and computed $n=4$ in closed form, where $V_{1/2}=T_u\mathcal O$. I did not attempt $5\le n\le8$, which would need the spectrum of $F_u$ on Remark 4.12's summands and is a derivation the lemma owes.
- **Claim 5:** a normalisation under which the supremum differs from $0.91$. It cannot be settled without the normalisation, which is absent.

## Overall verdict

**GAP.**

- The identity, its general form, and the orthogonality $Q(x)\perp T_u(SO(n).u)$ for every eigenvector at every $u$ and every $n$ are proven, and the Lean file checks their algebra.
- "$P\equiv0$ on $V_{1/2}$" has no argument on file. It needs criticality of $u$ and $V_{1/2}=T_u\mathcal O$ (Remark 4.16 with Theorem 4.14, $n\ge9$), and it is unsupported at $5\le n\le8$.
- The value $0.91$ is HYPOTHESIS-DEBT and ill-posed without a normalisation.
