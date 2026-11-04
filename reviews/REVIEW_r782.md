# Gate 2 review r782, L184, the coincident case at $\dim V=6$

*Cold brief: I worked from [BRIEF-g2-l184.md](BRIEF-g2-l184.md) and nothing else, and did not open [findings/](../findings/) for the answer. **No numerical work was done in the sense the standing rule reserves**, no search, sweep, census, optimisation or falsifier hunt. Every derivation below is closed form and every value exact. One **screen** was run, seconds of exact rational arithmetic on four 2-forms I wrote down myself, to re-check by machine the four identities I had already derived by hand; a second screen of the same size checked the coordinator's three-matchings witness. Both are reported as screens, in sections 5 and 13, and are cited for nothing positive. Log: [agent_logs/g2-l184-r782.log](../agent_logs/g2-l184-r782.log).*

*Two coordinator messages arrived mid-run. The first announcing the case-3 defect and its repair. **I had already found the same defect and the same repair, and the log records it one phase before the message.** Section 5 says so precisely and section 6 audits the repair as instructed. The second carried two additions to case 2; sections 12 and 13 audit them.*

## The claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | Hypothesis inventory complete and honest | **THREE UNSTATED, TWO STATED-AND-UNUSED** |
| 2 | $\omega_i$ commutes with $\omega_i^2$, hence preserves every eigenspace of $A$ | **CORRECT** |
| 2b | $A$ positive **definite** on $V$, trace $2$, and $\dim V=6$ gives it | **CORRECT, VIA AN UNSTATED STEP** |
| 2c | $A$'s eigenvalues are necessarily doubled | **CORRECT** |
| 3 | Case 1: a skew map preserving a plane is a multiple of its area form | **CORRECT** |
| 3b | Case 1: the same splitting for all three $\omega_i$, which is what Given C needs | **CORRECT** |
| 3c | Case 1's appeal to Given C | **CORRECT FOR EVEN $n$; PARITY STEP UNSTATED** |
| 4 | Case 2: $\star(J\wedge J)=2\epsilon_JJ$ on $\mathbb R^6$, orientation bookkeeping | **CORRECT** |
| 4b | Case 2: equal $J_i\wedge J_i$ forces $\epsilon_iJ_i$ all equal | **CORRECT** |
| 4c | Case 2: $\mathop{\mathrm{tr}}(K^2)=-6$, contradiction with orthogonality | **CORRECT; SIGN PROSE SLOPPY** |
| 5 | Case 3: $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ is the general form | **CORRECT** |
| 5b | "$J\wedge J=2\,\mathrm{vol}$ for every complex structure on a $4$-plane" | **FALSE, FOUND INDEPENDENTLY** |
| 5c | Whether that falsehood is load-bearing | **NOT LOAD-BEARING** |
| 6 | Case 3: the cross term forces $J_i=\sigma_iJ$ | **CORRECT, AND STRONGER: $\sigma_i=\tau_i$** |
| 6b | The coordinator's repair | **RIGHT, AND I WOULD HAVE (AND DID), FIND IT** |
| 7 | $\mathop{\mathrm{tr}}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$, both constants | **CORRECT** |
| 7b | Three signs with all pairwise products equal force that product $+1$ | **CORRECT** |
| 7c | Whence $4a=-2b$, impossible for $a,b>0$ | **CORRECT** |
| 8 | The three cases are exhaustive | **CORRECT** |
| 9 | No step assumes $\ker W=0$ | **CORRECT; ONE NOTATIONAL TRAP** |
| 10 | The boundary, $\dim V=4$, $\dim V\ge8$, odd $n$, small $n$ | **HONESTLY DRAWN, ONE GAP** |
| 11 | "What is left of I38 is one case: distinct and collinear at $\dim V\ge6$" | **OVERREACHES ITS OWN FINE PRINT** |
| 12 | Coordinator addition 1: case 2's contradiction is linear independence, not the trace | **RIGHT, AND A GENUINE WEAKENING** |
| 13 | Coordinator addition 2: the three-matchings witness fails equal wedges | **RIGHT, ALL THREE SELF-WEDGES DISTINCT** |
|, | **The lemma's statement** | **UPHELD ON CORRECTION** |

**Actionable in one line:** excise the false sentence "$J_i\wedge J_i=2\,\mathrm{vol}_Q$ for every complex structure on a $4$-plane", replace it with the component-wise reading of $\Lambda^4V=\Lambda^4Q\oplus(\Lambda^2Q\wedge\Lambda^2P)\oplus\cdots$ that carries the case anyway, and rewrite the closing box, which claims more than the block proves.

## 0. Conventions, fixed once

I use exactly the brief's normalisation and nothing else.

