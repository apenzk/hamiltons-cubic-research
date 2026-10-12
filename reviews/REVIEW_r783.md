# Review r783, L184's strengthened statement, and case 1's Weyl-free route

*Cold brief: [BRIEF-g2-l184b.md](BRIEF-g2-l184b.md) was the whole of my input, and [findings/](../findings/) and [results.md](../results.md) were not opened. **No numerical work was done; every value below is exact and derived by hand.** Log: [agent_logs/g2-l184b-r783.log](../agent_logs/g2-l184b-r783.log).*

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1a | The strengthened statement is true: no orthonormal triple with common $6$-dimensional support has coincident squares and coincident self-wedges, with no Weyl hypothesis | **CONFIRMED** |
| 1b | "No Weyl hypothesis is used anywhere", read against the block *as written* | **REFUTED AS WRITTEN**, case 1's body still ends in [L181](BRIEF-g2-l184b.md) and concludes $W=0$ |
| 2a | $s_{ij}s_{ik}$ is well defined and equal wedges make it independent of $i$ | **CONFIRMED** |
| 2b | That independence gives $\omega_i=\eta_i\omega_1$ exactly, not something weaker | **CONFIRMED** |
| 2c | The constant: $\operatorname{tr}(\omega_1\omega_2)=\mp2$ | **CONFIRMED**, sign pairing included |
| 3a | The common mechanism $\omega_i=\pm\omega_1$ holds in case 3 | **CONFIRMED**, it follows in one line the body does not take |
| 3b | "$\sigma_i=\tau_i$ outright" | **CHOICE-DEPENDENT**, the invariant statement is $\rho_i$ constant |
| 4 | The strengthening loses nothing for the rank-three corollary | **HYPOTHESIS-DEBT**, $\Phi$ is nowhere defined, so the bridge is not on file |
| 5 | Case 1 is complete without the premise | **REFUTED AS WRITTEN**, the replacement route lives only in a callout |
| 6 | Parity: is there any odd-$n$ restriction | **NONE ANYWHERE, CONFIRMED**, with one mis-stated parenthetical named |
| 7a | Case 2's identity holds at $\dim V=6$ and nowhere else | **CONFIRMED** |
| 7b | No step confuses $\dim V$ with $n$ | **DEFECT**, the entailment box says "$n=6$" where it means $\dim V=6$ |
| 8 | The kernel: no step assumes the triple spans more than it does | **CLEAN** |
| 9 | The three cases are exhaustive for the strengthened statement | **CONFIRMED** |
| 10 | Overreach | **ONE**, "at $\dim V\ge8$ only case 1 survives" is loose enough to mislead a ledger row |

**Actionable in one line:** the strengthened statement is true and case 1's Weyl-free route survives an independent derivation intact, but that route is not written into case 1, whose body still invokes [L181](BRIEF-g2-l184b.md) and still concludes $W=0$, so the block does not yet prove the statement it announces.

## 0. Conventions, fixed once

- $\langle\alpha,\beta\rangle=-\tfrac12\operatorname{tr}(\alpha\beta)$ and $\lVert\omega\rVert^2=-\tfrac12\operatorname{tr}(\omega^2)$, as the brief fixes them. So an orthonormal family satisfies $\operatorname{tr}(\omega_i^2)=-2$ and $\operatorname{tr}(\omega_i\omega_j)=0$ for $i\ne j$.
- For a plane $P$ with orthonormal basis $f_1,f_2$, the unit area form $\varepsilon_P=f_1\wedge f_2$ is the skew matrix with $\varepsilon_{12}=1$, so $\varepsilon_P^2=-\mathrm{Id}_P$, $\operatorname{tr}(\varepsilon_P^2)=-2$ and $\lVert\varepsilon_P\rVert^2=1$. This is the normalisation the block's arithmetic uses throughout, and it is consistent.
- $e_{a_1\dots a_k}$ denotes $f_{a_1}\wedge\dots\wedge f_{a_k}$.
- $V$ is the common support, $\dim V=6$; $\omega_i$ restricted to $V$ is skew and invertible, and $\omega_i$ preserves $V$ and $V^\perp$.

## 1. The hypothesis inventory

Everything used across the three cases, listed so that item 1 can be answered by inspection of the list:

