p = 176158282986746982240266723315539113194265645059289946167508170177003284015952246598622309007383783776431677319511900896550770656954421845455806488352793716430680038822335053544732829075484400828106842292496259374352682656329951651195556343598920389869481201735312755104126688354313796523263368135288804198807
target = 156068260753162326389131601053013379068481891260689073819373386976988711198991229988977057135239333025127264023815862892705566458896325300327267083685162030794665611354092408411934601042942303873251991350025956054000540414510537241391337611736612951252775259439088010202728989041330968193636085468063887251970
M = matrix(GF(p), [[1, 3], [3, 7]])
od = product([p ^ 2 - p ^ i for i in range(2)])
u, v = M ^ -power_mod(2, (1 << 1337), od) * vector([target, 1])
r = u / v % p
print(r)
L = matrix(ZZ, [[r, 1], [p, 0]])
x, y = map(abs, L.LLL()[0])
print(x, y)

for i in range(100):
    flag = int(i * x).to_bytes(16, "big") + int(i * y).to_bytes(16, "big")
    if flag.startswith(b"ictf"):
        print(flag)
        break