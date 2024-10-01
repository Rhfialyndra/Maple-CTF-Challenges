from Crypto.Util.number import sieve_base
import re, math

with open("flag.txt", "rb") as f:
    flag = f.read().strip()
assert re.fullmatch(r"ictf\{[a-zA-Z0-9_]{23}\}", flag.decode())
secret = flag[5:-1]

p = 16772840378381243842066048784688853957423046860638774659798751363803587745626801644318311555716492505211797256362777839879035568112648021357575189005942639992451427473134669625140202260399749619120960708132141636534797458638157387694646733301916665038271994700044932407416439883675026706679040221556491794719771476834979296493099969411147296731792715449629105727787022814345378634690038383348758558254912695438400827004525431080873196634565104529212324504485921380380999261999944310601941742297981272042622308964121378662555829776023082112631490889049991032811467272985431102946180316750594939614734989949107285600303
y = math.prod(pow(g, x, p) for g, x in zip(sieve_base, secret)) % p
print(f"{y = }")
# y = 8165619110200055466911174863734022476964222634342154429921488714292166216674275714777856021123402845288083071741448805043611162670512667466505681857955606496579097145863411723181901391323408767795889523542146579745904274077147594288306481631566052226582434016215670471299408692870916079393753839590643715817218248509164398838992640421692048551418476063319719318318236376281528268220025363799730937112477604766981231635514978098146302146683466150777095894377934451240284453168414598831855811211881476319054160673186794043737305570265241390182234813323781344450725576880118168632694294034421914068296337196274778633258