| Hypothesis | Where used | Weyl content |
|---|---|---|
| $\omega_1,\omega_2,\omega_3$ orthonormal in $\Lambda^2\mathbb R^n$ | case 1 final step, case 2 final step, case 3 final step | none |
| Common support $V$, $\dim V=6$ | setup; case 2's use of $\star_V$; case 3's $4+2$ splitting | none |
| $\omega_1^2=\omega_2^2=\omega_3^2$ | setup, all three cases | none |
| $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$ | cases 1, 2, 3 | none |
| $\star_V:\Lambda^4V\to\Lambda^2V$ is injective | case 2 | none |
| [L181](BRIEF-g2-l184b.md), Ricci-flatness, first Bianchi, $W\in\mathcal W_n$ | **case 1's body, as the step that produces its conclusion** | **all of it** |

The first five entries carry no Weyl content whatever, and sections 3 to 5 below show that the first five suffice. The sixth entry is the defect: it is still in the text.

## 2. Item 9 first, exhaustiveness, since the later items depend on it

Set $A=-\omega_i^2$, common by hypothesis. $A$ is symmetric positive semidefinite ($\langle Ax,x\rangle=\lVert\omega_ix\rVert^2$) with $\operatorname{im}A=\omega_i(\operatorname{im}\omega_i)=V$, so $A|_V$ is positive definite and $A|_{V^\perp}=0$. Its trace is fixed: $\operatorname{tr}A=-\operatorname{tr}(\omega_i^2)=2\lVert\omega_i\rVert^2=2$.

$\omega_i|_V$ is skew and invertible, so its eigenvalues are $\pm\mathrm ic$ with $c\ne0$ in conjugate pairs, and each positive eigenvalue $c^2$ of $A|_V$ has even multiplicity. The even partitions of $6$ are $2+2+2$, $4+2$ and $6$, which are exactly cases 1, 3 and 2. **Exhaustive, and no Weyl tensor is consulted to make the split.** Item 9 is confirmed, and confirmed in the form the strengthened statement needs: the case division is a fact about a single positive definite $A$ of even multiplicities, not about a spectrum some Weyl condition constrained.

Two constraints fall out of $\operatorname{tr}A=2$ that the block uses in one place and omits in another: case 2 gets $6c=2$, hence $c=\tfrac13$ (stated), and case 3 gets $4a+2b=2$, hence $2a+b=1$ (not stated). The omission is harmless (case 3's contradiction is $4a=-2b$ with $a,b>0$, which needs only positivity) but the relation is worth carrying, since it makes the incompatibility numerical as well as sign-theoretic: $2a+b=1$ and $2a=-b$ together give $0=1$.

## 3. Item 2, case 1's Weyl-free route, derived from scratch

This is the round's reason for existing, so I derive it without consulting the block's phrasing beyond the statement to be checked.

**The block structure.** In case 1 the three eigenvalues $c_1^2,c_2^2,c_3^2$ of $A|_V$ are pairwise distinct, each of multiplicity two, so the eigenspaces are three specific planes $P_1,P_2,P_3$ with $V=P_1\oplus P_2\oplus P_3$ orthogonally. Each $\omega_i$ commutes with $\omega_i^2=-A$ and hence preserves each $P_j$. A skew endomorphism of a plane is a real multiple of that plane's area form, so $\omega_i|_{P_j}=t_{ij}\varepsilon_j$ for a chosen unit area form $\varepsilon_j$ of $P_j$; and $\omega_i^2|_{P_j}=-t_{ij}^2\mathrm{Id}_{P_j}$ must equal $-c_j^2\mathrm{Id}_{P_j}$, so $t_{ij}=s_{ij}c_j$ with $s_{ij}\in\{+1,-1\}$ and $c_j>0$. Hence
$$\omega_i=\sum_{j=1}^3 s_{ij}c_j\varepsilon_j,\qquad s_{ij}=\pm1 .$$
As a check, $\lVert\omega_i\rVert^2=\sum_jc_j^2=\tfrac12\operatorname{tr}A=1$, as orthonormality demands.

**Is $s_{ij}s_{ik}$ well defined?** Not absolutely, and this needs saying because the block does not. Each $\varepsilon_j$ is fixed only up to sign, and replacing $\varepsilon_j$ by $-\varepsilon_j$ flips $s_{ij}$ **for every $i$ at once**. So no single $s_{ij}$ is canonical, and neither is a single product $s_{ij}s_{ik}$. What *is* invariant under every such flip is (i) the assertion "$s_{ij}s_{ik}$ takes the same value at $i=1,2,3$", both sides flipping together, and (ii) the sign $\eta_i=s_{i1}s_{11}$, in which the ambiguity of $\varepsilon_1$ cancels. Both the hypothesis and the conclusion of the step are therefore choice-independent, and the step is legitimate once a choice of the $\varepsilon_j$ is fixed and held. **Confirmed, with the caveat made explicit.**

**The wedge.** Each $\varepsilon_j$ is decomposable, so $\varepsilon_j\wedge\varepsilon_j=0$, and
$$\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}\,c_jc_k\;\varepsilon_j\wedge\varepsilon_k .$$
The three products $\varepsilon_1\wedge\varepsilon_2$, $\varepsilon_1\wedge\varepsilon_3$, $\varepsilon_2\wedge\varepsilon_3$ have pairwise disjoint supports among the six coordinates of $V$ and are therefore linearly independent in $\Lambda^4V$. Equality of the three self-wedges is thus equality of coefficients pair by pair:
$$s_{1j}s_{1k}\,c_jc_k=s_{2j}s_{2k}\,c_jc_k=s_{3j}s_{3k}\,c_jc_k\qquad(j<k).$$
Since $A|_V$ is positive definite, $c_jc_k>0$, so it cancels and $s_{ij}s_{ik}$ is independent of $i$ for each $j<k$. **The independence-of-$i$ step is right**, and its two hidden requirements (the $c_j$ nonzero, the $\varepsilon_j\wedge\varepsilon_k$ independent), both hold for reasons already in the setup.

