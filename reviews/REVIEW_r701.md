# Review r701, the corollary to Lemma L154: $X_{\mathrm{inv}}=0$ iff $\mathop{\mathrm{ran}}W$ is a graded subalgebra

**Verdict: CONFIRMED, with three corrections.** The equivalence is true as stated, and it is stronger than stated: both directions are hypothesis-free algebra on $\Lambda^2\mathbb R^n$, so the criticality hypothesis and the detour through [Lemma L154](../findings/bounds.md)(i) can both be dropped. The same argument shows L154(i) itself holds for every symmetric $W$. The $W_{\mathbb{CP}^2}$ point at $n=4$ is a confirmation, decided by hand. One sentence of the screen paragraph is ambiguous in a way the corollary's own algebra refutes on its literal reading.

*Reviewer r701, 2026-09-05. Analysis-only; one screen of seconds on a self-built $\#$ over $\mathfrak{so}(4)$, reported as a screen in §6.*

## 1. The Gram-weight "iff" is sound

The corollary's first step is that $\langle C\xi,\xi\rangle=0$ for all $\xi\in\mathfrak p$ forces $[\mathfrak p,\mathfrak m]\perp\mathfrak p$, and likewise for the other two blocks. The worry raised in the brief is that a weighted sum can vanish without each term vanishing. It cannot here, for two reasons that hold together.

- **Every weight in every block is strictly positive.** $W_+=\sum_{\alpha}a_\alpha\varphi_\alpha\varphi_\alpha^{\mathsf T}$ runs over an orthonormal eigenbasis of $\mathfrak p=\mathop{\mathrm{ran}}W_+$, where every $a_\alpha>0$; $W_-=\sum_\beta b_\beta\psi_\beta\psi_\beta^{\mathsf T}$ over $\mathfrak m$ with every $b_\beta>0$. Eigenvectors of eigenvalue zero lie in $\mathfrak k$ and carry weight zero, so they contribute nothing and are never a $\varphi_\alpha$ or $\psi_\beta$. The Gram sum is therefore a sum of squares with positive coefficients, and $\sum a_\alpha b_\beta\langle[\varphi_\alpha,\psi_\beta],\xi\rangle^2=0$ forces $\langle[\varphi_\alpha,\psi_\beta],\xi\rangle=0$ for every pair.
- **Degeneracy is harmless.** The conclusion "$\langle[\varphi_\alpha,\psi_\beta],\xi\rangle=0$ for all basis pairs and all $\xi\in\mathfrak p$" is, by bilinearity of the bracket, the statement $[\mathfrak p,\mathfrak m]\perp\mathfrak p$ about the subspaces, which is independent of which orthonormal basis was chosen inside a degenerate eigenspace.

The same two points apply to $W_+^\#$ (weights $a_\alpha a_{\alpha'}$), $W_-^\#$ (weights $b_\beta b_{\beta'}$) and $\lvert W\rvert^\#$ (all three kinds), and since $W_+^\#$ and $W_-^\#$ are each PSD their sum vanishes on $\mathfrak m$ only when both do. So the four orthogonalities are exactly the vanishing of the three diagonal blocks.

## 2. Four orthogonalities equal three inclusions

With $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m\oplus\mathfrak k$ orthogonal:

| bracket | orthogonal to (from which block) | hence contained in |
|---|---|---|
| $[\mathfrak p,\mathfrak p]$ | $\mathfrak m$ ($P_-$ block), $\mathfrak k$ ($P_0$ block) | $\mathfrak p$ |
| $[\mathfrak p,\mathfrak m]$ | $\mathfrak p$ ($P_+$ block), $\mathfrak k$ ($P_0$ block) | $\mathfrak m$ |
| $[\mathfrak m,\mathfrak m]$ | $\mathfrak m$ ($P_-$ block), $\mathfrak k$ ($P_0$ block) | $\mathfrak p$ |

Conversely each inclusion implies its two orthogonalities. The three inclusions give closure of $\mathfrak p\oplus\mathfrak m$ under the bracket and an involutive automorphism ($+1$ on $\mathfrak p$, $-1$ on $\mathfrak m$), which is what "a Lie subalgebra graded as a symmetric pair" means. **Correct.**

## 3. Correction 1, criticality is never used, in either direction

