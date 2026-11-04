# Verifier v234, Lemma L43: the collapse of the a = 0 invariance criterion on the Einstein slice, the boundary constant c(n-1) = theta_0(n), the invariance-to-criterion bridge through Beitz Lemma 2.3.4, and the Lean file L43Statement.lean

*The brief ([BRIEF_L43.md](BRIEF_L43.md)) was read cold, with no prior verdict, round file, ledger or review opened. No numerical work was done: no scripts were written and no computations were run, and every value below is exact and derived by hand. The Lean file was read, and its proofs were read, but it was not built. Log: [agent_logs/verify-L43-v234.log](../agent_logs/verify-L43-v234.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The collapse: $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$, both cross terms vanish, $\lVert\mathrm{ric}(I)\rVert^2$ cancels, and $G(cI+W)\le0\iff\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ on the whole slice inside $\{\mathrm{scal}>0\}$ (Passages A, C, D) | CONFIRMED |
| 2 | $\partial\Omega_0$ meets the slice at the one ratio $c/\lVert W\rVert=c_0:=\frac1n\sqrt{2(n-2)/(n-1)}$, selected by $\mathop{\mathrm{tr}}R>0$, and $c_0(n-1)=\theta_0(n)$ (Passages A, D) | CONFIRMED |
| 3 | Passage A's display $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ as the $a=0$ criterion on the slice | CONFIRMED (read on $\partial\Omega_0$, as Passage A's third paragraph places it) |
| 4 | Passages B and C: the criterion "collapses to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ with/where $c(n-1)=\theta_0(n)$" | REFUTED AS STATED (true only on $\partial\Omega_0$ at $\lVert W\rVert=1$, neither of which B or C states) |
| 5 | Imported facts: Böhm–Wilking Lemma 2.1 and eq. (6), Beitz p. 96 (Remark 6.3.10), $\Phi$ preserving the Bianchi identity, $\lVert I\rVert^2=\binom n2$ | CONFIRMED (each read at source) |
| 6 | Passage D line 70: Beitz Lemma 2.3.4 "supplies only the converse" and invariance $\Rightarrow G\le0$ "holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$" | REFUTED |
| 7 | Passage E: the needed direction is Lemma 2.3.4's first clause, "whose hypotheses check" | GAP (the direction is right, but the clause's stated hypothesis is invariance of all sublevel sets, and only its proof, run at the one level $4/(n-2)$, applies to $\Omega_0$ alone) |
| 8 | "Demands $\theta_0(n)$ and nothing weaker" (title, Passages B and C) | CONFIRMED (as a statement about the criterion on the slice) |
| 9 | Lean: `theta0`, `boundaryC`, `boundary_equation`, `collapse_constant`, `criterion_forms_agree`, `theta0_four` | CONFIRMED AS ALGEBRA |
| 10 | Lean: `lower_nappe_is_different` and the module doc's account of what is NOT typed ("no $\Phi$") | REFUTED AS STATED (the theorem types only $\theta_0(n)>0$, and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean#L189) carries $\Phi$ as `Qop`) |
| 11 | Edges: $n=3,4$, odd $n$, $n=6+2\sqrt7$, $c\le0$, $W=0$, $\ker W\ne0$ | CONFIRMED |
| 12 | Passage D line 60: the sentence containing "Three verifiers, [ROUND_L43-arg](ROUND_L00r2.md)" | REFUTED (the sentence does not parse, and link text and target disagree) |
| 13 | Two incidental remarks: "convexity forces it independently" (Passage A) and "the cone has three endpoints" (Passage C) | REFUTED AS STATED (neither is on the proof chain) |

**What the round should do:** keep the proof, add "on $\partial\Omega_0$, at $\lVert W\rVert=1$" to Passages B and C, replace Passage D line 70's sentence on Lemma 2.3.4 by its first clause read through its proof at the level $4/(n-2)$, fix the ROUND link and its sentence, and correct the Lean file's "no $\Phi$" and the scope of `lower_nappe_is_different`.

## 0. Conventions, fixed once