**Does it give $\omega_i=\eta_i\omega_1$, or something weaker?** It gives exactly that. Put $\eta_i=s_{i1}s_{11}\in\{\pm1\}$. For $j=1$: $\eta_is_{11}=s_{i1}s_{11}^2=s_{i1}$. For $j\in\{2,3\}$: the pair $(1,j)$ gives $s_{i1}s_{ij}=s_{11}s_{1j}$, and multiplying through by $s_{i1}$ gives $s_{ij}=s_{i1}s_{11}s_{1j}=\eta_is_{1j}$. So $s_{ij}=\eta_is_{1j}$ for **all** $j$, whence
$$\omega_i=\sum_j s_{ij}c_j\varepsilon_j=\eta_i\sum_j s_{1j}c_j\varepsilon_j=\eta_i\,\omega_1 .$$
Nothing weaker: the conclusion is a strict proportionality with a sign, not a proportionality up to a permutation of the planes or a relation among the $c_j$. The three pairwise relations are exactly enough, with $m$ planes one gets $m-1$ independent relations from the pairs $(1,j)$ and the remaining $\binom{m-1}2$ are consequences, which is why the argument is not overdetermined and does not silently need a fourth plane. **Confirmed.**

**The constant.** With $\omega_2=\eta_2\omega_1$,
$$\operatorname{tr}(\omega_1\omega_2)=\eta_2\operatorname{tr}(\omega_1^2)=\eta_2\cdot(-2\lVert\omega_1\rVert^2)=-2\eta_2 ,$$
so $\eta_2=+1$ gives $-2$ and $\eta_2=-1$ gives $+2$: the block's "$\omega_i=\eta_i\omega_1$ and $\operatorname{tr}(\omega_1\omega_2)=\mp2$" pairs the signs correctly, and $\mp2\ne0$ contradicts orthogonality. Equivalently and more directly, $\langle\omega_1,\omega_2\rangle=\eta_2\ne0$. **The constant is right, in magnitude and in its sign pairing.**

**Weyl content of this route: none.** It used the common $6$-dimensional support, the equal squares, the equal wedges, and the orthogonality of one pair. Trace-freeness, the first Bianchi identity and the Riemann symmetries appear nowhere, and neither does $n$.

## 4. Items 1 and 5, but the route is not in case 1

Item 5 asks me to verify that case 1's own argument is complete without the premise. **It is not, as written.** The case 1 paragraph quoted in the brief reads, in order: the parenthetical about positive definiteness; a sentence asserting that "case 1 no longer appeals to Given C at all"; the derivation of the common block structure; and then, as its final and only concluding step, *"[Lemma L181](BRIEF-g2-l184b.md) then gives $W=0$. $\square$"*.

So the paragraph both denies and performs the appeal. Three consequences, and they are not cosmetic:

- **The body proves a different statement.** [L181](BRIEF-g2-l184b.md)'s conclusion is $W=0$ for a $W\in\mathcal W_n$. A triple of $2$-forms with no Weyl tensor attached is outside its hypotheses entirely, so the body's last step cannot close the strengthened statement even in principle, there is no $W$ for it to annihilate.
- **The strengthened statement's own headline is false against the text.** "No Weyl hypothesis is used anywhere" is contradicted by the sixth row of my hypothesis inventory. The mathematics of section 3 rescues the statement; the block does not contain that mathematics in the place where the proof runs.
- **The route survives only as a clause in a callout.** The whole of the Weyl-free argument on file is the phrase *"equal wedges make $s_{ij}s_{ik}$ independent of $i$, so $\omega_i=\eta_i\omega_1$ and $\operatorname{tr}(\omega_1\omega_2)=\mp2\ne0$"* in the mechanism box. That is a correct summary (I reconstructed the same derivation from it, and it came out sound) but a summary in a box is not the case's proof, and a later reader following the case will follow it to [L181](BRIEF-g2-l184b.md).

**Verdict on items 1 and 5.** The strengthened statement is *true* (item 1a: confirmed, by sections 2, 3, 5 and 6 together, all Weyl-free). The claim that the block as written establishes it without a Weyl hypothesis is *false* (item 1b, item 5: refuted as written). The repair is to move section 3's derivation into case 1's body and delete its last sentence; I am not making that repair, this round exists because the last reviewer supplied rather than checked.

I note without acting on it that even after the repair, the old route remains available and correct for the Weyl corollary: case 1 exhibits three forms block-diagonal for $V=P_1\oplus P_2\oplus P_3$ together with the remainder $P_0=V^\perp$, which is precisely [L181](BRIEF-g2-l184b.md)'s hypothesis. The two routes are both sound; only one of them is Weyl-free, and the block must pick.

## 5. Item 3, the common mechanism, and whether case 3 really reaches it

Case 3 has $A|_V$ with eigenvalue $a$ of multiplicity four on a $4$-plane $Q$ and $b$ of multiplicity two on a plane $P$, $a\ne b$, both positive. Each $\omega_i$ preserves $Q$ and $P$, so $\omega_i|_Q=\sqrt a\,J_i$ with $J_i^2=-\mathrm{Id}_Q$ and $\omega_i|_P=\tau_i\sqrt b\,\varepsilon_P$ with $\tau_i=\pm1$. As a $2$-form, $\omega_i=\sqrt a\,J_i+\tau_i\sqrt b\,\varepsilon_P$, and
$$\omega_i\wedge\omega_i=a\,J_i\wedge J_i+2\tau_i\sqrt{ab}\;J_i\wedge\varepsilon_P+b\,\varepsilon_P\wedge\varepsilon_P,$$
the last term vanishing by decomposability. The first term lies in $\Lambda^4Q$ and the second in $\Lambda^2Q\wedge\Lambda^2P$, independent summands of $\Lambda^4V$, so equality of the wedges splits into two independent equalities. The cross term: $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective on $\Lambda^2Q$, and $\sqrt{ab}>0$, so equality across $i$ gives $\tau_1J_1=\tau_2J_2=\tau_3J_3$.

**So the mechanism claim is true of case 3.** Writing $J$ for the common value $\tau_1J_1$ (itself a complex structure, since $(-J_1)^2=J_1^2$), we get $J_i=\tau_iJ$ and therefore
$$\omega_i=\sqrt a\,\tau_iJ+\tau_i\sqrt b\,\varepsilon_P=\tau_i\big(\sqrt a\,J+\sqrt b\,\varepsilon_P\big)=\tau_i\tau_1\,\omega_1 .$$
The $4$-plane part and the $2$-plane part carry **the same** sign $\tau_i$, which is exactly why the two statements the brief distinguishes collapse into one here. The box's "the hypotheses force $\omega_i=\pm\omega_1$ in all three cases" is therefore accurate, and case 3's contradiction can be had in one further line as $\langle\omega_1,\omega_2\rangle=\pm1\ne0$, a line the body does not take, running the trace identity instead. That is a stylistic gap, not an error: the body's route is also correct, as the next paragraph confirms.

**The body's own route, checked.** With $\operatorname{tr}(J^2)=-4$ on the $4$-plane and $\operatorname{tr}(\varepsilon_P^2)=-2$,
$$\operatorname{tr}(\omega_i\omega_j)=a\operatorname{tr}(J_iJ_j)+\tau_i\tau_j\,b\operatorname{tr}(\varepsilon_P^2)=-4a\,\sigma_i\sigma_j-2b\,\tau_i\tau_j ,$$
so orthogonality reads $4a\,\sigma_i\sigma_j=-2b\,\tau_i\tau_j$ at all three pairs, as the block states. Setting $\rho_i=\sigma_i\tau_i$, the ratio $\sigma_i\sigma_j/(\tau_i\tau_j)=\rho_i\rho_j$ must be one constant $k$ across the three pairs; multiplying the three relations gives $(\rho_1\rho_2\rho_3)^2=k^3$, so $k^3=1$ and $k=+1$, whence $4a=-2b$, impossible for $a,b>0$. **The three-signs step is correct**, and so is the block's remark that $\sigma_i=\tau_i$ makes it unnecessary.