The corollary's route runs: inclusions $\Rightarrow$ diagonal blocks vanish $\Rightarrow\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0\Rightarrow X_{\mathrm{inv}}=0$ by L154(i), whose proof consumes criticality twice ($W^\#=\theta W-W^2$ to kill $\ker W$, and Theorem A's form of $X_{\mathrm{inv}}$). The detour is unnecessary, because the inclusions make $X_{\mathrm{inv}}$ vanish by direct expansion.

**Graded $\Rightarrow X_{\mathrm{inv}}=0$, for any symmetric $W$.** Write $\lvert W\rvert^\#=W_+^\#+W_-^\#+2C$ and $W^\#=W_+^\#+W_-^\#-2C$ (bilinearity of $\#$, $C=W_+\#W_-$). Under the three inclusions the rank-one formula puts $W_+^\#$ and $W_-^\#$ inside $\mathop{\mathrm{End}}(\mathfrak p)$, their Gram vectors $[\varphi_\alpha,\varphi_{\alpha'}]$, $[\psi_\beta,\psi_{\beta'}]$ lie in $\mathfrak p$, and $C$ inside $\mathop{\mathrm{End}}(\mathfrak m)$. Hence $P_+W^\#P_+=W_+^\#+W_-^\#$ and $P_-W^\#P_-=-2C$, and
$$X_{\mathrm{inv}}=\lvert W\rvert^\#-P_+W^\#P_++P_-W^\#P_-=(W_+^\#+W_-^\#+2C)-(W_+^\#+W_-^\#)-2C=0.$$