- A $2$-form and a real skew matrix are the same object under $f_a\wedge f_b\mapsto E_{ab}-E_{ba}$. This is the convention forced by the brief: it makes $\{f_a\wedge f_b\}_{a<b}$ orthonormal for $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$, since $-\tfrac12\mathop{\mathrm{tr}}((E_{ab}-E_{ba})^2)=1$. There is no stray factor of $2$ anywhere below, and I checked that the same convention makes $(f_1\wedge f_2)\wedge(f_3\wedge f_4)=f_1\wedge f_2\wedge f_3\wedge f_4$ and $(f_1\wedge f_2)^2=-\mathrm{Id}$ on the $12$-plane simultaneously.
- Orthonormality of the triple therefore reads $\mathop{\mathrm{tr}}(\omega_i\omega_j)=-2\delta_{ij}$.
- **Support** of $\omega$ is the image of its matrix; $V$ is the span of the three supports.
- $\varepsilon_P$ is a unit area form of an oriented plane $P$; as a matrix $\varepsilon_P^2=-\mathrm{Id}_P$ and $\mathop{\mathrm{tr}}(\varepsilon_P^2)=-2$.
- A **complex structure** on an even-dimensional Euclidean space means an orthogonal skew $J$ with $J^2=-\mathrm{Id}$; skew plus $J^2=-\mathrm{Id}$ already gives $J^{\mathsf T}J=-J^2=\mathrm{Id}$, so orthogonality is automatic and I will not restate it.
- $\star$ means the Hodge star **of $V$**, never of $\mathbb R^n$. Section 9 explains why the distinction is load-bearing.
- **None of $\sqrt{3/2}$, $\theta_0(12)=1.236033$, $6+2\sqrt7$ or the range "even $n\ge12$" appears anywhere in the block, and none is needed.** The brief asked me to say so; I say so. The block is pure linear algebra plus one appeal to [L181](../findings/diagonal-half.md).

## The hypothesis inventory

**Used and stated.**

- *Orthonormality of $\omega_1,\omega_2,\omega_3$.* Load-bearing twice: $\mathop{\mathrm{tr}}(\omega_i\omega_i)=-2$ fixes $\mathop{\mathrm{tr}}A=2$, and $\mathop{\mathrm{tr}}(\omega_i\omega_j)=0$ is the entire contradiction in cases 2 and 3.
- *Coincidence of the squares*, $\omega_1^2=\omega_2^2=\omega_3^2$. This is what makes $A$ well defined and common, which is what makes the eigenspace splitting common. Everything rests on it.
- *Coincidence of the self-wedges*, $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$. Used in cases 2 and 3, and (as section 3 shows), available to close case 1 too.
- *$\dim V=6$.* Used to make $A$ nonsingular on a six-space, hence to get the three-way case split, and used essentially in case 2 where $\star$ maps $\Lambda^4$ to $\Lambda^2$.
- *Given C.* Used once, in case 1.

**Stated and unused.**

- *Given A* and *Given B*. Neither is invoked. This is worth recording rather than merely noting: with coincident squares, Given A collapses to $\left(\sum_i\lambda_i\right)A=0$, hence $\sum_i\lambda_i=0$, and the block never needs even that. Cases 2 and 3 use no Weyl-theoretic input whatsoever, they are statements about orthonormal triples of $2$-forms and would hold verbatim with no tensor in sight. Case 1 is the only place a Weyl fact enters.
- *Given D*, correctly, as a fence rather than an ingredient.
- The eigenvalues $\lambda_i$ themselves, and the rank-three-ness, outside case 1.

**Used and unstated, the three that must be written in.**

1. **The three supports coincide, and equal $V$.** From $\omega_i\omega_i^{\mathsf T}=-\omega_i^2=A$ for each $i$, the image of $\omega_i$ equals the image of $A$, the same subspace for all three. Hence $V=\mathop{\mathrm{im}}A$ and $\dim V=\mathop{\mathrm{rank}}A=6$. Without this the phrase "$A$ ... positive definite of trace $2$ on $V$" is unearned, and case 2's Hodge star has no six-space to live on.
2. **$n$ even, or a padding argument, for case 1's use of Given C.** Given C wants an orthogonal decomposition of the *whole* of $\mathbb R^n$ into planes. Case 1 supplies three planes inside $V$; the remaining $n-6$ dimensions must also split into planes, which needs $n$ even. Section 10 gives the repair.
3. **$a,b>0$ strictly, in case 3.** Used to divide by $\sqrt{ab}\ne0$ at the cross term and again to call $4a=-2b$ impossible. It follows from positive definiteness, which follows from (1); the chain is real but is nowhere written.

## 1. The setup, item 2

**Does $\omega_i$ commuting with $\omega_i^2$ give that it preserves every eigenspace of $A$? Yes, and the reason is even shorter than the block's phrasing suggests.** $A$ is *defined* as the common value of $-\omega_i^2$. Each $\omega_i$ commutes with its own square, therefore with $A$; a matrix commuting with a symmetric matrix preserves each of its eigenspaces. The word "hence" in the block is doing honest work. The one thing the sentence hides is that the argument needs $A$ to be the *same* matrix for all three $i$, which is the hypothesis, so no harm, but a reader who forgets it will think each $\omega_i$ preserves only its own eigenspaces.

**Is $A$ positive definite rather than merely semidefinite, and does $\dim V=6$ give that?** On $\mathbb R^n$, $A=\omega_i\omega_i^{\mathsf T}$ is positive semidefinite with kernel $V^\perp$; on $V$ it is positive definite. The step that supplies this is unstated inventory item (1): $\mathop{\mathrm{im}}\omega_i=\mathop{\mathrm{im}}A$ for every $i$, so $V=\mathop{\mathrm{im}}A$ and $A|_V$ has trivial kernel. So the answer is yes, but $\dim V=6$ alone does not give it, the coincidence of the squares does, and $\dim V=6$ then fixes the rank.

