# r215: a FOURTH route -- the O(12) decomposition computed DIRECTLY, never
# passing through SO(12).  This is what settles whether any block is a
# det-twist, because Littlewood's restriction rule hands back O(n) labels.
#
# ch(Weyl_12) = s_{2,2} - s_2 as a character of O(12), since S^{(2,2)}(V)
# restricts to [2,2] + [2] + [0] and Sym^2(V) to [2] + [0].
# Sym^3 of it is the plethysm h_3[s_{2,2} - s_2].
# Littlewood: s_lambda|_{O(n)} = sum_mu (sum_{beta all parts even} c^lambda_{mu beta}) [mu],
# valid for l(lambda) <= n/2 = 6, so the multiplicity of [mu] in a character F is
#     m_mu = < F , s_mu * B >,  B = sum over partitions beta with all parts even of s_beta.
import time, json
Sym = SymmetricFunctions(QQ); s = Sym.schur(); h = Sym.homogeneous()
t0 = time.time()
W = s[2,2] - s[2]
print("dim check, W at 12 variables:", s(W).expand(12)(*([1]*12)))
F = s(h[3].plethysm(W))
print("Sym^3 character built [%.0fs]; degrees present:" % (time.time()-t0),
      sorted(set(sum(la) for la, c in F)))
print("max rows over all constituents:", max(len(la) for la, c in F))
print("dim at 12 variables:", F.expand(12)(*([1]*12)))

B = s(0)
for d in range(0, 13, 2):
    for beta in Partitions(d):
        if all(x % 2 == 0 for x in beta): B += s(beta)
print("B built [%.0fs]" % (time.time()-t0))

res = {}
for d in range(0, 13):
    for mu in Partitions(d):
        if len(mu) > 6: continue
        m = F.scalar(s(mu) * B)
        if m: res[tuple(mu)] = ZZ(m)
print("\nO(12) blocks: %d, total multiplicity %d [%.0fs]"
      % (len(res), sum(res.values()), time.time()-t0))
neg = {k: v for k, v in res.items() if v < 0}
print("negative multiplicities:", neg)
print("max rows among O(12) labels:", max(len(k) for k in res))
json.dump({",".join(map(str,k)): int(v) for k, v in res.items()},
          open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/o12_blocks.json","w"))
for k in sorted(res): print("   ", k, res[k])