**Sub-finding 3b, and it is small but real.** "In fact $\sigma_i=\tau_i$" is choice-dependent. The common value of $\tau_iJ_i$ can be named $J$ or $-J$; the first naming gives $\sigma_i=\tau_i$ and $\rho_i=+1$, the second gives $\sigma_i=-\tau_i$ and $\rho_i=-1$. The invariant content of the cross-term step is that **$\rho_i$ is constant in $i$**, from which $\rho_i\rho_j=+1$ and $4a=-2b$ follow either way. The block should say "$\rho_i$ is constant, hence $+1$ after the harmless normalisation $J:=\tau_1J_1$" rather than "$\sigma_i=\tau_i$ outright". The conclusion is unaffected.

**The $\Lambda^4Q$ half, and the sequencing claim.** $J\wedge J=2\eta\,\mathrm{vol}_Q$ with $\eta=\pm1$: for $J=e_{12}+e_{34}$, $J\wedge J=2e_{1234}$, and for $J=e_{12}-e_{34}$, $J\wedge J=-2e_{1234}$. **So the correction to "$+2$ always" is right.** The block's claim that the sequencing is load-bearing is also right: read alone, $a\,J_i\wedge J_i$ equal says $\eta_1=\eta_2=\eta_3$, a genuine restriction on the three complex structures; read after the cross term has given $J_i=\tau_iJ$, it is vacuous because $(-J)\wedge(-J)=J\wedge J$. Both halves of that assessment check out.

## 6. Items 7 and 2's neighbour, case 2, and the $\dim V$ against $n$ question

Case 2 has $A|_V=c\,\mathrm{Id}_V$ with $6c=\operatorname{tr}A=2$, so $c=\tfrac13$ and $J_i=\sqrt3\,\omega_i$ satisfies $J_i^2=-\mathrm{Id}_V$; being skew as well, $J_i^{\mathsf T}J_i=-J_i^2=\mathrm{Id}$, so each $J_i$ is an orthogonal complex structure. The block's "unit norm forces $c=\tfrac13$, so $c$ is not a free parameter" is correct.