Trace: $\mathop{\mathrm{tr}}A=\mathop{\mathrm{tr}}(\omega_i\omega_i^{\mathsf T})=-\mathop{\mathrm{tr}}(\omega_i^2)=2\lVert\omega_i\rVert^2=2$. Correct, and it matches Given A's "trace $2$".

**Are $A$'s eigenvalues necessarily doubled? Yes.** Let $E_\mu\subseteq V$ be the $\mu$-eigenspace, $\mu>0$. Each $\omega_i$ preserves $E_\mu$ and satisfies $(\omega_i|_{E_\mu})^2=-\mu\,\mathrm{Id}$, so $\omega_i|_{E_\mu}/\sqrt\mu$ is a complex structure on $E_\mu$, and a real vector space carrying a complex structure has even dimension. So **every** eigenvalue of $A|_V$ has even multiplicity. The block reaches the same place by the skew normal form $\pm\mathrm ic_j$, which is also correct; the eigenspace argument is the one that makes the *doubling* visible without choosing a normal form. Either way the answer to the brief's question is an unqualified yes, and it is what licenses writing the spectrum as three pairs $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$ with coincidences allowed. Note $c_1^2+c_2^2+c_3^2=1$ from $\mathop{\mathrm{tr}}A=2$.

## 2. Case 1, item 3

**"A skew map preserving a plane restricts to a multiple of its area form": correct.** The skew endomorphisms of a $2$-dimensional space form a $1$-dimensional space, spanned by $\varepsilon_{P_j}$. Combined with $(\omega_i|_{P_j})^2=-c_j^2\,\mathrm{Id}$ the multiple is pinned to $\pm c_j$, so $\omega_i=\sum_j s_{ij}c_j\varepsilon_j$ with $s_{ij}=\pm1$. Exactly as claimed.

**Does it give the same splitting for all three $\omega_i$, what Given C needs? Yes.** The planes $P_1,P_2,P_3$ are the eigenspaces of $A$, and $A$ does not depend on $i$. That is the whole content, and it is right. Given C additionally wants the $\varepsilon_j$ to be unit area forms of an orthogonal decomposition: the $P_j$ are eigenspaces of a symmetric matrix for distinct eigenvalues, hence mutually orthogonal. Fine.

**An observation, offered as a strengthening and not as a repair of any gap.** Case 1 does not need Given C at all. Equality of the self-wedges reads, for each pair $j<k$,
$$\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k,$$
and the $\varepsilon_j\wedge\varepsilon_k$ are linearly independent, so $s_{ij}s_{ik}$ is independent of $i$ for every pair. Fixing $j=1$ and putting $\eta_i=s_{i1}s_{11}$ gives $s_{ij}=s_{ij}s_{i1}s_{i1}=s_{1j}s_{11}s_{i1}=\eta_is_{1j}$ for all $j$, i.e. $\omega_i=\eta_i\omega_1$ with $\eta_i=\pm1$. Then $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\eta_1\eta_2\mathop{\mathrm{tr}}(\omega_1^2)=\mp2\ne0$, contradicting orthogonality. So case 1 closes by the same mechanism as cases 2 and 3 (the self-wedges pin the triple to a single form up to sign, and orthogonality kills it) and the whole lemma becomes independent of Given C, of Given A, of Given B, and of $n$'s parity. I record this because it removes unstated inventory item (2), not because case 1 as written is wrong: it is not.

## 3. Case 2, item 4

**The identity, derived independently.** Let $J$ be a complex structure on an oriented $6$-space $V$. Choose a $J$-adapted orthonormal frame $f_1,\dots,f_6$ with $Jf_1=f_2$, $Jf_3=f_4$, $Jf_5=f_6$; then $J=f_{12}+f_{34}+f_{56}$ as a $2$-form. Write $f_{123456}=\epsilon_J\,\mathrm{vol}_V$, so $\epsilon_J=+1$ when the adapted frame is positively oriented and $-1$ when it is not; this is well defined because any two $J$-adapted frames differ by an element of $U(3)\subset SO(6)$, which is connected and orientation-preserving. Now
$$J\wedge J=2(f_{1234}+f_{1256}+f_{3456}),$$
and taking $\star$ with respect to $\mathrm{vol}_V=\epsilon_Jf_{123456}$, so that $\star=\epsilon_J\star_f$ where $\star_f$ is the star of the frame's own orientation,
$$\star(J\wedge J)=\epsilon_J\cdot2(f_{56}+f_{34}+f_{12})=2\epsilon_J\,J.$$
That is the block's identity, orientation bookkeeping and all. **CORRECT.**

**Does equal $J_i\wedge J_i$ really force $\epsilon_iJ_i$ all equal, or something weaker?** It forces exactly that, and the step is airtight because $\star:\Lambda^4V\to\Lambda^2V$ is a linear isomorphism when $\dim V=6$. Applying it to $J_i\wedge J_i=J_j\wedge J_j$ gives $2\epsilon_iJ_i=2\epsilon_jJ_j$. So $K:=\epsilon_1J_1=\epsilon_2J_2=\epsilon_3J_3$ and $J_i=\epsilon_iK$, with $K$ a complex structure since $K^2=\epsilon_1^2J_1^2=-\mathrm{Id}$. Nothing weaker, nothing stronger. **CORRECT.**