- $V=\mathbb R^n$, $\Lambda^2V$ with orthonormal basis $e_i\wedge e_j$ ($i<j$), $N=\dim\Lambda^2=\binom n2$.
- Inner product on operators $\langle R,S\rangle=\mathop{\mathrm{tr}}(R\circ S)$, which is Beitz Remark 1.1.7 and is Böhm–Wilking's $-\tfrac12\mathop{\mathrm{tr}}$ on $\mathfrak{so}(n)$ carried to $S^2$. So $\lVert I\rVert^2=N$.
- For $n\ge4$, $S^2_B=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$, orthogonal (Böhm–Wilking p. 3). On the slice $R_{\mathrm{ric}_0}=0$, $R=cI+W$ with $W\in\langle W\rangle$.
- $\mathrm{ric}$ is Beitz's (Definition 1.1.10), one half of Böhm–Wilking's $\mathrm{Ric}$. It is linear in $R$. $\mathrm{scal}(R)=\mathop{\mathrm{tr}}(R)$ (Beitz Remark 1.1.11).
- $\Phi(R)=R^2+R^\#$, $\Phi(A,B)=\tfrac12(AB+BA)+A\#B$, so $\Phi(A+B)=\Phi(A)+2\Phi(A,B)+\Phi(B)$ by bilinearity and $A\#B=B\#A$ (Böhm–Wilking p. 4). $P(W)=\langle W,Q(W)\rangle=\langle W,\Phi(W)\rangle$.
- $C=\mathrm{scal}^+=\{\mathrm{scal}>0\}$, open. $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ on $C$, smooth there because $\mathrm{scal}>0$ forces $\mathrm{ric}\ne0$. $G(R)=dF_R(\Phi(R))$. $\Omega_a=C\cap F^{-1}((-\infty,\tfrac4{n-2+4a}])$.
- $c_0=\frac1n\sqrt{\frac{2(n-2)}{n-1}}$, $\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}n$, $r:=\lVert\mathrm{ric}(I)\rVert^2>0$ (its value, $n(n-1)^2/4$ in Beitz's convention, is never used).
- "The criterion at $a=0$" is read as $G\le0$ on the level set $F=\frac4{n-2}$ inside $C$, which is $\partial\Omega_0\cap C$. $G$ itself does not depend on $a$: the parameter enters only through the set of points tested.

## Hypothesis inventory

| Source | Hypothesis | Checked against | Used by the proof | Stated in the record |
|---|---|---|---|---|
| Böhm–Wilking Lemma 2.1 ([source](https://arxiv.org/abs/math/0606187), text lines 216–234) | $R\in S^2_B(\mathfrak{so}(n))$; the kernel statement for $\langle W\rangle$ is proved at $n=4$ and carried to $n\ge5$ by the zero-padding embedding | $I\in S^2_B$ (gives $\Phi(I)=(n-1)I$); $W\in\langle W\rangle$ (gives $W\#I=-W$); $n\ge4$ | yes, both halves | yes (Passage D table) |
| Böhm–Wilking eq. (6) (text lines 199–206) | $R\in S^2_B$, $e_i$ an orthonormal eigenbasis of $\mathrm{Ric}$ | $W$: $\mathrm{Ric}(W)=0$, so every orthonormal basis is an eigenbasis and the right side vanishes term by term. The sign convention of $R_{kijk}$ is irrelevant to a vanishing | yes ($\mathrm{ric}\,\Phi(W)=0$) | yes |
| Böhm–Wilking p. 4 | $\#$ symmetric and bilinear | used for $\Phi(I,W)=\tfrac12(IW+WI)+W\#I$ | yes | implicit |
| $\Phi$ preserves $S^2_B$ | Böhm–Wilking state the ODE (1) on $S^2_B$ (text lines 64–70), and Beitz Remark 2.3.2 takes $\Phi:\mathcal A_n\to\mathcal A_n$ | needed for $V=\mathcal A_n$ in Lemma 2.3.4, and for "$\Phi(W)$ is Weyl". The collapse itself needs only $\mathrm{ric}\,\Phi(W)=0$ and $\mathop{\mathrm{tr}}\Phi(W)=0$ | yes (bridge), not load-bearing for the algebra | yes, as "standard Hamilton fact" (line 70), not read at a Hamilton source here |
| Hamilton's scalar identity, Beitz Example 2.3.5 | $R\in\mathcal A_n$ | gives $\mathrm{scal}\,\Phi(W)=2\lVert\mathrm{ric}\,W\rVert^2=0$, an alternative route to $\langle I,\Phi(W)\rangle=0$ | optional | yes (Passage A) |
| Beitz Remark 6.3.10, p. 96–97 ([source](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf), text lines 5448–5470) | $n\ge3$, $a\in[0,\tfrac n4]$; the decomposition from Remark 1.1.16 | $\Omega_0=\{\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2,\ \mathop{\mathrm{tr}}R>0\}$ quoted exactly | yes | yes |
| Beitz Lemma 2.3.4 (text lines 1470–1492) | $V$ a vector space, $\Phi$ locally Lipschitz, $C$ open, $F$ smooth on $C$, **and for the first clause: "the sublevel sets of $F$ are invariant"** | $V=\mathcal A_n$, $\Phi$ polynomial, $C=\mathrm{scal}^+$ open, $F$ smooth on $C$: all check. The invariance hypothesis does not: the object is $\Omega_0$ alone (see §7) | yes (bridge to "cone invariance requires") | first clause cited in Passage E, contradicted in Passage D |
| $\lVert I\rVert^2=N$ | Beitz Remark 1.1.7 norm | matches the norm in Remark 6.3.10 | yes | yes |

**Used but unstated:** $c\ne0$ in the identity (automatic inside $C$), and the per-level form of Lemma 2.3.4's first clause (§7).

## 1. The collapse (CONFIRMED)

Take $R=cI+W$ with $c\ne0$.

1. $\Phi(I)=I^2+I\#I=I+(n-2)I=(n-1)I$, by Lemma 2.1 at $R=I$ where $R_I=I$ and $R_{\mathrm{Ric}_0}=0$.
2. $\Phi(I,W)=\tfrac12(IW+WI)+W\#I=W+W\#I=0$, by the kernel statement of Lemma 2.1.
3. So $\Phi(cI+W)=c^2(n-1)I+2c\,\Phi(I,W)+\Phi(W)=c^2(n-1)I+\Phi(W)$.
4. $\mathrm{ric}\,\Phi(W)=0$ by eq. (6). Hence $\mathop{\mathrm{tr}}\Phi(W)=\mathrm{scal}\,\Phi(W)=\mathop{\mathrm{tr}}\mathrm{ric}\,\Phi(W)=0$.
5. $\langle R,\Phi(R)\rangle=c^3(n-1)N+c^2(n-1)\langle W,I\rangle+c\langle I,\Phi(W)\rangle+P(W)=c^3(n-1)N+P(W)$, since $\langle W,I\rangle=\mathop{\mathrm{tr}}W=0$ and $\langle I,\Phi(W)\rangle=\mathop{\mathrm{tr}}\Phi(W)=0$.
6. $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$ and $\mathrm{ric}\,\Phi(R)=c^2(n-1)\mathrm{ric}(I)$, so $\lVert\mathrm{ric}R\rVert^2=c^2r$, $\langle\mathrm{ric}R,\mathrm{ric}\,\Phi R\rangle=c^3(n-1)r$, and $\lVert R\rVert^2=c^2N+\lVert W\rVert^2$.
7. By the quotient rule and linearity of $\mathrm{ric}$, $dF_R(S)=\frac{2\langle R,S\rangle}{\lVert\mathrm{ric}R\rVert^2}-\frac{2\lVert R\rVert^2\langle\mathrm{ric}R,\mathrm{ric}S\rangle}{\lVert\mathrm{ric}R\rVert^4}$. With $S=\Phi(R)$:
$$G(cI+W)=\frac2{c^2r}\Big[c^3(n-1)N+P(W)-\frac{c^2N+\lVert W\rVert^2}{c^2r}\,c^3(n-1)r\Big]=\frac2{c^2r}\Big[P(W)-c(n-1)\lVert W\rVert^2\Big].$$

The factor $r$ cancels, the $c^3(n-1)N$ term cancels, and the prefactor $2/(c^2r)$ is positive for every $c\ne0$. So $G(cI+W)\le0\iff P(W)\le c(n-1)\lVert W\rVert^2$, an identity at every point of the slice with $c\ne0$, in particular on all of slice $\cap\,C$. The before-and-after forms asked for in attack item 1 are: before, $\langle R,\Phi(R)\rangle\le F(R)\langle\mathrm{ric}R,\mathrm{ric}\,\Phi(R)\rangle$ (equivalent to $G(R)\le0$ because $\lVert\mathrm{ric}R\rVert^2>0$); after, $P(W)\le c(n-1)\lVert W\rVert^2$. Passage A's second paragraph and Passage D's display are exactly this. The trilinear symmetry (Böhm–Wilking eq. (5)) is not used, as Passage C says.

## 2. The boundary ratio and the constant (CONFIRMED)

On the slice $R_I=cI$, $R_W=W$, $\mathop{\mathrm{tr}}R=cN$. The Remark 6.3.10 inequality at $a=0$ is $-\frac n4\lVert R_I\rVert^2+\frac{n-2}4\lVert R_W\rVert^2\le0$, and its left side equals $\frac{n-2}4\lVert R\rVert^2-\lVert\mathrm{ric}R\rVert^2$ identically (I rechecked the coefficient: $\frac{n-2}4-\frac{n-1}2=-\frac n4$), so the level set $F=\frac4{n-2}$ is its equality case. Equality reads $c^2N=\frac{n-2}n\lVert W\rVert^2$, that is $c^2=\frac{2(n-2)}{n^2(n-1)}\lVert W\rVert^2$. The clause $\mathop{\mathrm{tr}}R=cN>0$ selects $c=c_0\lVert W\rVert$. So for $W\ne0$ the slice meets $\partial\Omega_0\cap C$ at exactly one ratio $c/\lVert W\rVert=c_0$.

Then $c_0(n-1)=\frac{n-1}n\sqrt{\frac{2(n-2)}{n-1}}=\frac1n\sqrt{(n-1)^2\cdot\frac{2(n-2)}{n-1}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$, using $n-1>0$. As squares, both sides are $\frac{2(n-1)(n-2)}{n^2}$.

## 3. Passage A's display (CONFIRMED)

At $c=c_0\lVert W\rVert$, $c(n-1)\lVert W\rVert^2=\theta_0(n)\lVert W\rVert^3$, so the §1 identity becomes $G\le0\iff P(W)\le\theta_0(n)\lVert W\rVert^3$ at the unique boundary point over each $W\ne0$.

**Attack item 2, whether the display holds off $\partial\Omega_0$.** It does not, and Passage A does not claim it does. At $R=2c_0I+W$ with $\lVert W\rVert=1$, $R$ lies in the interior of $\Omega_0$ ($\frac{n-2}n<4c_0^2N=\frac{4(n-2)}n$) and $G(R)\le0\iff P(W)\le2\theta_0(n)$. Passage A's "identity on the whole slice" is stated for the residue $\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2$, which is right (§1), and its third paragraph places the $\theta_0(n)$ form at $\partial\Omega_0$. The first sentence, "On the slice … collapses … to [the $\theta_0$ display]", is correct once "the criterion at $a=0$" is read as the criterion on $\partial\Omega_0$, which is its meaning in Lemma 2.3.4's per-level form.

## 4. Passages B and C (REFUTED AS STATED)

**Location.** Passage B ([results.md](../results.md#L100)): "collapses Böhm–Wilking's criterion on $\Omega_0$ to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ with $c(n-1)=\theta_0(n)$ exactly." Passage C ([results.md](../results.md#L370)): "at $a=0$ the whole condition collapses to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$, where $c(n-1)=\theta_0(n)$". Passage C writes $R=cI+W$ with $W$ unnormalised.

**Failure in closed form.** Fix a unit Weyl $W_1$ and put $R=2c_0I+2W_1$. Then $R\in\partial\Omega_0\cap C$ (the cone is scale-invariant), $c=2c_0$, and $c(n-1)=2\theta_0(n)\ne\theta_0(n)$. And "on $\Omega_0$" (B) or "the whole condition" (C) includes interior points such as $2c_0I+W_1$ of §3, where $c(n-1)=2\theta_0(n)$ at unit norm.

**Charitable reading.** The criterion is homogeneous of degree 3 in $(c,W)$, so fixing $\lVert W\rVert=1$ loses nothing, and "at $a=0$" can be taken to mean "on $\partial\Omega_0$". Passage D does both explicitly ("Normalising $\lVert W\rVert=1$, the $\partial\Omega_0$ constraint …"). That reading repairs the mathematics but not the sentences: B and C are the canonical statements, C names $W$ without normalisation, and Passage A shows the record itself carries $\lVert W\rVert^3$ when $W$ is not unit. The finding stands as a statement defect, with the proof intact. Repair: "on $\partial\Omega_0$, and at $\lVert W\rVert=1$ the constant is $c(n-1)=\theta_0(n)$", or state C's display as $\le\theta_0(n)\lVert W\rVert^3$.

## 5. Imported facts at source (CONFIRMED)

- **Lemma 2.1** is quoted correctly: "$R+R\#I=(n-1)R_I+\frac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}$", with "$\langle W\rangle$ is in the kernel of the map $R\mapsto R+R\#I$" in the proof, for $n=4$ directly and $n\ge5$ by embedding. The proof's kernel sentence is part of what the lemma asserts by its displayed formula (the right side has no $R_W$ term), so its use is a use of the statement.
- **Eq. (6)** is quoted correctly, $\mathrm{Ric}(R^2+R^\#)_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$ in a Ricci eigenbasis. The deduction $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}\,\Phi(W)=0$ is valid in any basis and any sign convention.
- **$\#$ normalisation across the two sources.** Beitz's $\#$ (Definition 1.1.17) is written differently from Böhm–Wilking's (4). Beitz herself imports Lemma 2.1 in her normalisation (Lemma 6.3.16's proof, "$I^2+I^\#=(n-1)I$ (see [BW08, Lemma 2.1])", and (6.29), $\frac d{ds}\Phi(I+sR)=2(R+I\#R)=2(n-1)R_I+(n-2)R_{\mathrm{ric}_0}$, which has no $R_W$ term). So $\Phi(I,W)=0$ holds for the $\Phi$ of her ODE (2.4). See withdrawn candidate W2.
- **Beitz p. 96.** Remark 6.3.10 prints the decomposition inequality and $\Omega_0=\{\frac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$ and $\mathop{\mathrm{tr}}(R)>0\}$ exactly as Passage D quotes. The $\Omega_a$ definition (p. 97) includes $\mathrm{scal}(R)>0$, as Passage A says, and Passage C's definition carries it too.
- **Bianchi preservation.** Böhm–Wilking pose the ODE on $S^2_B$ and Beitz Remark 2.3.2 takes $\Phi:\mathcal A_n\to\mathcal A_n$. This is what Lemma 2.3.4 needs ($\Phi:V\to V$). For the collapse algebra it is not needed, since steps 4–5 of §1 use only the Ricci contraction.

## 6. Passage D's sentence on Lemma 2.3.4 (REFUTED)

**Location.** [problem.md line 70](../findings/problem.md#L70): "the bridge needs invariance $\Rightarrow G\le0$, where Beitz Lemma 2.3.4 supplies only the converse; it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$."

**Failure.** At source (text lines 1470–1475) the lemma's first clause is exactly "If the sublevel sets of $F$ are invariant under (2.2), then for all $v\in C$ we have that $dF_v(\Phi(v))\le0$", which is invariance $\Rightarrow G\le0$. So "supplies only the converse" is false of the source. And the offered replacement is not an argument for that direction: $\frac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2\ge0$ is Beitz Example 2.3.5, which shows $\{\mathrm{scal}\ge a\}$ is invariant, that is, that solutions from $C$ stay in $C$. That is the extra hypothesis of the converse's final sentence ("if $C$ is additionally invariant"), and it says nothing about the sign of $dF(\Phi)$.

**Charitable reading.** The sentence could mean that the scal identity keeps trajectories inside $C$ so that $F\circ f$ is defined. But the first clause's proof already gets that from the assumed invariance ($f(t)\in F^{-1}((-\infty,a])\subseteq C$), and the sentence still asserts the lemma lacks a direction it has. The finding stands. Passage E (§7) cites the right clause, so the record contradicts itself across two canonical texts.

## 7. Passage E, "whose hypotheses check" (GAP)

**Location.** [results.md line 376](../results.md#L376): "the direction *invariance $\Rightarrow dF_R(\Phi(R))\le0$* being the first clause of Beitz's Lemma 2.3.4, whose hypotheses check."

**Failure.** The first clause's hypothesis is "the sublevel sets of $F$ are invariant", plural and unrestricted. The object L43 and L44 apply it to is one set, $\Omega_0=F^{-1}((-\infty,\frac4{n-2}])$. The conjecture supplies at most the levels $[\frac2{n-1},\frac4{n-2}]$ (all $a\in[0,\frac n4]$), never levels above $\frac4{n-2}$, and L44 wants the contrapositive for $\Omega_0$ specifically. The clause as stated, contraposed, yields only "some sublevel set is not invariant".

**Charitable reading.** The source's proof is per level: it fixes $v$, sets $a:=F(v)$, and uses only invariance of $F^{-1}((-\infty,a])$. Run at $v\in\partial\Omega_0\cap C$, it uses exactly the invariance of $\Omega_0$ and gives $G(v)\le0$. So the mathematics the bridge needs is on file at source, in the lemma's proof rather than in its statement. The remaining hypotheses ($V=\mathcal A_n$, $\Phi$ locally Lipschitz, $C=\mathrm{scal}^+$ open, $F$ smooth on $C$) do check. Verdict GAP: the citation should name the proof's per-level argument at level $\frac4{n-2}$, and "whose hypotheses check" should be withdrawn for the statement. No argument is missing from the literature, so this is not HYPOTHESIS-DEBT.

## 8. "Nothing weaker" (CONFIRMED)

What it quantifies over: the constant. By §2 each $W\ne0$ has exactly one tested point on slice $\cap\,\partial\Omega_0\cap C$, and by §1 the criterion there is equivalent (not merely implied) to $P(W)\le\theta_0(n)\lVert W\rVert^3$. So the criterion restricted to slice $\cap\,\partial\Omega_0$ is equivalent to $\sup_{\lVert W\rVert=1}P(W)\le\theta_0(n)$, and no constant $\theta'>\theta_0(n)$ yields an equivalent condition. "Demands" is necessity only: the slice is a subset of $\partial\Omega_0$, so the slice criterion is necessary for $G\le0$ on $\partial\Omega_0$ and says nothing about points with $R_{\mathrm{ric}_0}\ne0$. The record states this ("It does not reach $a$ strictly between …", L45 for off the slice). The step from the criterion to "cone invariance requires" (Passage A's closing sentence) rests on §7's per-level reading.

## 9. Lean, the arithmetic theorems (CONFIRMED AS ALGEBRA)

Read against [L43Statement.lean](../lean/HamiltonsCubic/Results/L43Statement.lean), which matches the brief verbatim (144 lines on disk against the brief's "145", a trailing-newline count). `grep` finds `sorry` only in the doc comment. An `.olean` for the module exists under `lean/.lake/build`, and I did not rebuild.

- **`theta0 (n : ℝ)`, `boundaryC (n : ℝ)`** are $\theta_0$ and $c_0$ exactly as §0 defines them. `n` ranges over `ℝ`, which is more general than the dimension and specialises.
- **`boundary_equation`** (`3 ≤ n`): `(n - 2) / n = boundaryC n ^ 2 * (n * (n - 1) / 2) ∧ 0 < boundaryC n`. This is §2's equality at $\lVert W\rVert=1$ with $\lVert I\rVert^2=N$ entered as a literal, and positivity. Uniqueness of the positive root is not typed, and it is immediate. Proof steps: `Real.sq_sqrt` needs `0 ≤ 2*(n-2)/(n-1)`, supplied by `positivity` from `h1`, `h2` in context. Direction and binders are right.
- **`collapse_constant`**: `boundaryC n * (n - 1) = theta0 n`. The proof rewrites $\sqrt{2(n-1)(n-2)}=(n-1)\sqrt{2(n-2)/(n-1)}$ via `Real.sqrt_mul` on $(n-1)^2\ge0$ and `Real.sqrt_sq` on $n-1\ge0$, which is §2's computation.
- **`criterion_forms_agree`**: for any finite `ι`, any function `W : Matrix ι ι ℝ → Matrix ι ι ℝ` (not required Weyl or linear), `normSq W = 1` and `norm W = 1`, it states `Pcubic W ≤ boundaryC n * (n - 1) * normSq W ↔ Pcubic W ≤ theta0 n * norm W ^ 3`. The hypothesis `norm W = 1` is redundant given `normSq W = 1` (`norm` is `Real.sqrt (normSq R)`, [WeylReal.lean:177](../lean/HamiltonsCubic/Base/WeylReal.lean#L177)). `n` is not tied to `Fintype.card ι`. Both are generalities, harmless because the statement is the substitution $1\cdot c_0(n-1)=\theta_0(n)\cdot1^3$, as the doc itself says ("an equivalence between two readings of one inequality"). The inequality directions agree on both sides.
- **`theta0_four`**: $\theta_0(4)=\sqrt{12}/4=\sqrt3/2$, correct.
- **"Nothing here asserts the bound"** is accurate: no statement implies $\theta\le\theta_0(n)$.

## 10. Lean, `lower_nappe_is_different` and the NOT-typed account (REFUTED AS STATED)

**Candidate 10a. Location.** Lines 208–219: section title "The `scal(R) > 0` clause is load-bearing", doc "the nappe the clause discards demands the opposite constant", statement `-theta0 n < 0 ∧ 0 < theta0 n`. **Failure.** The statement is equivalent to $\theta_0(n)>0$ for real $n\ge3$. Nothing about a nappe, $F$, the scal clause, or which constant a nappe demands appears in it. It would be provable verbatim with `theta0` replaced by any positive constant. **Charitable reading.** The module doc's bullet describes it as "`-θ₀(n) < θ₀(n)`, so the nappe … demands a different, and opposite, constant", which could be read as a gloss on a sign fact whose nappe content lives in the record. That reading makes the typed content honest and the title "load-bearing" an overstatement: the theorem types the sign of $\theta_0$, and the load-bearing claim is untyped. Stands, minor.

**Candidate 10b. Location.** Line 143: "`RealLayer` has `Pcubic` and `normSq` but no `Φ`, no `I`, and no decomposition". **Failure.** [WeylReal.lean:189](../lean/HamiltonsCubic/Base/WeylReal.lean#L189) defines `Qop (R) := fun X => compOp R X + sharpOp R X`, documented as "Hamilton's map `Q(R) = R² + R#`", for arbitrary `R : Matrix ι ι ℝ → Matrix ι ι ℝ`. That is $\Phi$. **Charitable reading.** Perhaps "no $\Phi$" means no $\Phi$ with the properties $\Phi(I,W)=0$ and Weyl preservation proved. The sentence lists objects, not properties, and `I` is absent as a named definition while $F$, $\Omega_0$ and the decomposition are genuinely absent, so the conclusion "the first half of the derivation … is absent" still holds. The reason given is inaccurate for $\Phi$. Stands, minor. The same wording is in [lean/INDEX.md:252](../lean/INDEX.md#L252).

## 11. Edges (CONFIRMED)

- **$n=3$:** $\langle W\rangle=0$, and Böhm–Wilking's decomposition is for $n\ge4$. Slice $\cap\,\partial\Omega_0\cap C$ is empty ($W=0$ forces $c=0$, excluded by $\mathop{\mathrm{tr}}R>0$). The lemma is vacuous. The Lean theorems at $n=3$ state true arithmetic ($c_0(3)=\frac13$, $\theta_0(3)=\frac23$) about no Weyl tensor.
- **$n=4$:** the smallest nontrivial case, where Böhm–Wilking verify the kernel directly.
- **Odd $n$:** no step of §1–§2 uses parity. Passage D's odd-$n$ remark (line 68) is outside the collapse. Its inequality $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\frac{2(n-1)(n-2)}{n^2}$ reduces to $n^2(n-3)<(n-2)^2(n+1)=n^3-3n^2+4$, true for every $n$, and $\frac{40}{27},\frac{120}{77},\frac{21}{13}$ are the values at $11,13,15$. The attainment claims there rest on sphere-product values I did not re-derive.
- **$n=6+2\sqrt7$:** $\theta_0(n)^2=\frac32\iff n^2-12n+8=0\iff n=6\pm2\sqrt7$. Since $25<28<36$, $11<6+2\sqrt7<12$, so no integer sits on the crossover, and "$\le11$" in line 66 is exact for integers $n\ge4$ ($6-2\sqrt7<1$).
- **$c<0$:** outside $C$. The identity of §1 holds there too (it needs only $c\ne0$), giving the lower-nappe criterion $P(W)\le-\theta_0(n)\lVert W\rVert^3$ at $c=-c_0\lVert W\rVert$, as Passage A says. **$c=0$:** $\mathrm{ric}R=0$, $F$ undefined, and the decomposition equality forces $W=0$, as Passage A says.
- **$W=0$:** $R=cI$, $G(cI)=0$ (consistent with Beitz's $G(I)=0$), and $cI$ is interior, never on $\partial\Omega_0$.
- **$\ker W\ne0$:** every step uses only $W\in\langle W\rangle$, and the Böhm–Wilking kernel argument is itself the zero-padding embedding. A zero-padded Weyl tensor satisfies Bianchi and has zero Ricci, so it is covered.

## 12. The ROUND link sentence (REFUTED)

**Location.** [problem.md line 60](../findings/problem.md#L60): "… **the positive root, and $\mathop{\mathrm{tr}}(R)>0$ is what selects it.** *$F$ is even in $R$, …* **Three verifiers, [ROUND_L43-arg](../verification/ROUND_L00r2.md)**, so the bound demanded is $$c(n-1)=\dots$$".

**Failure.** "Three verifiers, [link], so the bound demanded is" has no main verb: a provenance tag has been spliced into the mathematical sentence "…gives $c=\dots$, so the bound demanded is $c(n-1)=\theta_0(n)$", severing it from its antecedent by an italic aside and a bold tag. The link text names `ROUND_L43-arg`, which does not exist in `verification/` (checked by listing, file not opened), while the target is `ROUND_L00r2.md`, which does exist (not opened).

**Charitable reading.** The tag may intend "(three verifiers, see the round file)", and the target may be the correct round with a stale label. Even so the text and target disagree, and the sentence does not parse as written. Stands, record hygiene only.

## 13. Two incidental remarks (REFUTED AS STATED)

**13a. Location.** Passage A: "The clause is in the source's own definition and convexity forces it independently." **Failure.** $-\Omega_0=\{\mathrm{scal}<0\}\cap F^{-1}((-\infty,\frac4{n-2}])$ is the image of the convex set $\Omega_0$ under $R\mapsto-R$, hence convex, and carries the opposite clause. Convexity forces *a* single nappe (the double cone is not convex: $c_0I+W$ and $-c_0I+W$ average to $W$, which fails $\frac{n-2}n\lVert W\rVert^2\le0$), and it does not choose $\mathrm{scal}>0$. **Charitable reading.** With "and contains $I$" added, convexity does force $\mathrm{scal}>0$. The sentence omits it, and the source's definition carries the clause regardless, so nothing downstream depends on this. Stands, minor.

**13b. Location.** Passage C: "The cone has three endpoints". **Failure.** The family is indexed by $a\in[0,\frac n4]$, which has two endpoints, and Passage D's table has three rows ($a>\frac n4$, $a=\frac n4$, $a\to0$), of which the first is not an endpoint. **Charitable reading.** "Three regimes" is presumably meant. Stands, wording only.

## Withdrawn candidates

- **W1. "False at every sphere product" (Passage A, lower nappe).** Candidate: for $W'=-W_{S^{k}\times S^{k}}$ at even $n=2k$, $P(W')=-\theta_0(n)$, so $P(W')\le-\theta_0(n)$ holds with equality. Charitable reading: $-W_{S^k\times S^k}$ is not the Weyl tensor of a sphere product, and at the sphere product's own Weyl tensor $P>0>-\theta_0(n)$. Withdrawn.
- **W2. $\#$ normalisation mismatch between Böhm–Wilking and Beitz.** Candidate: Definitions (4) and 1.1.17 are written differently, and a factor $k\ne1$ would give $\Phi(I,W)=(1-k)W\ne0$. Withdrawn at source: Beitz uses Böhm–Wilking Lemma 2.1 in her own normalisation, and her (6.29) has no Weyl term.
- **W3. The "identity on the whole slice" fails at $c=0$.** Withdrawn: $F$ is undefined there and the point is outside $C$, so "the slice" inside the cone's domain is what is meant.
- **W4. `norm` in `criterion_forms_agree` could resolve to Mathlib's `Norm.norm`.** Withdrawn: `Matrix ι ι ℝ → Matrix ι ι ℝ` has no `Norm` instance (the domain is not a `Fintype`), so under `open HamiltonsCubic.RealLayer` only `RealLayer.norm` elaborates. A built `.olean` is present.
- **W5. The brief's line range for Passage D.** Candidate: problem.md lines 32–75 contain two further paragraphs. Withdrawn: they sit at lines 72 and 74, outside the cited 32–70, and the quoted text matches lines 32–70 exactly.

## Falsifier

The object that would falsify the collapse is a Weyl $W$ and $c>0$ with $G(cI+W)\cdot\frac{c^2r}2\ne P(W)-c(n-1)\lVert W\rVert^2$, or a $W$ with $\Phi(I,W)\ne0$ or $\mathrm{ric}\,\Phi(W)\ne0$. Each is excluded by the §1 derivation from Lemma 2.1 and eq. (6) as read at source, so none exists. The object that would falsify the constant is a second positive ratio $c/\lVert W\rVert$ on the boundary, excluded by §2's quadratic. What I did to look: rebuilt §1–§2 by hand, tested the interior point $2c_0I+W$, the rescaled boundary point $2c_0I+2W$, the lower nappe, $c=0$, $W=0$, zero-padding, and $n=3$, and read every imported statement and the proof of Lemma 2.3.4 at source. The two statement-level failures found (§4, §7) are in what the canonical texts say, and the proof survives both.

## Commit hygiene note

When the verdict commit 215ff83d was made, three files had already been staged by another session: [lean/HamiltonsCubic/Results/L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean), [lean/INDEX.md](../lean/INDEX.md) and [plan-lean.md](../plan-lean.md). I listed them before committing, but `git commit` commits the whole index, so 215ff83d carries them alongside this report. The pre-commit hook ran `lake build` on them and it passed. I did not edit, unstage or amend them. Their authorship belongs to the session that staged them, and they have no connection to this verification.

## Overall verdict

**PROVEN (hypotheses corrected).** The collapse and the constant are proved correctly from the cited sources. The corrections are: Passages B and C must carry "on $\partial\Omega_0$, at $\lVert W\rVert=1$" for $c(n-1)=\theta_0(n)$. The invariance-to-criterion step must cite Lemma 2.3.4's first clause through its per-level proof at $\frac4{n-2}$ (Passage D's sentence denying that clause is wrong, and Passage E's "hypotheses check" holds only for that per-level form). The ROUND link, the Lean doc's "no $\Phi$", the scope of `lower_nappe_is_different`, "convexity forces it" and "three endpoints" are minor.