**The identity, verified in closed form.** With $\mathrm{vol}_V=e_{123456}$ and $J=e_{12}+e_{34}+e_{56}$: $J\wedge J=2(e_{1234}+e_{1256}+e_{3456})$, and $\star e_{1234}=e_{56}$, $\star e_{1256}=e_{34}$, $\star e_{3456}=e_{12}$ (each because the complementary product returns $+\mathrm{vol}_V$; for $e_{1256}\wedge e_{34}$ the block transposition is even). So $\star_V(J\wedge J)=2J$, i.e. $\epsilon_J=+1$. For the opposite orientation, $J'=e_{12}+e_{34}-e_{56}$ gives $J'\wedge J'=2(e_{1234}-e_{1256}-e_{3456})$ and $\star_V(J'\wedge J')=2(e_{56}-e_{34}-e_{12})=-2J'$, i.e. $\epsilon_{J'}=-1$. Every orthogonal complex structure on $V$ is $SO(V)$-conjugate to one of these two, and $\star_V$ is $SO(V)$-equivariant, so $\star_V(J\wedge J)=2\epsilon_JJ$ with $\epsilon_J=\pm1$ according to orientation. **The identity and its sign are confirmed, and the block's appeal to the connectedness of $U(3)\subset SO(6)$ for well-definedness is sound.** $\star_V$ is an isomorphism $\Lambda^2V\to\Lambda^4V$, so equal wedges give $\epsilon_iJ_i$ all equal, hence $J_i=\pm K$, hence $\omega_i=\pm\omega_1$; both the block's exits (linear independence, or $\langle\omega_1,\omega_2\rangle=\pm1$), close it.

**Item 7a: at $\dim V=6$ and nowhere else. Confirmed.** $\star_V$ carries $\Lambda^4V$ to $\Lambda^{\dim V-4}V$, which is $\Lambda^2V$ only when $\dim V=6$; the dimension count $\binom{2m}4=\binom{2m}2$ likewise holds at $2m=6$ ($15=15$) and fails at $2m=8$ ($70\ne28$) and beyond. The block's statement is exact.

**Item 7b: one residual conflation, in the entailment box rather than in case 2.** Case 2's body is scrupulous, "The Hodge star here is $V$'s, not $\mathbb R^n$'s", "the constraint is on $\dim V$ and not on $n$", and its use is legitimate: $\omega_i\in\Lambda^2V$, so $\omega_i\wedge\omega_i\in\Lambda^4V$, and equality in $\Lambda^4\mathbb R^n$ is equality in $\Lambda^4V$, after which $\star_V$ may be applied. But the closing entailment box then says *"cases 2 and 3 being strictly six-dimensional, the first because $\star(J\wedge J)$ lands in $\Lambda^2$ only at $n=6$"*, **"$n=6$" where the correct statement is $\dim V=6$**, which is the precise error the case-2 body was written to correct and which the box's own next clause ("the second because its splitting is $4+2$", a $\dim V$ statement) does not repeat. This is a defect in the box, not in the proof, but it is the sentence a ledger row would be copied from.

## 7. Item 6, parity

**There is no parity restriction anywhere.** Three places to look, and all three are clean:

- **In the premise.** [L181](BRIEF-g2-l184b.md) as quoted carries the remainder summand $P_0$ of unrestricted dimension, so $n=2m+\dim P_0$ with $\dim P_0$ free; $n$ odd is admitted. Its proof never touches $\dim P_0$: the Ricci half reads off the diagonal blocks on the $P_j$ and gives $0=0$ on $P_0$, since every $\omega_i$ is supported in $P_1\oplus\dots\oplus P_m$; the Bianchi half lives in the span of the $\varepsilon_j\wedge\varepsilon_k$ and has no $P_0$ component. The remainder is inert, and the earlier reviewers who said so were right. The step $\Lambda=M(M^{\mathsf T}\Lambda M)M^{\mathsf T}$ under $MM^{\mathsf T}=I_r$ is pure linear algebra with no dimension in it.
- **In case 1's new route.** Section 3 runs entirely inside $V$; $n$ does not appear.
- **Elsewhere.** Case 2 constrains $\dim V=6$ and case 3 constrains the splitting of $V$ to $4+2$; neither says anything about $n$, and in particular nothing here wants $4\mid n$, which the block's own three-matchings remark also observes.

**One mis-stated parenthetical, and it is the shape of the phantom debt.** Case 1 says of $A$ that "its multiplicities are all even, which is exactly when such an $A$ is realisable". Read over $\mathbb R^n$ this is false for odd $n$: the zero eigenvalue has multiplicity $n-6$, which is odd when $n$ is. The true statement is that **the multiplicities of $A$'s nonzero eigenvalues** are all even, which together with positive semidefiniteness is exactly the realisability criterion for $A=-\omega^2$ with $\omega$ skew, the kernel's dimension being unconstrained. I flag it because a reader who takes the parenthetical at face value manufactures precisely the odd-$n$ debt that this round was convened to dispose of. **The fix is two words; I am not making it.**

## 8. Item 8, the kernel

**Clean.** $\ker\omega_i=V^\perp$ is nonzero whenever $n>6$, and no step needs it to vanish. The setup's "$A$ has spectrum $\{c_1^2,c_1^2,\dots\}$" is a statement about $A|_V$ and should say so, but case 1's parenthetical supplies the missing "$V=\operatorname{im}A$" that makes it read correctly. Every subsequent object lives in $V$: the eigenplanes $P_j\subset V$, the wedges in $\Lambda^4V$, the star $\star_V$, the splitting $Q\oplus P=V$. The independence facts invoked, the $\varepsilon_j\wedge\varepsilon_k$ in case 1, the $\Lambda^4Q$ against $\Lambda^2Q\wedge\Lambda^2P$ split in case 3, are independence within $\Lambda^4V$, which is what is needed and is implied by, rather than implying, independence in $\Lambda^4\mathbb R^n$. **No step assumes the triple spans more than the six dimensions it spans.**

## 9. Item 4, what the strengthening costs the corollary

**Direction of the logic: nothing is lost.** The strengthened statement has strictly fewer hypotheses and the same conclusion shape, so anything the Weyl-conditioned version closed, it closes. Combined with [L183](BRIEF-g2-l184b.md) (a rank-three Weyl tensor *is* an orthonormal triple), "no such triple exists" yields "no such rank-three $W$ exists" immediately.

**But the bridge is not on file, and that is the finding.** The corollary is stated as *"no rank-three $W\in\mathcal W_n$ with $\dim V=6$ whose three images under $\Phi$ coincide"*. **$\Phi$ is never defined in the brief**, and the strengthened statement's hypotheses are two *separate* coincidences, of the squares and of the self-wedges. Whether "the three images under $\Phi$ coincide" is the same condition as "the squares coincide and the self-wedges coincide" is exactly the step that carries the general statement to the corollary, and there is no argument for it in what I was given. **Verdict `HYPOTHESIS-DEBT`: this claim has no argument on file.** I am not guessing at $\Phi$ and I am not supplying the bridge; naming it is the whole of what this round permits.

**One thing genuinely given up, recorded so it is not discovered later.** [L181](BRIEF-g2-l184b.md) concludes $W=0$ for *any* simultaneously block-diagonal $W$, at any rank and any number of blocks. Case 1's Weyl-free route concludes only that no orthonormal *triple* with these coincidences exists, it says nothing about a $W$ of rank other than three, and nothing about $W$ vanishing. Nothing in this block needs the stronger form, and the corollary as stated does not. But if any downstream row was taken from case 1's old conclusion "$W=0$" rather than from "the case is empty", that row rests on [L181](BRIEF-g2-l184b.md) and not on the strengthened statement.

I also record that [L181](BRIEF-g2-l184b.md) itself rests on [L179](BRIEF-g2-l184b.md) and [L180](BRIEF-g2-l184b.md), neither of which was quoted to me; I took its two "By L17x" steps as given, as the brief's framing requires. After the repair of section 4 this dependence leaves case 1 altogether.

## 10. Item 10, overreach

**Two, one of them already covered.** The first is item 1b: "No Weyl hypothesis is used anywhere" overreaches the text, though not the mathematics.

The second is in the entailment box: *"At $\dim V\ge8$ only case 1 survives, the pairwise-distinct-$c_j^2$ sub-case."* This is loose in a way that could be copied wrongly:

- The three-case taxonomy is a taxonomy of the even partitions of **six**. At $\dim V=8$ the even partitions are $2{+}2{+}2{+}2$, $4{+}2{+}2$, $4{+}4$, $6{+}2$ and $8$, five strata, of which only the first is "case 1" in any sense and only the last is "case 2" in any sense. **The intermediate strata such as $4{+}2{+}2$ and $6{+}2$ are neither, and nothing in this block touches them.**
- The case-1 *argument* does generalise cleanly to the all-multiplicities-two stratum at any $\dim V=2m$ with $m\ge2$: the derivation in section 3 uses only that the $c_j$ are distinct and positive and that the $\varepsilon_j\wedge\varepsilon_k$ are independent, and the relations from the pairs $(1,j)$ still give $\omega_i=\eta_i\omega_1$. So "case 1's argument survives" is true.
- What is not true, and what the sentence can be read as saying, is that the coincident case at $\dim V\ge8$ reduces to case 1. It does not: it opens onto strata this block never addresses.

Given that this very box carries the block's own warning about an inflated reading being folded into a ledger row, the sentence should say which stratum survives and that the mixed strata at $\dim V\ge8$ are open. **I name it; I do not rewrite it.**

## 11. A screen, and an observation

**Screen (permitted: seconds, by hand, on objects I constructed for the purpose, exact, and evidence for nothing positive).** I recomputed the three-matchings witness the block attributes to [r780](REVIEW_r780.md), because case 2's claim that the wedge alone does the work rests on it. With $J_1=e_{12}+e_{34}+e_{56}$, $J_2=e_{13}+e_{25}+e_{46}$, $J_3=e_{14}+e_{26}+e_{35}$: the nine edges are distinct, so $\operatorname{tr}(J_kJ_l)=\sum_{a,b}(J_k)_{ab}(J_l)_{ba}$ vanishes termwise for $k\ne l$; each $J_k$ is block-diagonal in disjoint index pairs so $J_k^2=-\mathrm{Id}_6$; and $\lVert J_k\rVert^2=3$. The self-wedges come out as
$$J_1\wedge J_1=2(e_{1234}+e_{1256}+e_{3456}),\quad J_2\wedge J_2=2(-e_{1235}+e_{1346}-e_{2456}),\quad J_3\wedge J_3=2(-e_{1246}-e_{1345}+e_{2356}),$$
agreeing with the block sign for sign, the three negative signs arise from single transpositions ($1325\to1235$, $2546\to2456$, $1426\to1246$, $1435\to1345$) and $2635\to2356$ is even, hence positive. The nine $4$-sets are distinct, so the three wedges are pairwise orthogonal and in particular unequal. A further consistency screen: $J_k/\sqrt3$ has $A=\tfrac13\mathrm{Id}_6$, which is case 2's forced $c=\tfrac13$. **The witness stands as stated, and case 2's "the wedge alone does the work" is not empty.**

**Observation, deliberately not folded and not a repair.** Every one of the three contradictions in fact uses only a *pair*: case 1 needs $\langle\omega_1,\omega_2\rangle=\eta_2\ne0$; case 2's $\star$-injectivity gives $J_2=\pm J_1$ from two forms; case 3's cross term gives $\tau_1J_1=\tau_2J_2$ from two forms. The third form enters only in case 2's alternative exit through linear independence. So the arguments on file appear to prove the stronger *pair* statement. I record this as an observation about where the argument's strength lies, **not** as a strengthening to be adopted: it has had no adversarial audit, and this round exists because a reviewer folded in an unaudited improvement.

## 12. What would break it, and what I did to look

**The falsifier.** An orthonormal pair or triple $\omega_1,\omega_2,\omega_3\in\Lambda^2\mathbb R^n$ with a common support $V$ of dimension exactly six, satisfying $\omega_1^2=\omega_2^2=\omega_3^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$, with at least two of the forms not equal up to sign. No Weyl tensor need be attached, that is what the strengthening claims.

**What I did to look, and it was not a search.** Searching is reserved under the standing rule and I did none. Instead I closed the space by hand: the only free datum is the multiplicity pattern of $A|_V$, and section 2 shows that pattern must be an even partition of six, of which there are three. Each case is then an equality between components lying in independent summands of $\Lambda^4V$, so each case's closure is a finite sign argument rather than an estimate with room in it. A falsifier would have to live in a fourth case, and there is no fourth case. The nearest object that exists is the three-matchings triple of section 11: orthonormal, common support $\mathbb R^6$, equal squares, and pairwise-orthogonal self-wedges, so it fails the wedge hypothesis maximally rather than narrowly. That is the closest approach I can exhibit in closed form, and it is on the wrong side by a wide margin.

**Constants that should not appear, and do not.** The conjecture's range even $n\ge12$, the threshold $\sqrt{3/2}$ and the crossover $6+2\sqrt7$ appear nowhere in any argument in this block. The only sighting is a cross-reference to [L178](BRIEF-g2-l184b.md)'s title inside the premise's commentary, which is a pointer and not a step.

## Overall verdict

**`SOUND-BUT-UNWRITTEN`.**

The mathematics is right and the strengthened statement is true. I derived case 1's Weyl-free route from scratch without leaning on the block's phrasing, and every part of it holds: $s_{ij}s_{ik}$ is well defined once the area forms are fixed and the claim about it is invariant under that choice, the independence-of-$i$ step is correct and needs only $c_jc_k>0$ and the independence of the $\varepsilon_j\wedge\varepsilon_k$, it yields $\omega_i=\eta_i\omega_1$ **exactly** rather than anything weaker, and the constant $\mp2$ is right including which sign goes with which. The three cases are exhaustive over the even partitions of six with no Weyl input, none of the three uses trace-freeness, first Bianchi or the Riemann symmetries, there is no parity restriction in the premise or in any case, no step confuses $\dim V$ with $n$ inside the proofs, no step assumes the triple spans more than $V$, and the common mechanism $\omega_i=\pm\omega_1$ really does hold in case 3, the $4$-plane and $2$-plane parts carry the same sign, which is what makes the two statements the brief distinguishes coincide.

What I will not sign is that the block establishes this. **Case 1's body still ends in [L181](BRIEF-g2-l184b.md) and still concludes $W=0$**, a statement about a Weyl tensor the strengthened lemma does not have, while the Weyl-free route exists only as a clause inside a callout box. A block whose headline says "no Weyl hypothesis is used anywhere" and whose case 1 uses one is not merely untidy: it is a proof of the old statement wearing the new statement's title. Alongside it: the bridge $\Phi$ that carries the general statement to the rank-three corollary has **no argument on file** (`HYPOTHESIS-DEBT`); the entailment box repeats the $\dim V$/$n$ conflation the case-2 body was written to correct; case 1's "its multiplicities are all even" is false as written for odd $n$ and is the exact shape of the phantom parity debt this round was convened to dispose of; "at $\dim V\ge8$ only case 1 survives" is loose enough to hide the untouched $4{+}2{+}2$ and $6{+}2$ strata; and "$\sigma_i=\tau_i$ outright" is choice-dependent where "$\rho_i$ constant" is not.

None of these five sinks the statement. All five are in the text a later row would be copied from, and the first of them means the strengthened statement is presently **claimed rather than proved in the place it is claimed**. I have named each and repaired none.