**Is $\mathop{\mathrm{tr}}(K^2)=-6$? Yes**, immediately from $K^2=-\mathrm{Id}_V$ and $\dim V=6$. The scaling checks out too: $A=cI_6$ with $\mathop{\mathrm{tr}}A=2$ gives $c=1/3$, and $\omega_i\omega_i^{\mathsf T}=cI$ makes $J_i=\omega_i/\sqrt c$ orthogonal as well as skew.

**The contradiction.** $\mathop{\mathrm{tr}}(\omega_i\omega_j)=c\mathop{\mathrm{tr}}(J_iJ_j)=c\,\epsilon_i\epsilon_j\mathop{\mathrm{tr}}(K^2)=-6c\,\epsilon_i\epsilon_j=\mp2\ne0$, against orthogonality. Correct. The block writes "$\mathop{\mathrm{tr}}(J_iJ_j)=\mp\mathop{\mathrm{tr}}(K^2)=\pm6$", which has the signs the wrong way round relative to $J_iJ_j=\epsilon_i\epsilon_jK^2$, it should be $\pm\mathop{\mathrm{tr}}(K^2)=\mp6$. **Cosmetic only**: the conclusion drawn is "$\ne0$", which survives either reading. Worth fixing so a later reader does not chase it.

## 4. Case 3, the splitting, item 5

**Is $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ the general form? Yes.** With spectrum $a$ (multiplicity $4$, eigenspace $Q$) and $b$ (multiplicity $2$, eigenspace $P$), each $\omega_i$ preserves both, so as a $2$-form it lies in $\Lambda^2Q\oplus\Lambda^2P$. On $Q$: $(\omega_i|_Q)^2=-a\,\mathrm{Id}_Q$ with $a>0$, so $\omega_i|_Q=\sqrt a\,J_i$ with $J_i^2=-\mathrm{Id}_Q$, a complex structure on a $4$-plane. On $P$: skew on a plane is $t\varepsilon_P$, and $t^2=b$ gives $t=\tau_i\sqrt b$, $\tau_i=\pm1$ after a once-and-for-all choice of orientation on $P$. Nothing is missed. The trace normalisation is $4a+2b=2$.

**"Is $J\wedge J=2\,\mathrm{vol}$ for every complex structure on a $4$-plane, or only the self-dual ones?", only the self-dual ones. The block's sentence is FALSE, and I found this before the coordinator's message; my log records it at phase 5, the line above the line recording the message's arrival.**

The closed-form counterexample: on $Q$ with orthonormal frame $e_1,\dots,e_4$ and $\mathrm{vol}_Q=e_{1234}$, put $J^-=e_{12}-e_{34}$. As a matrix it is $\begin{psmallmatrix}0&1\\-1&0\end{psmallmatrix}$ on the $12$-plane and its negative on the $34$-plane, so $(J^-)^2=-\mathrm{Id}_Q$ and $J^-$ is a complex structure in exactly the sense used throughout. But
$$J^-\wedge J^-=2\,e_{12}\wedge(-e_{34})=-2\,e_{1234}=-2\,\mathrm{vol}_Q,$$
while the self-dual $J^+=e_{12}+e_{34}$ gives $+2\,\mathrm{vol}_Q$. The correct statement is $J\wedge J=2\eta_J\,\mathrm{vol}_Q$ with $\eta_J=\pm1$ according to whether a $J$-adapted frame is positively oriented, the $4$-dimensional shadow of the $\epsilon_J$ the block itself uses in case 2, which makes the omission the more surprising. This is the "likeliest break" the brief pointed at, and it is a genuine falsehood in the text.

**Is it load-bearing? No, and this is the part that decides the case's fate.** The block deploys the false sentence to justify "the cross term ... is the only part that varies with $i$". Grant the correction: the $\Lambda^4Q$ part $2a\eta_i\,\mathrm{vol}_Q$ may now vary with $i$. It does not matter, because $\Lambda^4Q$ and $\Lambda^2Q\wedge\Lambda^2P$ are **different summands** of $\Lambda^4V$, so equality of the self-wedges is equality in each summand separately, and the cross-term conclusion is reached without any claim about the $\Lambda^4Q$ part at all. The false sentence is scaffolding, not structure. (For the record, the $\Lambda^4Q$ equality then says $\eta_1=\eta_2=\eta_3$, which is automatic once $J_i=\sigma_iJ$ since $(-J)\wedge(-J)=J\wedge J$.)

## 5. The screen

Reported as a screen, cited for nothing. In exact rational arithmetic, on four $2$-forms I wrote down for the purpose, I re-checked by machine the four identities I had already derived by hand in sections 3 and 4: $J^+\wedge J^+=+2\,e_{1234}$ and $J^-\wedge J^-=-2\,e_{1234}$ on $\mathbb R^4$ with both squaring to $-\mathrm{Id}$ and both of trace $-4$; and on $\mathbb R^6$, $\star(K\wedge K)=+2K$ for $K=f_{12}+f_{34}+f_{56}$ and $\star(K'\wedge K')=-2K'$ for $K'=f_{12}+f_{34}-f_{56}$, both of trace $-6$. All four agreed with the hand derivations exactly. Seconds of compute, no search of any kind.

