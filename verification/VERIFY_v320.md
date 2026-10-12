# Verifier v320, Lemma L101: the three-term invariance identity, the diagonal chain, Q(x) orthogonal to the orbit tangent, the general form with its normalisation, the value 0.91, P vanishing on V_{1/2}, and the Lean statements

Cold brief ([BRIEF_L101.md](BRIEF_L101.md)). No numerical work was done and no scripts were written. Every value below is exact. The Lean file was read, not built. Sources opened: the brief, [findings/route-a.md](../findings/route-a.md) lines 174, 404, 406, 408, 423 and 441-449, [findings/conventions.md](../findings/conventions.md) lines 24, 64 and 136, [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean) lines 90-153, and [Nienhaus's notes](../references/nienhaus-2023-second-best-einstein/notes.md) with the paper text at L4115-4150, L4212-4251, L4330-4348, L4365-4410 and L4652-4676. Log: [agent_logs/verify-L101-v320.log](../agent_logs/verify-L101-v320.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | $T$ is $SO(n)$-invariant, so $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ | CONFIRMED |
| C2 | The diagonal chain $T(x,x,[A,u])=-2T(A\cdot x,x,u)=-2\lambda\langle A\cdot x,x\rangle=0$ | CONFIRMED (with $[A,u]$ read as $[\rho(A),u]$) |
| C3 | $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$, in every dimension, with no hypothesis, criticality unused | CONFIRMED |
| C4 | $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$ for $x\in V_\lambda$, $y\in V_\mu$ | CONFIRMED (with $\lambda,\mu$ the labels, $F_ux=\lambda\theta^*x$) |
| C5 | "vanishing on the diagonal and reaching $0.91$ off it" | HYPOTHESIS-DEBT |
| C6 | "It also gives $P\equiv0$ on $V_{1/2}$" | GAP |
| C7 | Passage E, the four Lean theorems, against Passages A and B | CONFIRMED AS ALGEBRA |

**What the round should do:** write the three-line argument for $P\equiv0$ on $V_{1/2}$ with its hypotheses ($n\ge9$, $u=W_{\mathbb{CP}^2}$, $V_{1/2}=T_u(SO(n).u)$ from Nienhaus Theorem 4.14(b) and Remark 4.16), withdraw or source the value $0.91$ with its normalisation, and fix the two notational slips ($[A,u]$, and $\lambda$ used in two normalisations).

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\binom n2$, with $\langle X,Y\rangle=\operatorname{tr}(XY)$. It is nonzero exactly for $n\ge4$.
- $\mathcal S$ denotes all symmetric operators on $\Lambda^2\mathbb R^n$, and $\pi:\mathcal S\to\mathcal W_n$ the orthogonal projection. $Q(X)=X^2+X^\#$ takes values in $\mathcal S$, and in general $Q(X)\notin\mathcal W_n$. Every pairing with an element of $\mathcal W_n$ below is unchanged by inserting $\pi$.
- $X\circ Y=\tfrac12(XY+YX)+X\#Y$, the polarisation of $Q$ (Passage B), and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, fully symmetric on $\mathcal W_n$ (Passage B, line 24).
- $F_u=\pi(u\circ\cdot)$ restricted to $\mathcal W_n$. This is the self-adjoint operator on $\mathcal W_n$ whose eigenvectors the lemma speaks of, and it is Nienhaus's $F:\mathrm{Weyl}_n\to\mathrm{Weyl}_n$ (paper L4339). With full symmetry, $T(p,q,u)=T(u,q,p)=\langle F_uq,p\rangle$ for $p,q\in\mathcal W_n$.
- $g\in SO(n)$ acts by $g\cdot X=\rho(g)X\rho(g)^{-1}$ with $\rho(g)=\mathrm{Ad}_g$ orthogonal on $\Lambda^2$. For $A\in\mathfrak{so}(n)$ the derived action is $A\cdot X=[\rho(A),X]$ with $\rho(A)=\mathrm{ad}_A$, an $N\times N$ skew matrix.
- $\theta^*=P(u)=\sqrt{3/2}$ for $u=W_{\mathbb{CP}^2}$ padded, of unit norm (Passage D).
- **Normalisation of eigenvalue letters.** "Raw": $F_ux=\lambda x$. "Label": $x\in V_\lambda$ means $F_ux=\lambda\theta^*x$, the convention of Passage C ($F_uW_1=\tfrac13\theta^*W_1$, $W_1\in V_{1/3}$) and of Nienhaus Theorem 4.14 (eigenvalues $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\sqrt{3/2}$).

## 1. Hypothesis inventory

**Hypotheses the statement carries.** The body says "with no hypothesis". Implicitly it carries: $u\in\mathcal W_n$ (the padded $\mathbb{CP}^2$ operator in the surrounding section), $x$ an eigenvector of $F_u$ (C2, C3), $x\in V_\lambda$, $y\in V_\mu$ (C4), and for C6 the eigenspace $V_{1/2}$ of the padded $\mathbb{CP}^2$ operator.

**Facts the proof imports, each checked against its object.**

| Import | Where used | Holds for the object? | Used by the written proof? |
|---|---|---|---|
| (I1) $Q(g\cdot X)=g\cdot Q(X)$ for $g\in SO(n)$, hence $T$ invariant | C1 | Yes. $(\rho X\rho^{-1})^2=\rho X^2\rho^{-1}$, and $\#$ is built from the structure constants of $\mathfrak{so}(n)$, which $\mathrm{Ad}_g$ preserves. Nienhaus uses exactly this at (4.6), L4339-4345. Asserted in the passage without argument | Yes |
| (I2) $\mathcal W_n$ is $SO(n)$-invariant | C2, C4: $A\cdot x\in\mathcal W_n$ so that $T(A\cdot x,y,u)=\langle A\cdot x,F_uy\rangle$ | Yes, standard | Yes, silently |
| (I3) $X\mapsto[\rho(A),X]$ is Frobenius-skew | C2, C4 | Yes: $\langle[S,X],Y\rangle=\operatorname{tr}(SXY)-\operatorname{tr}(XSY)=-\langle X,[S,Y]\rangle$ by cyclicity, and $[S,X]$ is symmetric because $S$ is skew | Yes, stated |
| (I4) Full symmetry of $T$ on $\mathcal W_n$ | C2 (slots 1-2 and moving $u$), C4 | Yes (Passage B) | Yes, stated as "$F_u$ is symmetric" |
| (I5) $T_u(SO(n).u)=\{[\rho(A),u]:A\in\mathfrak{so}(n)\}$ | C3, C6 | Yes, the orbit map's differential. Nienhaus Remark 4.16, L4670-4672 | Yes, silently |
| (I6) $V_{1/2}=T_u(SO(n).u)$ | C6 | Yes at $n\ge9$: Theorem 4.14(b) gives $V_{1/2}=\mathrm{Weyl}^{-,1}_4\oplus X^{-,2}_4\otimes\mathbb R^{n-4}$, of dimension $2+4(n-4)=4n-14$ (L4138, L4222), Remark 4.16 gives the inclusion $T_u(SO(n).u)\subseteq V_{1/2}$ and the equality "by dimension comparison" (L4674-4675) | **No. Nothing is written** |
| (I7) Criticality, $\pi Q(u)=\theta^*u$ | C6 through (I6), and the label $\tfrac12$ itself | Yes (Theorem 4.14(a)) | Not in C2-C4 (correctly). Needed for C6 and not stated |

**Findings from the inventory.** (I6) and (I7) are used by C6 and stated nowhere in the lemma (Section 7). No stated hypothesis is unused: the body states none beyond the eigen-relations, and those are used.

## 2. C1, the three-term identity (What to attack 1)

**Derivation.** By (I1), $T(g\cdot X,g\cdot Y,g\cdot Z)=\langle g\cdot(X\circ Y),g\cdot Z\rangle=\langle X\circ Y,Z\rangle$, using that $X\mapsto g\cdot X$ is Frobenius-orthogonal. Put $g=\exp(tA)$ and differentiate at $t=0$. Since $\frac{d}{dt}\big|_0\rho(e^{tA})X\rho(e^{tA})^{-1}=[\rho(A),X]$ and $T$ is trilinear, the product rule gives $T(A\cdot X,Y,Z)+T(X,A\cdot Y,Z)+T(X,Y,A\cdot Z)=0$ with $A\cdot=[\rho(A),\cdot]$.

- **Which invariance:** $SO(n)$-invariance of $T$, equivalent to (I1). Full $O(n)$ is not needed.
- **Which action:** conjugation by $\mathrm{Ad}$ on $\Lambda^2$, derived to $[\rho(A),\cdot]$.
- **Which symmetries of $T$:** none. The identity holds for any invariant trilinear form.
- **Record gap:** the passage asserts invariance with no argument. The argument is one line and standard, so this is noted and not scored.

Verdict CONFIRMED.

## 3. C2, the diagonal chain (What to attack 2, 3)

**Typing of "$A\cdot u=[A,u]$" against "$[\rho(A),u]$".** With $A\in\mathfrak{so}(n)$ an $n\times n$ matrix and $u$ an $N\times N$ matrix, $[A,u]$ is not defined for $n\ge4$ ($N=n(n-1)/2\ne n$). Reading $A$ as a vector of $\Lambda^2$ does not help, since a vector does not bracket with an operator. $[\rho(A),u]$ is well typed and is what the derivative in Section 2 produces.

**The chain, equality by equality.**

1. $T(x,x,A\cdot u)=-T(A\cdot x,x,u)-T(x,A\cdot x,u)$: C1 with $y=x$, $z=u$. No symmetry.
2. $=-2T(A\cdot x,x,u)$: symmetry of $T$ in slots 1 and 2.
3. $T(A\cdot x,x,u)=\langle A\cdot x,F_ux\rangle$: full symmetry, moving $u$ out of slot 3 (convention in Section 0), with $A\cdot x\in\mathcal W_n$ by (I2).
4. $=\lambda\langle A\cdot x,x\rangle$ in the raw normalisation $F_ux=\lambda x$, which is what the line writes. In the label normalisation it would be $\lambda\theta^*\langle A\cdot x,x\rangle$. Either way the next step kills it.
5. $\langle A\cdot x,x\rangle=0$ by (I3) with $X=Y=x$.

Every step follows. **Candidate F1**, "$[A,u]$ is ill-typed". Located: "using $A\!\cdot\!u=[A,u]$" and "$T(x,x,[A,u])$" (route-a.md lines 441 and 443). Exhibited: $[A,u]$ pairs an $n\times n$ with an $N\times N$ matrix, $N\ne n$ for $n\ge4$. Opposite: the same passage writes $[\rho(A),u]$ three lines later, so $[A,u]$ is an abbreviation with an unambiguous intended meaning. The candidate survives as a **notational correction only**, with no mathematical consequence: replace $[A,u]$ by $[\rho(A),u]$ in both places.

Verdict CONFIRMED.

## 4. C3, Q(x) orthogonal to the orbit tangent (What to attack 4, 8)

**Derivation.** For $z=A\cdot u\in T_u(SO(n).u)$ (I5), $\langle Q(x),A\cdot u\rangle=\langle x\circ x,A\cdot u\rangle=T(x,x,A\cdot u)=0$ by C2. As $A$ ranges over $\mathfrak{so}(n)$ this is all of the tangent space.

**What the argument uses:** $u\in\mathcal W_n$ arbitrary, $x$ an eigenvector of $F_u$ on $\mathcal W_n$, (I1)-(I5). It uses no criticality of $u$, no normalisation of $u$, no invertibility, no parity or size of $n$, and nothing specific to $\mathbb{CP}^2$.

**More or less general than stated.**

- **More general in $u$:** it holds at every base point $u\in\mathcal W_n$, which the phrase "the argument never uses criticality" already implies.
- **More general in $x$:** every element of one eigenspace $V_\lambda$ qualifies, since each is an eigenvector. By C4 with $\lambda=\mu$ the polarised form $T(x,y,A\cdot u)$ also vanishes for $x\ne y$ in the same $V_\lambda$.
- **Exactly as general as stated across eigenspaces:** for $x\in V_\lambda$, $y\in V_\mu$, $\lambda\ne\mu$, $\langle Q(x+y),A\cdot u\rangle=2T(x,y,A\cdot u)=2(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$, which C4 shows need not vanish. So "every eigenvector" is the right scope, and "every element of $\mathcal W_n$" would be false.
- **"Every dimension":** holds for all $n\ge4$, and is vacuous for $n\le3$ where $\mathcal W_n=0$.

**Heading against body (item 8).** The heading attaches "for every eigenvector in every dimension" to $Q(x)\perp T_u(SO(n).u)$, which is what the body proves. The heading also lists "$P\equiv0$ on $V_{1/2}$" with no range, while that claim holds only under (I6), (I7). The heading therefore reads as if the second claim shared the first's generality. This is folded into C6.

Verdict CONFIRMED.

## 5. C4, the general form and its normalisation (What to attack 5, 10)

**Derivation from C1.** Take $z=u$, $x\in V_\lambda$, $y\in V_\mu$ with $F_ux=\ell_xx$, $F_uy=\ell_yy$ for the raw eigenvalues $\ell_x,\ell_y$.

- $T(A\cdot x,y,u)=\langle A\cdot x,F_uy\rangle=\ell_y\langle A\cdot x,y\rangle$ (full symmetry, (I2)).
- $T(x,A\cdot y,u)=\langle F_ux,A\cdot y\rangle=\ell_x\langle x,A\cdot y\rangle=-\ell_x\langle A\cdot x,y\rangle$ ((I3)).
- Hence $T(x,y,A\cdot u)=(\ell_x-\ell_y)\langle A\cdot x,y\rangle$.

With labels, $\ell_x=\lambda\theta^*$, $\ell_y=\mu\theta^*$, this is exactly $(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$. The formula is correct in the label normalisation that its own binder "$x\in V_\lambda$" and Passage C use.

**Candidate F2**, "the general form is off by $\theta^*$". Located: line 445 fixes "$F_ux=\lambda x$" (raw), and line 447 writes "$(\lambda-\mu)\,\theta^*$". Exhibited in closed form: take $x=u$ and $y=A\cdot u\ne0$, for instance $A=e_1\wedge e_5$ at $n\ge9$, which moves the $\mathbb R^4$ block of the padded operator. By Theorem 4.14(a) and Remark 4.16, $F_uu=\theta^*u$ and $F_u(A\cdot u)=\tfrac12\theta^*A\cdot u$. Directly, $T(u,A\cdot u,A\cdot u)=\langle F_u(A\cdot u),A\cdot u\rangle=\tfrac12\theta^*|A\cdot u|^2$. The raw reading of line 447 gives $(\theta^*-\tfrac12\theta^*)\theta^*|A\cdot u|^2=\tfrac34|A\cdot u|^2$, and the label reading gives $(1-\tfrac12)\theta^*|A\cdot u|^2=\tfrac12\sqrt{3/2}\,|A\cdot u|^2$, which matches. Opposite: line 447 carries its own binder $x\in V_\lambda$, $y\in V_\mu$, and the section's $V$ subscripts are labels, while the raw $\lambda$ of line 445 only ever multiplies a zero. Both lines are correct in their own normalisation. The candidate is **withdrawn as a mathematical defect** and kept as a **notational correction**: one letter carries two normalisations in adjacent lines. Write $F_ux=\lambda\theta^*x$ on line 445, or drop $\theta^*$ and read $V_\lambda$ as raw.

**Boundary (item 10).**

- **$\ker u\ne0$ (padded $u$):** nothing inverts $u$ or uses its rank. The identity is unaffected.
- **Smallest admissible dimension and odd $n$:** no $n$-dependent quantity enters C1-C4. Valid for every $n\ge4$, odd or even. $\theta^*=\sqrt{3/2}$ enters only through the labels, which Theorem 4.14 fixes for $n\ge9$.
- **The crossover $n=6+2\sqrt7$:** no quantity in C1-C4 changes there. Not relevant.
- **$\lambda=\mu$, $x\ne y$:** $T(x,y,A\cdot u)=0$. Consistent with polarising C2 inside one eigenspace.
- **$A$ in the stabiliser, $A\cdot u=0$:** the left side is $0$, so the identity forces $(\lambda-\mu)\langle A\cdot x,y\rangle=0$. This is true independently: by equivariance of $F_u$ under the stabiliser (paper (4.6)), $A\cdot x\in V_\lambda\perp V_\mu$ when $\lambda\ne\mu$. No contradiction.

Verdict CONFIRMED.

## 6. C5, "reaching 0.91 off it" (What to attack 6)

**Candidate F3**, "the value $0.91$ has no argument on file and is not well posed". Located: "vanishing on the diagonal and reaching $0.91$ off it" (line 449). Exhibited: the left side $T(x,y,[\rho(A),u])$ is linear in $A$, so replacing $A$ by $cA$ multiplies it by $c$. Without a stated normalisation of $A$ (and of $x,y$, and a choice of $n$, $\lambda$, $\mu$), the supremum is $+\infty$ and "$0.91$" names no quantity. Even with a normalisation fixed, no closed form or bound is written. Opposite: the most charitable reading is a maximum over unit $x\in V_\lambda$, unit $y\in V_\mu$ and unit $A$ in some norm, at some $n$, obtained by a run. Under that reading the value is a numerical observation with no argument on file, which the brief classes as HYPOTHESIS-DEBT. The candidate stands.

What would have to be written: the normalisation of $x,y,A$, the dimension, the pair $(\lambda,\mu)$, and a closed-form maximisation of $(\lambda-\mu)\theta^*\langle[\rho(A),x],y\rangle$ over those unit spheres. The value carries no weight elsewhere in the lemma, so withdrawing it costs nothing.

Verdict HYPOTHESIS-DEBT.

## 7. C6, P vanishes on V_{1/2} (What to attack 7)

**Candidate F4**, "$P\equiv0$ on $V_{1/2}$ has no argument on file, and the argument that closes needs hypotheses the lemma disclaims". Located: "It also gives $P\equiv0$ on $V_{1/2}$" (line 449), and the heading's "and $P\equiv0$ on $V_{1/2}$", beside "in every dimension" and "with no hypothesis".

**What the identity alone gives.** C2 gives $T(x,x,z)=0$ for $x\in V_{1/2}$ and $z\in T_u(SO(n).u)$. Since $P(x)=T(x,x,x)$, it gives $P(x)=0$ exactly when $x$ itself lies in $T_u(SO(n).u)$. For $x\in V_{1/2}\cap T_u(SO(n).u)^\perp$ the identity says nothing about $T(x,x,x)$. So "$P\equiv0$ on $V_{1/2}$" follows from C2 **if and only if one also has $V_{1/2}\subseteq T_u(SO(n).u)$**, and this inclusion is nowhere in the lemma.

**The argument that closes, from sources on file.**

1. (I7) $\pi Q(u)=\theta^*u$ (Theorem 4.14(a)). Differentiating $\pi Q(g\cdot u)=g\cdot\pi Q(u)$ along $\exp(tA)$ gives $2F_u(A\cdot u)=\theta^*A\cdot u$, so $T_u(SO(n).u)\subseteq V_{1/2}$ (Remark 4.16, L4657-4668).
2. (I6) For $n\ge9$, Theorem 4.14(b) identifies $V_{1/2}=\mathrm{Weyl}^{-,1}_4\oplus X^{-,2}_4\otimes\mathbb R^{n-4}$, of dimension $2+4(n-4)=4n-14$, and Remark 4.16 (L4674-4675) states the equality with the tangent space "by dimension comparison". The orbit dimension $\binom n2-\dim U(2)-\binom{n-4}2=4n-14$ agrees with Passage C's $26,34,42,50$ at $n=10,12,14,16$.
3. For $x\in V_{1/2}$ write $x=A\cdot u$. Then $P(x)=T(x,x,x)=T(x,x,A\cdot u)=0$ by C2.

So the claim is true for $u=W_{\mathbb{CP}^2}$ padded at every $n\ge9$, odd included. It uses criticality of $u$ and the spectral theorem for $F_u$, both of which the lemma's "no hypothesis, never uses criticality" sentence excludes, and none of steps 1-3 is written. At $n\le8$ Theorem 4.14 is not stated, so no source on file supplies step 2 there, and "every dimension" in the heading does not extend to this claim.

**Exhibited failure of the unhypothesised reading.** The statement "C2 gives $P\equiv0$ on $V_{1/2}$" as a consequence of the identity alone is false as an inference: at a base point $u$ where $V_{1/2}\supsetneq T_u(SO(n).u)$, the identity constrains $T(x,x,\cdot)$ only on the tangent space. No closed-form $u$ with $V_{1/2}\supsetneq T_u(SO(n).u)$ and a nonzero $P$ on the excess is exhibited here, so the finding is recorded as a missing argument and not as a refutation. **Opposite:** the surrounding section is about the padded $\mathbb{CP}^2$ operator at $n\ge9$, and Passage C records $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$ "from Theorem 4.14(a),(b) with Remark 4.16" four lines earlier, so a reader of the section has the ingredients. That makes the gap short and closable, and it leaves the lemma's text without the argument and with a scope sentence that contradicts what the argument needs. The candidate stands as a GAP.

**What would have to be written:** steps 1-3 above, with the hypotheses $n\ge9$, $u=W_{\mathbb{CP}^2}$ padded and critical, and the citation of Theorem 4.14(a),(b) and Remark 4.16. The heading should carry the range $n\ge9$ against this claim.

Verdict GAP.

## 8. C7, the Lean statements against the record (What to attack 9, instruction 5)

Read against Passage E (lines 92-153 of [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean)).

| Theorem | Binders and hypotheses | Conclusion against the record | Assessment |
|---|---|---|---|
| skew_self_inner_zero | $D:E\to E$ arbitrary, hskew | $\langle x,Dx\rangle=0$ | Matches (I3) at $X=Y=x$. Proof: hskew at $(x,x)$ plus symmetry of the real inner product. Correct |
| invariance_identity_general | $T:E\to E\to E\to\mathbb R$ with no linearity, $D$ arbitrary, hsym (slots 1-2 only), hder (the three-term identity, assumed), hskew, hx: $T\,x\,z\,u=\mathrm{lam}\langle x,z\rangle$, hy likewise | $T\,x\,y\,(Du)=(\mathrm{lam}-\mathrm{mu})\langle Dx,y\rangle$ | Raw normalisation. Proof steps e1, e2 are exactly Section 5's two bullets, read through hx, hy. Correct |
| invariance_identity_record_normalisation | as above with eigen-constants $\mathrm{lam}\cdot\mathrm{ths}$, $\mathrm{mu}\cdot\mathrm{ths}$, ths any real | $(\mathrm{lam}-\mathrm{mu})\,\mathrm{ths}\,\langle Dx,y\rangle$ | This is C4 in the label normalisation, confirming Section 5's reading. ths is unconstrained, which is harmless |
| invariance_identity_diagonal | general with mu := lam, $y=x$ | $T\,x\,x\,(Du)=0$ | C2. Correct |
| Q_perp_orbit_tangent | adds hQ: $\langle Qx,z\rangle=T\,x\,x\,z$ for all $z\in E$ | $\langle Qx,Du\rangle=0$ | C3 for one tangent vector $Du$. With $E=\mathcal W_n$, Qx is $\pi Q(x)$, the Riesz representative inside $\mathcal W_n$. Since $Du\in\mathcal W_n$ this is equivalent to the record's $Q(x)\perp T_u(SO(n).u)$. Criticality absent, as the record says |

**Binders and direction.** All hypotheses are universally quantified over the right variables, the conclusions point the right way, and the types are real-valued. The hypotheses are satisfiable by the record's objects: $E=\mathcal W_n$, $T$ the record's form, $D=[\rho(A),\cdot]$ (which maps $\mathcal W_n$ to itself by (I2)) satisfy hsym by (I4), hder by C1, hskew by (I3), and hx, hy by the eigen-relation through full symmetry.

**What is typed and what is not.**

- **hsym:** only slot 1-2 symmetry is assumed. The record's proof needs full symmetry to pass from $F_ux=\lambda x$ to hx. The Lean moves that step into hx, so the Lean statement is more general than the record's and the link "$F_u$ eigenvector implies hx" is untyped.
- **D:** an arbitrary function, with no linearity and no connection to $\rho(A)$ or $SO(n)$. The three-term identity (C1), which is the lemma's only use of invariance, is an assumption (hder) and is not derived.
- **lam:** raw in the general theorem, label times ths in the second. The record's $\theta^*=\sqrt{3/2}$ is not typed.
- **Untyped claims of Passage A:** the $SO(n)$-invariance of $T$, the identification $T_u(SO(n).u)=\{Du\}$, the value $0.91$ (C5), and $P\equiv0$ on $V_{1/2}$ (C6).

The docstring of Q_perp_orbit_tangent mentions "the Gate 2 widening that this holds at any base point", which agrees with Section 4.

Verdict CONFIRMED AS ALGEBRA.

## 9. The traps, by name (instruction 7)

- **$\ker W\ne0$:** checked in Section 5. The padded $u$ has a large kernel on $\Lambda^2$ and nothing in C1-C4 or C6 uses invertibility. Nothing found.
- **The boundary of every range:** $n\ge4$ for C1-C4 (vacuous below), $n\ge9$ for C6 (Section 7). The crossover $n=6+2\sqrt7$ plays no role. Odd $n$ is covered by Theorem 4.14's $n\ge9$. The only range defect is the heading's unscoped C6.
- **Proven on a subfamily and stated in general:** C6 holds on the padded $\mathbb{CP}^2$ family at $n\ge9$ and sits under a heading and a sentence claiming "every dimension, no hypothesis". Recorded as F4.
- **Hypothesis stated but unused, or used but unstated:** used but unstated are (I6) and (I7) in C6, and (I2), (I5) silently in C2-C3 (true and standard). Stated but unused: none.
- **A universal claim with no witness:** C3 was tested against a diagonal-type witness, $x=u$, $y=A\cdot u$ (Section 5), and against the stabiliser edge. A tangent witness $x=A\cdot u$ is consistent with C3: $\langle Q(A\cdot u),B\cdot u\rangle=0$ for all $B$. Sphere products and $\mathbb{CP}^m$ base points are covered by C3's independence from $u$. Nothing found.
- **An imported theorem whose hypotheses were never checked:** Theorem 4.14 requires $n\ge9$ and $F=F_{W_{\mathbb{CP}^2}}$ on $\mathrm{Weyl}_n$. The lemma does not cite it, and C6 needs it at exactly that range. Recorded in F4.

## 10. Withdrawn candidates

- **F2, "the general form is off by a factor $\theta^*$".** Withdrawn at the third step. Line 447's binder $x\in V_\lambda$ fixes the label normalisation, under which the formula is exact (Section 5). Kept as a notational correction.
- **F1, "$[A,u]$ is ill-typed", as a mathematical defect.** Withdrawn at the third step because the passage supplies $[\rho(A),u]$. Kept as a notational correction.
- **"The stabiliser edge contradicts C4".** Withdrawn at the second step: the forced relation $(\lambda-\mu)\langle A\cdot x,y\rangle=0$ holds by stabiliser equivariance (Section 5).

## 11. The falsifying object and the search for it

- **For C3 and C4:** a base point $u\in\mathcal W_n$, an eigenvector $x$ of $F_u$ and $A\in\mathfrak{so}(n)$ with $T(x,x,[\rho(A),u])\ne0$. None can exist, because the derivation in Sections 2-5 uses only (I1)-(I4), each checked. Tested against $x=u$, $x=A\cdot u$ and stabiliser $A$.
- **For C6 at $n\ge9$:** an $x\in V_{1/2}$ with $T(x,x,x)\ne0$. None can exist, because Theorem 4.14(b) with Remark 4.16 puts every such $x$ in the orbit tangent, where C2 applies.
- **For C6 as literally scoped ("every dimension, no hypothesis"):** a base point $u$ at which $V_{1/2}$ strictly contains the orbit tangent and $P$ is nonzero on the excess. The search stopped at identifying this as the object and at confirming that no source on file rules it out away from the padded $\mathbb{CP}^2$ operator at $n\ge9$. No closed-form witness was constructed, so the finding stays a GAP.
- **For C5:** any stated normalisation under which the maximum is not $0.91$. None can be tested, because no normalisation is stated.

## 12. Overall verdict

**GAP.** The identity itself (C1-C4) is proven, and Q(x) is orthogonal to the orbit tangent at every base point in every dimension, as the Lean algebra also confirms. The claim "$P\equiv0$ on $V_{1/2}$" has no argument on file and needs $n\ge9$, criticality and $V_{1/2}=T_u(SO(n).u)$ from Nienhaus Theorem 4.14(b) and Remark 4.16. With those written it closes in three lines. The value $0.91$ is HYPOTHESIS-DEBT and ill-posed without a normalisation. Two notational slips ($[A,u]$, and $\lambda$ read raw on line 445 and as a label on line 447) should be fixed.
