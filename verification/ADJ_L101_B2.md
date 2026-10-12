# Adjudication brief, round L101, step B2

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From the clause "vanishing on the diagonal and reaching $0.91$ off it" in Passage A.

**The step: the quantity $T(x,y,[\rho(A),u])$ of the displayed general form attains the value $0.91$ for some $x\in V_\lambda$, $y\in V_\mu$ with $\lambda\ne\mu$ and some $A$, as the passages define these objects.**

## Passage A, the heading and the lemma as the block carries it ([findings/route-a.md](../findings/route-a.md) lines 423 and 441-449)

#### Lemma L101, the $SO(n)$-invariance identity, and $P\equiv0$ on $V_{1/2}$, $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\!\cdot\!x,y\rangle$, giving $Q(x)\perp T_u(SO(n).u)$ for every eigenvector in every dimension

**A fifth, separate statement is proven, though it does not tighten the bound.** The trilinear form $T$ is $SO(n)$-invariant, so differentiating along $\exp(tA)$ gives $T(A\!\cdot\!x,y,z)+T(x,A\!\cdot\!y,z)+T(x,y,A\!\cdot\!z)=0$. Setting $y=x$, $z=u$ and using $A\!\cdot\!u=[A,u]$,

$$T(x,x,[A,u])=-2\,T(A\!\cdot\!x,x,u)=-2\lambda\,\langle A\!\cdot\!x,x\rangle=0,$$

since $F_u$ is symmetric with $F_ux=\lambda x$ and the derivation $X\mapsto[\rho(A),X]$ is Frobenius-skew. So $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$, in every dimension, with no hypothesis, and the argument never uses criticality of $u$. The general form is exact:

$$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle\qquad (x\in V_\lambda,\;y\in V_\mu),$$

vanishing on the diagonal and reaching $0.91$ off it. It also gives $P\equiv0$ on $V_{1/2}$.

## Passage B, the record's definitions ([findings/conventions.md](../findings/conventions.md) lines 24, 64 and 136)

| $T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined at all, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$, the $\#$ part because permuting the arguments permutes the slots of two totally antisymmetric $c$'s at sign $(-1)^2$. **It was tabled nowhere while the letter already carried the bracket tensor $T_{\alpha\beta\gamma}$ and [L35](../findings/stratum-two-negative.md)'s cap $\tfrac{2\sqrt2}3A$** | [second-order.md](../findings/second-order.md) |

- **The competitor's operator and its blocks**: $u=W_{\mathbb{CP}^2}$ padded to unit norm, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$, and $F_\lambda$ its restriction to the multiplicity space $M_\lambda$ of the $SO(n-4)$-isotypic $M_\lambda\otimes V_\lambda$. **$\alpha$ in [L21](../findings/route-a.md) and [L20](../findings/route-a.md) is $\sqrt{2/3}\langle F_uV,V\rangle$**, a Rayleigh quotient transverse to $\mathbb Ru$ and the orbit, *not the $\alpha$ parametrising the competitor family $W_{\mathcal S^4(\alpha)}$ in the same file.*

- **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

## Passage C, the eigenspaces of $F_u$ in the section the lemma sits in ([findings/route-a.md](../findings/route-a.md) lines 404, 406 and 408)

**The subdivision is exact, and it is a theorem.** In Remark 4.18's decomposition $W=\cos\beta\,W_1+\sin\beta\,W_2$, the admissible space splits as $(\mathbb Ru\oplus T_u\mathcal O)^\perp=V_{1/3}\oplus V_{\le0}$ with nothing else possible, $\mathrm{mult}(+1)=1$ and $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$ ($26,34,42,50$ at $n=10,12,14,16$), which follows from Theorem 4.14(a),(b) with Remark 4.16 rather than being a numerical coincidence. Writing $W_2=c_0K+c_-N$ with $K\in\ker F_u$ and $N$ in the strictly negative part, and $\mu_N=\langle FN,N\rangle/\theta^*\in[-1,-\tfrac16]$, the identity

$$\alpha=\tfrac{1-s^2}{3}+s^2c_-^2\mu_N,\qquad s=\sin\beta,$$

is exact: the cross term vanishes because $F_uW_1=\tfrac13\theta^*W_1$ and $W_1\perp W_2$. Hence $s^2\le6\varepsilon/(3-c_0^2)$ with $\varepsilon=\tfrac13-\alpha$.

## Passage D, Lemma L21's statement, a given for the eigenvalues of $F_u$ transverse to the orbit ([findings/route-a.md](../findings/route-a.md) line 174)

**Statement.** Let $n\ge9$, $m=n-4$, and let $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, of unit norm with $\theta^*=P(u)=\sqrt{3/2}$. Write $F_u(h)=\tfrac12(uh+hu)+u\#h$ and $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ for a unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$. Then $\alpha\le\tfrac13$, and $\tfrac13$ is attained.

## Definitions and sources

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$. $SO(n)$ acts on $\mathcal W_n$ by conjugation through its action $\rho$ on $\Lambda^2\mathbb R^n$.
- $V_\lambda$ denotes an eigenspace of $F_u$ on $\mathcal W_n$, and $T_u(SO(n).u)$ the tangent space to the orbit of $u$.
- Lemma L21 is a given, as quoted. [Nienhaus's notes](../references/nienhaus-2023-second-best-einstein/notes.md) may be read at source where a step needs Theorem 4.14 or Remark 4.16.
- The lemma has **no entry in [results.md](../results.md)**.
- **This task does no numerical work.** Write no scripts and run no computations. An argument or an exact closed form settles the question, and a decimal is not an argument.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit in closed form exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Return a verdict of VALID or FAILS, with the argument.