## 6. Case 3, the cross term, item 6, and the coordinator's repair

**Treated as unsupported and re-derived from scratch, as instructed.**

Decompose $\Lambda^4V$ for $V=Q\oplus P$ with $\dim Q=4$, $\dim P=2$:
$$\Lambda^4V=\Lambda^4Q\ \oplus\ (\Lambda^3Q\wedge\Lambda^1P)\ \oplus\ (\Lambda^2Q\wedge\Lambda^2P),$$
the remaining would-be summands vanishing because $\Lambda^kP=0$ for $k\ge3$. Writing $\alpha_i=\sqrt a\,J_i\in\Lambda^2Q$ and $\beta_i=\tau_i\sqrt b\,\varepsilon_P\in\Lambda^2P$, and using that $2$-forms commute under $\wedge$,
$$\omega_i\wedge\omega_i=\alpha_i\wedge\alpha_i+2\,\alpha_i\wedge\beta_i+\beta_i\wedge\beta_i=\underbrace{a\,J_i\wedge J_i}_{\Lambda^4Q}+\underbrace{2\tau_i\sqrt{ab}\;J_i\wedge\varepsilon_P}_{\Lambda^2Q\wedge\Lambda^2P}+0,$$
since $\varepsilon_P\wedge\varepsilon_P=0$ in $\Lambda^4$ ($\varepsilon_P$ is a $2$-form on a $2$-plane). The middle summand of the decomposition is empty here, so equality of the self-wedges across $i$ is exactly two independent equalities, one per occupied summand.

Take the second. The map $\Lambda^2Q\to\Lambda^2Q\wedge\Lambda^2P$, $\gamma\mapsto\gamma\wedge\varepsilon_P$, is a **linear isomorphism**, it carries the basis $\{e_{jk}\}_{j<k\le4}$ of $\Lambda^2Q$ to the basis $\{e_{jk}\wedge\varepsilon_P\}$ of the summand, so it is injective. And $\sqrt{ab}\ne0$ because $a,b>0$. Hence
$$\tau_1J_1=\tau_2J_2=\tau_3J_3=:J.$$
$J$ is a complex structure, being $\pm$ one. Therefore $J_i=\tau_iJ$ for each $i$.

**So yes: the cross term's vanishing difference forces $J_i=\sigma_iJ$ for one single $J$, not merely a constraint among the $J_i$.** It is a genuine rigidity, and its whole strength comes from the injectivity of $\wedge\varepsilon_P$ together with $a,b>0$. **CORRECT.**

**Two things the block leaves on the table, both in its favour.**

- The forced relation is $\sigma_i=\tau_i$ *exactly*, not merely $\sigma_i=\pm1$ independent of $\tau_i$. Hence $\rho_i=\sigma_i\tau_i=+1$ for all three $i$ with no sign-counting at all, and the identity of item 7 collapses in one line to $4a\tau_i\tau_j=-2b\tau_i\tau_j$, i.e. $4a=-2b$. The block's $\rho$ argument is a weaker route to the same place; it is valid (section 7), just not the shortest one.
- The $\Lambda^4Q$ equality is then automatic, as the coordinator says.

**On the repair.** It is right, on both halves: the correct identity is $J\wedge J=2\eta_J\,\mathrm{vol}_Q$, and the conclusion survives because the cross term sits in a summand of $\Lambda^4V$ complementary to $\Lambda^4Q$ and carries the rigidity by itself. **Would I have found it independently? I did.** The log's phase-5 line records the false sentence and the anti-self-dual counterexample $e_{12}-e_{34}$ one line before the line recording the coordinator's message; the counterexample I wrote is the same object, and the reason I gave for the conclusion surviving (different summands, so component-wise equality), is the same reason. I claim no credit for the repair beyond that, and I record the independence because the coordinator asked.

## 7. Case 3, the sign identity, item 7

**The constants, both of them.** With $J_i=\sigma_iJ$ and $\omega_i=\sqrt a\,\sigma_iJ\oplus\tau_i\sqrt b\,\varepsilon_P$, the product is block-diagonal and
$$\mathop{\mathrm{tr}}(\omega_i\omega_j)=a\,\sigma_i\sigma_j\mathop{\mathrm{tr}}(J^2)+b\,\tau_i\tau_j\mathop{\mathrm{tr}}(\varepsilon_P^2)=a\sigma_i\sigma_j(-4)+b\tau_i\tau_j(-2)=-4a\,\sigma_i\sigma_j-2b\,\tau_i\tau_j.$$
$\mathop{\mathrm{tr}}(J^2)=-4$ because $J^2=-\mathrm{Id}_Q$ on a $4$-plane; $\mathop{\mathrm{tr}}(\varepsilon_P^2)=-2$ because $\varepsilon_P^2=-\mathrm{Id}_P$ on a plane. **Both constants are right**, and both depend on the brief's normalisation, which I fixed in section 0 and did not change. Orthogonality $\mathop{\mathrm{tr}}(\omega_i\omega_j)=0$ for $i\ne j$ then reads
$$4a\,\sigma_i\sigma_j=-2b\,\tau_i\tau_j\qquad\text{at all three pairs.}$$