**$X_{\mathrm{inv}}=0\Rightarrow$ graded, for any symmetric $W$.** The three diagonal-block formulas are themselves hypothesis-free: $P_+X_{\mathrm{inv}}P_+=P_+(\lvert W\rvert^\#-W^\#)P_+=4P_+CP_+$, $P_-X_{\mathrm{inv}}P_-=P_-(\lvert W\rvert^\#+W^\#)P_-=2P_-(W_+^\#+W_-^\#)P_-$, $P_0X_{\mathrm{inv}}P_0=P_0\lvert W\rvert^\#P_0$, [Result 5(a)](../ATTEMPTS.md) says as much ("hypothesis-free algebra"). So $X_{\mathrm{inv}}=0$ zeroes the blocks, and §1–§2 give the inclusions.

**By-product: L154(i) is hypothesis-free too.** $\mathop{\mathrm{tr}}X_{\mathrm{inv}}$ is the sum of three PSD block traces, so $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0$ zeroes the blocks, hence (§1–§2) the inclusions hold, hence (above) $X_{\mathrm{inv}}=0$. This is a shorter proof of L154(i) than the one on the record, and it holds at every symmetric $W$, critical or not. **The corollary should be restated without "at a critical point" and without citing L154(i), and L154(i)'s block should note that its own conclusion is a special case.** The criticality hypothesis is harmless where it stands; it is a hypothesis the theorem does not use.

## 4. Correction 2, how the class relates to L7's stated class

[Lemma L7](../findings/bounds.md)'s block states its equality class as **(E1)** $[\mathfrak p,\mathfrak p]\perp\mathfrak m$, **(E2)** $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, **(E3)** $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, "modulo $\ker W$". Read from L7's proof these are exactly the vanishing of the three dropped traces $\mathop{\mathrm{tr}}(P_-W_+^\#)$, $\mathop{\mathrm{tr}}(P_-W_-^\#)$, $\mathop{\mathrm{tr}}((I-P_-)C)$, the last including $\mathop{\mathrm{tr}}(P_0CP_0)$, so (E3) already carries $[\mathfrak p,\mathfrak m]\perp\mathfrak k$. What (E1)–(E3) are silent on is $[\mathfrak p,\mathfrak p]\cap\mathfrak k$ and $[\mathfrak m,\mathfrak m]\cap\mathfrak k$; the corollary's class closes both off. The two classes coincide at a critical point, and only there, by one identity:
$$P_0W^\#P_0=0\quad\Longrightarrow\quad P_0(W_+^\#+W_-^\#)P_0=2P_0CP_0,$$
i.e. at a critical point the $\mathfrak k$-leak of $[\mathfrak p,\mathfrak p]$ plus that of $[\mathfrak m,\mathfrak m]$ equals twice the $\mathfrak k$-leak of $[\mathfrak p,\mathfrak m]$, so (E3) forces closure. Away from critical points (E1)–(E3) can hold with $[\mathfrak p,\mathfrak p]$ leaking into $\mathfrak k$, and then $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=\mathop{\mathrm{tr}}P_0\lvert W\rvert^\#P_0>0$ while L7's slack, as L7's proof defines it, is zero, the identification $S=\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}$ of [r699](REVIEW_r699.md) is itself a critical-point identity ($S-\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}=-\tfrac12\mathop{\mathrm{tr}}(P_0W^\#)$).

So "L7's equality class is exactly this class" is **true at critical points, which is L7's whole domain, and the corollary should say that the "modulo $\ker W$" qualifier in L7's block is retired by criticality**: at a critical point the graded span is automatically closed. That is the corollary's genuine new content over the record (§7).

## 5. $W_{\mathbb{CP}^2}$ at $n=4$ is a confirmation, by hand

$\mathfrak{so}(4)=\Lambda^2_+\oplus\Lambda^2_-$, two commuting ideals each $\cong\mathfrak{so}(3)$. $W_{\mathbb{CP}^2}$ is self-dual: it lives on $\Lambda^2_+$ with spectrum $(2b,-b,-b)$ there and vanishes on $\Lambda^2_-$ ([r515](REVIEW_r515.md)'s numbers $(0.8165;-0.4082,-0.4082;0,0,0)$). Take an orthonormal basis $e_1,e_2,e_3$ of $\Lambda^2_+$ with $We_1=2be_1$, $We_{2,3}=-be_{2,3}$; then $[e_i,e_j]=\kappa\,\epsilon_{ijk}e_k$. So $\mathfrak p=\mathbb Re_1$, $\mathfrak m=\mathop{\mathrm{span}}(e_2,e_3)$, $\mathfrak k=\Lambda^2_-$, and:

- $[\mathfrak p,\mathfrak p]=0\subseteq\mathfrak p$; $[e_1,e_2]=\kappa e_3$, $[e_1,e_3]=-\kappa e_2$, so $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$; $[e_2,e_3]=\kappa e_1$, so $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$.
- $[\Lambda^2_+,\Lambda^2_-]=0$, so nothing leaks into $\mathfrak k$: $\mathfrak p\oplus\mathfrak m=\Lambda^2_+$ is closed.

Hence $\mathfrak p\oplus\mathfrak m\cong\mathfrak{so}(3)$ graded as the symmetric pair $(\mathfrak{so}(3),\mathfrak{so}(2))$, and the corollary predicts $X_{\mathrm{inv}}=0$. Direct check: $W_+^\#=0$ (rank one), $W_-^\#=2c\kappa^2b^2\,e_1e_1^{\mathsf T}$ on $\mathfrak p$, $C=2c\kappa^2b^2(e_2e_2^{\mathsf T}+e_3e_3^{\mathsf T})$ on $\mathfrak m$, and §3's expansion gives $X_{\mathrm{inv}}=0$ identically. (Through Theorem A instead: $X_{\mathrm{inv}}=2b(2c\kappa^2\cdot2b-\theta-b)P_-$, and the $\mathfrak m$-row of $Q(W)=\theta W$ reads $b^2-2c\kappa^2\cdot2b\cdot b=-\theta b$, the same bracket, consistent.)

**L7's caveat and the corollary agree.** The caveat says $\mathfrak{so}(4)$ has no $\mathbb Z_2$-grading with $\mathfrak p\oplus\mathfrak m$ as its two pieces, true, since $\mathfrak p\oplus\mathfrak m$ is 3-dimensional in a 6-dimensional algebra. The corollary grades $\mathfrak p\oplus\mathfrak m$ itself, which here is a proper ideal. The corollary's phrase "$\mathfrak p\oplus\mathfrak m$ is a Lie subalgebra … graded" already carries this; it should add one clause saying the graded object is $\mathop{\mathrm{ran}}W$ and can be a proper subalgebra, with $W_{\mathbb{CP}^2}$ at $n=4$ as the named instance, so that the caveat in L7's block is read as compatible rather than contradictory. The record's "$W_{\mathbb{CP}^2}$ is structured, ungraded" ([INDEX-results](../findings/INDEX-results.md) row 25, [INDEX-traps](../findings/INDEX-traps.md) W3) uses "graded" in the $\ker W=0$ sense; in the corollary's sense $W_{\mathbb{CP}^2}$ is graded. The two senses should be named where they meet.

## 6. Correction 3, the screen paragraph names two near-identical objects with opposite verdicts

The screen lists "$W_{\mathbb{CP}^2}$ padded to $n=4$ and $n=5$" as graded and "padded $\mathbb{CP}^2$ at $n=6$" as failing $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$. Zero-padding cannot change the verdict: if $W'=W\oplus0$ on $\Lambda^2\mathbb R^{n'}\supset\Lambda^2\mathbb R^n$, then $\mathfrak p$ and $\mathfrak m$ are unchanged, $\mathfrak k$ grows by a subspace that brackets $\Lambda^2\mathbb R^n$ into $\Lambda^2\mathbb R^n$ … and the three inclusions are statements about $\mathfrak p,\mathfrak m$ alone, so they persist; equivalently $X_{\mathrm{inv}}(W')=X_{\mathrm{inv}}(W)\oplus0$ because $\#$ of an operator supported on $\Lambda^2\mathbb R^n$ is supported there. The record's constructor [padded_cp2](../scripts/lib/b_cp2_nondegenerate.py) is a zero-padding followed by a Weyl projection that fixes it (zero-padding preserves Ricci-flatness and Bianchi). So the $n=6$ object that fails must be a different constructor, presumably the full $\mathbb{CP}^2$ curvature tensor Weyl-projected in dimension six, which has support outside $\Lambda^2\mathbb R^4$. **The corollary's screen sentence should name that object, and should say that $W_{\mathbb{CP}^2}\oplus0$ is graded at every $n$.** On its literal reading the sentence contradicts the corollary it is offered in support of.

**My own screen, seconds, self-built.** A rank-one $\#$ on $\mathfrak{so}(4)$ from the bracket alone, no record code. A random non-critical $W$ with $\mathfrak p=\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ and $\mathfrak m$ its complement (criticality residual $6.6$): $\lVert X_{\mathrm{inv}}\rVert=1\times10^{-14}$. A non-critical $\mathbb{CP}^2$-type $W=1.3\,e_1e_1^{\mathsf T}-0.7\,e_2e_2^{\mathsf T}-0.2\,e_3e_3^{\mathsf T}$ on $\Lambda^2_+$ with $\dim\mathfrak k=3$ (residual $1.8$): $\lVert X_{\mathrm{inv}}\rVert=2\times10^{-15}$. Three random symmetric $W$: $\mathop{\mathrm{tr}}X_{\mathrm{inv}}$ between $22$ and $48$, $X_{\mathrm{inv}}\ne0$. This screens §3's hypothesis-free claim and is offered as a screen of the algebra above, which is the evidence.

## 7. Is it already on the record?

Partly, and the record should credit what was there.

- **Trace level, three conditions modulo the kernel, on the record, Gate 2 passed.** [ATTEMPTS.md](../ATTEMPTS.md) "The slack decomposition, the conditional identity repaired into an unconditional theorem": $S=T_1+2T_2+T_3$ with each $T_k$ the bracket Gram mass of one of (E1)–(E3), and "$S=0\iff$ all three grading conditions hold". [r699](REVIEW_r699.md) line 42 restates it with $X_{\mathrm{inv}}=0$ in place of $S=0$, using L154(i).
- **Closure into $\ker W$, new.** Nothing on the record proves $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ at an $S=0$ point. [Lemma L106](../findings/bounds.md) gets them from the extra hypothesis $\Delta=0$ and needs "trivial kernel"; [r515](REVIEW_r515.md)/[r516](REVIEW_r516.md) repaired L7 to "graded modulo $\ker W$" or "$\ker W=0$". The corollary's contribution is that at a critical point (and, by §3, whenever the blocks vanish) the kernel closes off by itself. That is worth stating as the headline, since it is what dissolves the "modulo $\ker W$" hedge that four record entries carry ([bounds.md](../findings/bounds.md) L7, [results.md:122](../results.md), INDEX-traps W1 and W4).
- **Operator level**, L154(i), Gate 2 passed, and §3 shows it needs no hypothesis.

## 8. $SU(3)$ by representation theory

$\mathfrak p=\mathfrak{su}(3)$ embedded in $\mathfrak{so}(8)$ through the adjoint representation, $\mathfrak m=\mathfrak p^\perp$ ([Lemma L23](../findings/ungraded-slack.md)'s member $W=\Pi_{\mathfrak h}-\tfrac{8}{28}I$, eigenvalues $\tfrac57$ on $\mathfrak p$ and $-\tfrac27$ on $\mathfrak m$, so $\mathfrak k=0$). As an $\mathfrak{su}(3)$-module $\Lambda^2\mathbf 8=\mathbf 8\oplus\mathbf{10}\oplus\overline{\mathbf{10}}$, so $\mathfrak m=\mathbf{10}\oplus\overline{\mathbf{10}}$, a 20-dimensional real irreducible. Then:

- $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$: subalgebra.
- $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$: $\mathfrak m$ is the orthogonal complement of a submodule under an invariant inner product, hence a submodule.
- $[\mathfrak m,\mathfrak m]\not\subseteq\mathfrak p$: otherwise $\mathfrak{so}(8)=\mathfrak p\oplus\mathfrak m$ would be a symmetric pair with fixed algebra $\mathfrak{su}(3)$ of dimension $8$; the fixed algebras of involutions of $\mathfrak{so}(8)$ are $\mathfrak{so}(p)\oplus\mathfrak{so}(8-p)$ (dimensions $21,16,13,12$), $\mathfrak u(4)$ ($16$) and their triality images $\mathfrak{spin}(7)$ ($21$), $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ ($13$), [INDEX-traps](../findings/INDEX-traps.md) W2, and none has dimension $8$. The leak is into $\mathfrak m$ itself, since $\langle[\mathfrak m,\mathfrak m],\mathfrak m\rangle$ is the invariant form's pairing of $\mathfrak m$ with $[\mathfrak m,\mathfrak m]$ and $[\mathfrak m,\mathfrak m]$ has a $\mathfrak p$-component by $\langle[\mathfrak m,\mathfrak m],\mathfrak p\rangle=\langle\mathfrak m,[\mathfrak m,\mathfrak p]\rangle=\langle\mathfrak m,\mathfrak m\rangle\ne0$, so both components are present and the whole leak is in the $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ clause.

"Fails only $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$" is **correct**.

## 9. "$J_5=0$ on the class regardless of $h$"

$J_5=\langle X_{\mathrm{inv}},\mathrm{Ric}^*h\rangle$ vanishes whenever $X_{\mathrm{inv}}=0$, for every $h$; the clause is a sufficiency statement and needs exactly $X_{\mathrm{inv}}=0$ for its proof. Weaker conditions suffice in principle ($X_{\mathrm{inv}}\perp\mathrm{Ric}^*h$), and the corollary claims none of them; the converse "$J_5=0$ only on the class" is open and [DERIVE-j5](DERIVE-j5.md) batch 3 says so. Since $h=\mathrm{Ric}(\lvert W\rvert)$ is a function of $W$, "whatever $h$ is" means "without the scalar-$h$ hypothesis of L154(ii)", and should be written that way.

## 10. What to change in the block

1. Drop "at a critical point" from the statement and prove it by §3's expansion; cite L154(i) as a consequence rather than an ingredient, and add to L154(i) that it holds for every symmetric $W$.
2. State the closure clause as the headline: at a critical point, L7's (E1)–(E3) force $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ through $P_0W^\#P_0=0$, so L7's "modulo $\ker W$" is retired; away from critical points the corollary's class is the strictly smaller one.
3. Say that the graded object is $\mathop{\mathrm{ran}}W$, possibly a proper subalgebra, with $W_{\mathbb{CP}^2}$ at $n=4$ ($\Lambda^2_+\cong\mathfrak{so}(3)$ graded as $(\mathfrak{so}(3),\mathfrak{so}(2))$) as the instance reconciling L7's caveat.
4. Name the $n=6$ object in the screen sentence; $W_{\mathbb{CP}^2}\oplus0$ is graded at every $n$.
5. Credit the trace-level class to [ATTEMPTS.md](../ATTEMPTS.md)'s $S=T_1+2T_2+T_3$.

**Deliverable: CONFIRMED with corrections; the hypothesis-free proof in §3 and the closure identity in §4 are the repairs.**