**The three-signs step.** Since $\tau_i\tau_j=\pm1$, dividing is multiplying, and the identity says $\rho_i\rho_j=\sigma_i\sigma_j\tau_i\tau_j$ equals the single constant $-b/(2a)$ at all three pairs $(1,2),(1,3),(2,3)$. Call it $\varepsilon$. Multiply the three:
$$\varepsilon^3=(\rho_1\rho_2)(\rho_1\rho_3)(\rho_2\rho_3)=\rho_1^2\rho_2^2\rho_3^2=1,$$
and a real cube root of $1$ is $1$, so $\varepsilon=+1$. **The step is correct as stated**, and it is the standard parity obstruction: three signs cannot have all three pairwise products equal to $-1$, because the product of the pairwise products is a square.

**Whence $4a=-2b$.** $\varepsilon=-b/(2a)=+1$ gives $-b=2a$, i.e. $4a=-2b$. With $a,b>0$ the left side is positive and the right negative. Contradiction. **CORRECT**, and doubly so: it also contradicts $4a+2b=2$, since $4a=-2b$ forces $\mathop{\mathrm{tr}}A=0\ne2$. Case 3 is empty.

## 8. Exhaustiveness, item 8

**The three cases are exhaustive, and nothing is missed.** By section 1, every eigenvalue of the positive definite $A|_V$ has even multiplicity, so the multiplicities form a partition of $6$ into even parts. There are exactly three: $2+2+2$ (case 1, $c_j^2$ pairwise distinct), $4+2$ (case 3, exactly two agree), $6$ (case 2, all three agree). No fourth configuration exists. The block's framing ("the three cases are set by how many of the $c_j^2$ agree"), is the same statement and is correct. The only latent ambiguity is that "exactly two agree" must mean multiplicity $4+2$ and not something about which two; it does, since $A$ is determined by its multiplicities up to labelling the eigenspaces, and the argument never uses which is which.

## 9. The kernel, item 9

**No step assumes $\ker W=0$, and the block is clean here.** Everything happens inside $V$; $V^\perp$ is the $0$-eigenspace of $A$ on $\mathbb R^n$, of dimension $n-6>0$ in the conjecture's range, and it is preserved by every $\omega_i$ (which annihilate it) without any of the arguments touching it.

**One notational trap, worth an explicit line in the file.** Case 2's $\star$ must be the Hodge star **of $V$**, not of $\mathbb R^n$. On $\mathbb R^n$ the star of a $4$-form is an $(n-4)$-form and the identity $\star(J\wedge J)=2\epsilon_JJ$ is not even type-correct. The step is legitimate because $\omega_i\wedge\omega_i\in\Lambda^4V$ for all three $i$ (which needs unstated inventory item (1), that the supports coincide and equal $V$) so the equality of the self-wedges is an equality in $\Lambda^4V$ and may be starred there. The block writes "on $\mathbb R^6$", which is $V$; a reader who reads it as the ambient space will think the case is broken when it is not.

## 10. The boundary, item 10

- **$\dim V=4$.** Correctly fenced by Given D; the block claims nothing there and exhibits nothing there, so no finding is being smuggled in by the back door.
- **$\dim V\ge8$.** The block's caveat is honest and the reasons are exactly right. Case 1's argument does survive whenever the $c_j^2$ are pairwise distinct, for any even $\dim V$, my section 2 side-derivation makes that transparent, since $\omega_i=\eta_i\omega_1$ follows in any dimension. Case 2's does **not** survive: $\star:\Lambda^4\to\Lambda^2$ is an isomorphism only at $\dim V=6$, and at $\dim V=8$ the identity is not type-correct, let alone true. Case 3's does not survive either: the whole argument turns on $Q$ being a $4$-plane, where $J\wedge J$ is a top form.
- **$\dim V$ odd, or $\dim V=2$.** Impossible; $\dim V$ is even by section 1, and $\dim V=2$ leaves a $1$-dimensional space of $2$-forms, which cannot hold an orthonormal triple.
- **Odd $n$, the one gap.** Case 1's appeal to Given C wants $\mathbb R^n$ decomposed into planes, which fails for odd $n$. The statement of L184 quantifies over $\mathcal W_n$ with no parity restriction, so as written the case-1 argument does not cover odd $n$. Two clean repairs exist and the block should name one: either restrict the statement to even $n$, or observe that the section 2 side-derivation closes case 1 by orthogonality alone with no decomposition of the ambient space at all. I flag the gap; I am not asked to choose the repair.
- **$n$ below the conjecture's range.** Nothing in the block depends on $n\ge12$; the argument is uniform in $n$ once $\dim V=6$ is fixed, which is a virtue. No threshold constant appears.

## 11. Overreach, item 11

**The closing box claims more than the block proves, and more than the block's own next sentence admits.** The bold headline says "**WHAT IS LEFT OF I38 IS ONE CASE.** *The images are distinct and collinear, at $\dim V\ge6$*", and the italic tail says "*Nothing here reaches $\dim V\ge8$, where case 1's argument still applies whenever the $c_j^2$ are pairwise distinct but the other two cases are untried.*" These two sentences contradict each other. The coincident case at $\dim V=8,10,\dots$ is untouched by anything above (case 2 and case 3 are both strictly six-dimensional arguments, as section 10 sets out) so the coincident case is **not** left with only the distinct-and-collinear case; it is left at every $\dim V\ge8$ except where the $c_j^2$ happen to be pairwise distinct.

A second, smaller inflation: "distinct" reads as pairwise distinct, but what the block closes is "all three coincide". Its complement includes the configuration where exactly two of the three images coincide, which is neither closed here nor covered by "distinct".

**What is entailed** by the block plus the givens is the narrower statement: *at $\dim V=6$, the coincident case is empty; what remains at $\dim V=6$ is the case where the images are not all equal; and at $\dim V\ge8$ only the pairwise-distinct-$c_j^2$ sub-case of the coincident case is closed.* The box should be rewritten to that. The mathematics is unaffected (this is a claim about the programme's ledger, not about the lemma) but a ledger row derived from the box as written would be wrong, and rows are what later work is built on.

## What would break it, and what I did to look

**The falsifier.** An orthonormal triple $\omega_1,\omega_2,\omega_3$ of $2$-forms on $\mathbb R^n$ whose common support is $6$-dimensional, with $\omega_1^2=\omega_2^2=\omega_3^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$, arising as the eigen-decomposition of a rank-three $W\in\mathcal W_n$. Exhibiting one would refute L184 outright, and it is the most valuable object the brief names.

**What I did.** Nothing that the standing rule reserves: no search, no sweep, no census, no falsifier hunt. I looked for it the only way the rule allows, analytically, by asking at each case whether the constraints leave room. They do not, and the reason is uniform across all three cases once section 2's side-derivation is in hand: **equality of the self-wedges pins the triple to a single $2$-form up to sign, and orthogonality then kills it.** In case 1 that is $\omega_i=\eta_i\omega_1$; in case 2 it is $J_i=\epsilon_iK$; in case 3 it is $J_i=\tau_iJ$ with the $P$-block sign locked to the same $\tau_i$. In each case the surviving family is $\{\pm\omega\}$, which contains no orthogonal pair, so the falsifier cannot exist at $\dim V=6$. Where I *would* look, if the programme ever approves it, is $\dim V=8$ with $A$'s spectrum $(a,a,a,a,b,b,b,b)$ or $(a^{\times6},b^{\times2})$, the two configurations where neither the $\star$ isomorphism of case 2 nor the top-form accident of case 3 is available. **I did not look there, and I record that as a reserved question rather than as an absence of evidence.**

## 12. Coordinator addition 1, case 2's contradiction is linear independence

**RIGHT, and it is a genuine weakening of what case 2 consumes, not merely a restatement.**

The chain: $\star:\Lambda^4V\to\Lambda^2V$ is injective at $\dim V=6$, so equal self-wedges give $\epsilon_iJ_i=\epsilon_jJ_j$ (section 3), hence $J_i=\epsilon_iK$, hence
$$\omega_i=\sqrt c\,J_i=\epsilon_i\sqrt c\,K=\epsilon_i\epsilon_1\,\omega_1=\pm\,\omega_1 .$$
Exactly $\pm\omega_1$, with no residue. The three forms then span a line, so $\dim\mathop{\mathrm{span}}\{\omega_1,\omega_2,\omega_3\}=1$ and $W$ has rank one, against rank three. **Correct.**

Why it is a real weakening. The block's route consumes *orthogonality*, $\mathop{\mathrm{tr}}(\omega_i\omega_j)=0$; this route consumes only *linear independence* of the three eigen-$2$-forms, which they have for free, being distinct members of an eigenbasis, whether or not one has normalised or orthogonalised them. So case 2 survives the removal of every metric hypothesis on the triple beyond $A$ being scalar. It also drops the normalisation $c=1/3$, which was never load-bearing: any $c>0$ does. The identity $\mathop{\mathrm{tr}}(K^2)=-6$ and the figure $\pm6$ become decorative, which incidentally retires the cosmetic sign slip I flagged at item 4c, the sentence carrying it can simply go.

Two supporting points in the addition, both correct as stated. **$\epsilon_J$ is well defined because $U(3)\subset SO(6)$ is connected**: any two $J$-adapted orthonormal frames differ by an element of $U(3)$, which lies in the identity component of $O(6)$, so all adapted frames share an orientation and $\epsilon_J$ depends on $J$ and the ambient orientation alone. I gave the same argument independently at section 3. **The closure reaches nothing outside $\dim V=6$**: the injectivity of $\star$ on $\Lambda^4$ into $\Lambda^2$ is a dimension count, $\binom{6}{4}=\binom{6}{2}$, and it fails at every other even dimension, at $\dim V=8$ one has $\binom84=70$ against $\binom82=28$ and $\star$ maps $\Lambda^4$ to itself. So the addition claims no more reach than the block had, and I confirm it claims no less.

## 13. Coordinator addition 2, the three-matchings witness

**RIGHT. The three do fail equal wedges, and by the widest possible margin: their three self-wedges have pairwise disjoint supports in the basis of $\Lambda^4$, so no two of them agree.** The case is not endangered.

The objects, with the coordinator's indices. $J_1=e_{12}+e_{34}+e_{56}$, $J_2=e_{13}+e_{25}+e_{46}$, $J_3=e_{14}+e_{26}+e_{35}$, from three perfect matchings of $\{1,\dots,6\}$ that pairwise share no edge, nine distinct pairs out of the fifteen available.

*The premises hold.* Each $J_k$ is block-diagonal with three $2\times2$ rotation blocks on the pairs of its matching, so $J_k^2=-\mathrm{Id}$ and $A_k=\mathrm{Id}$ for all three: **equal scalar squares**, which is case 2's hypothesis on the squares. For $k\ne l$, $(J_kJ_l)_{aa}=\sum_b(J_k)_{ab}(J_l)_{ba}$ needs $\{a,b\}$ to be an edge of both matchings; disjointness kills every term, so $\mathop{\mathrm{tr}}(J_kJ_l)=0$. And $\lVert J_k\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(J_k^2)=3$, so $J_k/\sqrt3$ is a unit orthonormal triple. Every step of the coordinator's construction checks out.

*The wedges differ.* Wedging two edges of one matching gives the basis $4$-form on the complement of the third edge, with a sign from the sort:
$$J_1\wedge J_1=2\left(e_{1234}+e_{1256}+e_{3456}\right),$$
$$J_2\wedge J_2=2\left(-e_{1235}+e_{1346}-e_{2456}\right),$$
$$J_3\wedge J_3=2\left(-e_{1246}-e_{1345}+e_{2356}\right).$$
The three index sets $\{1234,1256,3456\}$, $\{1235,1346,2456\}$, $\{1246,1345,2356\}$ are pairwise disjoint and every coefficient is $\pm2\ne0$, so the three self-wedges are pairwise distinct, indeed pairwise orthogonal in $\Lambda^4$. **No two share a wedge, so the witness does not touch the case.**

*What the witness establishes, stated positively.* Case 2's hypothesis on the squares is far from vacuous but is on its own far from sufficient: orthonormal triples with $A$ scalar exist in abundance at $\dim V=6$, and it is the wedge hypothesis alone that empties the case. That is a useful sharpening of where the case's strength lives, and it is consistent with everything in sections 3 and 12, under equal wedges the surviving family is $\{\pm K\}$, and the matchings escape only because their wedges differ.

*Screen.* Reported as a screen and cited for nothing positive: in exact rational arithmetic on the three forms above I re-checked $J_k^2=-\mathrm{Id}$, $\lVert J_k\rVert^2=3$, $\mathop{\mathrm{tr}}(J_kJ_l)=0$ for all three pairs, and the three self-wedges just displayed. The machine agreed with the hand computation term for term, including every sign. Seconds of compute, no search.

## Overall verdict

**UPHELD ON CORRECTION.** The statement of L184 is true, and after the case-3 repair every step of the argument is sound. But the block as originally written contained one false mathematical sentence, and the file needs four edits before the row is worth anything:

1. **Excise** "$J_i\wedge J_i=2\,\mathrm{vol}_Q$ for every complex structure on a $4$-plane". It is false ($J^-=e_{12}-e_{34}$ is a complex structure with $J^-\wedge J^-=-2\,\mathrm{vol}_Q$) and it should be replaced by the component-wise reading of $\Lambda^4V=\Lambda^4Q\oplus(\Lambda^2Q\wedge\Lambda^2P)$, which carries the case without any claim about the $\Lambda^4Q$ part. **The repair is right and the conclusion survives**; I reached the same defect and the same repair before the coordinator's message, and section 6 gives the derivation in full.
2. **Write in the three unstated hypotheses**: that the supports coincide and equal $V$ (without which $A$ is not positive definite and $\star$ has no six-space); that case 1's Given C needs $n$ even; that $a,b>0$ strictly.
3. **Fix the two cosmetic sign errors**: case 2's $\mp\mathop{\mathrm{tr}}(K^2)=\pm6$ should be $\pm\mathop{\mathrm{tr}}(K^2)=\mp6$; and case 3 may as well record $\sigma_i=\tau_i$, which makes the $\rho$ argument unnecessary.
4. **Rewrite the closing box**, which contradicts its own fine print by declaring the coincident case closed while admitting that $\dim V\ge8$ is untried.

**On the coordinator's two additions to case 2, checked at sections 12 and 13: both are right.** The linear-independence route is correct and strictly cheaper than the trace route, it consumes only that the eigen-$2$-forms are independent, drops the normalisation, and retires edit 3's first half by deleting the sentence that carried the sign slip. The three-matchings witness is correctly constructed and correctly fails the wedge hypothesis: its three self-wedges have pairwise disjoint supports in $\Lambda^4$, so it endangers nothing and usefully shows that all of case 2's strength sits in the wedge rather than the square.

I add, as a strengthening rather than a repair: **the lemma needs no Weyl-theoretic input at all.** Given A, Given B and Given C are unused or removable (case 1 closes by orthogonality alone (section 2)) so what is actually proved is the sharper and more portable statement that *no orthonormal triple of $2$-forms with a common $6$-dimensional support has both its squares and its self-wedges coincident.* That is a better lemma than the one on file, and it costs nothing to state.
