from lll_cvp import polynomials_to_matrix, flatter
from Crypto.Util.number import long_to_bytes
import itertools

pubkey = (
    88216370061299009909082910895489690109443380839341558005155157042153360991345225459011082487751250955566526655860996785049707931702072733256690460958764780385955511758674610787767129469848784463769410033618651539296480505969664761874734154410455934903725534556978409081842768523141075914455333161622396842231849989097888345056905385788063595536393501447301282059948825749082026695239379094264901852181096812801570858922690190631926971673775849977795024170344585840426013461442923101618413476892225262097079099285754087755822321223068811008975853304232298294301108287200591663016274339100934257091727848514850489161121514654988706727045323327238674211371527423188610414512153159368355971978159997301105508469858985166264140149586056671439899716284782226581871870698129312480893448455312135778413489757568372686575646686876592641239729334297390477425906764130721379267979403088350414915953186972325774463808719194205787369890728881697130874272043645283020880093537442020234504408952102520183201509952771467858859795880291267811669461703096358990650210346540687857942397193732848818189351038188046882984324330758909712217047618636840138951510447538878948281821499704938923012875012159241337861652477878226684673562865570774444826875920132152952056777877161245378484454160301612950953372729173989444790622718325364429683217331775408541274317691789776115495454162175531232721955493575250486665373369370551646832654499202398099172947714487561454333690328019189119281617656331038721252787912753809490582372814675646681191963155683815679010140675507338004692654458604773837952892897418968485842851545114244095687688419019306128875109382059747555219697665886799274625456466139301230403164336107953042251750758022453115207155738830158993547386199655668613129430143275627995043251591330707093381244108434271599697582976926329567338754601519512121757870535677344956219197021659990314713993015165940529178366746183616821140161118464442510224285892306525188619595191160728148070906955498778489529076156162490728697078940626219980851641210101151596742909823009854337635061889197885891225417442477271097651775228385327843331803619350646200356166070046305728312145274582616654939603740725962476772528578871353288305303766891251637750896663433972947348398326181258494496430414047346246482819457377730887953432885918906754459040487293117261442291222477604423364572054758403879223852174528807130349960095472900894237673566716322409775243677293205613608915639757074906998690789609678631996209860800641129994795389726831808717873557696599696482579707150724969391662284581493215244786887312330658873599663900268229347726823646048520375899763350287779706283815248656974877680560991057079643069023048940163297630083241653629615787398527625281390114959720223480199095257358832245460517976786913190321075220851019177578863753961839508193369255449440047235712312738925640470947657743672755728948057866209471094086820252802968337655366822975514724830922330710910902235744273201939922434748160689866265546051406339442908251149509864530038628658422406795362565146339435945884671381198711748385605100153884397041,
    52111838923184700792096008079210803623643824283292048407278239196030516018027879878642827454224665133288669927918230052710144529333147298917479163491033371561536461766568173459214383059351130724867585308553507767295821273039274836705638839544061810546108934467210252161338098363040171126125571544542359585633116620812126631234813007967318349701859716838243420706648353440522835736162290118981983843488075248489316105036582395072956517359095460173595845342793134369840654947905072370923818744682945695670078759023493829327140488662606858071292160050853042109245200769433133038982909630626412835681260167033971759124964658538816230889957093268313274712681187500734545202037132597689548867201302106542089230267777772660784498806768425570671475470158896328561567942103926122789588718852248721667546915069470843756658373270948384681284210422701459405654634586728506647946007893780294594060712590679049239197314931735506196037400555066991237037027473089910076840392106276570485920556894612197935007134153429404909725059507920265892789578546780258196194418035701731939975167472332285540160937310177404543164025126682402146769090103677166192145661025868239509163009120845182258732615812194637059560189645609900512456649935897966990535268642249854826817598471432648324497963428846579003075847428872823815315402717186064223943838175701880703395905129833129020240590871465670247031794321359484565007179423567671250787317762764809129715745563889407051466497219770039001608262973838841985157340728129262937917549863682618318788000849747358100235590389913515527343032475201409141148122384305714784105878126474472515856107042152071402031227106065590175033868242808638802162399505430120792678367956186400213455087418239663493565790970162152063721327414738899496582942443535799652599851845625304940933742346186075955002223657846136568157291428901702620450897646324473170524248838345310700521828876831844802013375018103583751811078894771352386984477827069249319962793661153099038620432152847884928603941880041110776039919173915596236517919396590759975441519057426540069693496852326842253471029202982186417649487619635645392259467716821854144476221773262145679178476960147862742113010573175718067136052801532612679079943401327251551025068378904562394648894664538963464148879399905828534396187579963126258957292644080902088178050983918961452675878247313238581251552998791716672211555565981279335951443162462046384667311067703063570509191615537975838088692892457911122407615178121522634948298216671985977157082360290643948368904348666272858754670344319879370492849209289563191514712321799409741447962379005463388610677408531352898268986859053224175823553961429390848817809905199117521850384501383487818280425524284579417308457992607154366375474227053888665623095455620189996586749305747867207642990864281463785635172143264300470068890369048154854059628920360717080939571588034511236474216235540596988022424594322782654652652466837091254425317595537874067114370461281113845809143899650695126739392969984111827159626342362933733913054205732218205689662537552479243182902569417781490315929714582381404853,
)
enc = (
    74369734020358797248100280172074716405878003815858576256759863179414212171282740739983704502153226658760773222935126382963428839871321074066039356826575596766715678146766080801503655312193163878665406630332970269499895384733528446278338930270232411954517740162890019342667761789574731931913044597124654685136370361926365080811228558093719166846888622807339665179839165817695854493115922433608636692473602181929043492850733788143700772994493822723683723657870478506150572871085477095722577423477289600217785085175525138393511544456258356182170991388547195880900412186578340348331886230203836660000332708542334552577518158420558161739355175678652006200635788372931242234496341960537895943572578759373288889126363554464624656843886184167390169966291839070901188594523201676745884717580975522708682584964213818476495675133467593834925044923973794384079043126810370928905581113744522388970334247718448458613277709531097301389824730526242983795219836922335616818127841306284981808520032208694120544486455059857753543614977984385733100777416713472999044783572205761873519884586008330928420762608035664152427757296834670732498645206179685886696032088970453894773638407547538003998755275486459482407821112852744687471548755198344777904869969202879549299687879564372834232905057262789066488392850325757471442255639596104408868048096636423382211009984271838391858298587455169916975819935857641389047570220771170621928148989167788652716724518198196774797337576451946889791285235889828955518588337507629893364531538391211316325930297183892154163423023464176118353563409731283619372189477783682958679665969201550025239911408567006128776244040249074960848980772416649663204162169755906932311251006247145597911001296830256910797230805431481558970245105295316490276807516712505190810145201316934157900989322994121604174516797260367062484294922080246886058352253224844109963913146835102021164420076868228162465013718236303411010789102579987709411457620946062836324024900679641337315188867021957356188932982202656946834881456157696289424315240716152157690490176277990748389069766865162945726195491482582227041764561492115858106444683351720208197695929548533385022491027444370965143649441731593045988103968212179354620630954518846281466842220653230805300663201723764761853428518769991847764810093349881382288101246514627125999234542280365610355431435951660352231563812326024245378139379239219777326707256762653203038201787085016837696532090539254339465470160546017174020210908361717931975575545954944705828350109174934249533961772507469139608397820384342204940198155209249224024762063157581814267001100005022215673318888608360743660125008034154011854740566903350848443579662480003129707494888298943022293343415021857934900228707456026650205577106925518987100470630277449246102226138878712699845843078888266557744488351378776444598521554874229472696869239038325643347210853280820920371176880923696726262207900836889610621156919702681623844512570720390323145691168165312775240573186268534921230566122652890145608607685521497151916047631663565257846781607715203675076620690779237907944100517635246005988,
    42821271996551333838278337462352827462853452501143080037234528124854055484420371551019349656219497314266698483694397046770867139170551633796805462123551250811877920956637092392127535599036197431841963463622499678945188530564238189531886941195225890772978628596621767318323663584941378994459929199074463666251822280445776616751814609034642095445329808413588536854444484869972516585391785970143607895475927272740971061584022718398056257101324743614365356454114967615031538722225839762423595027853754442863483629381581935493187493513426022934745744437000917921415882807092128486483422337168441160479892902428962114988637461114624207478825836195430984225192539619752855681370915605371536335307575566014178599787865212114907489967533036508686533625586009496589852371508244962403051676153830510763698514509901863216677376868071522280219391450069175133353006899683369274531260835275730055334872761964594542767294046455872980988583171845051689118267566339548234755895171283992101014720359311564621396673355900154602670508068922078425600902647925489070935295035906719347897892086243913124147606456000914402132524111846374420775485917139977251401307406334646148782180235522969947407815167357423890529430139641957190877573150752368593096153887022179222684658568559828189254075039223462583877471463462963734864408667937047861414895512163327767352712083294276840412140993223877000146776362736366476356677306409185418937684884463615425179517860500050171578511794601499180838508414396285364984435127872249515438092725185215744905861424208234016341285272035187309801004898282278844570289536857082517086643612858436829507301083137099489433053700195778084860247855109396392868221729558485871182698629820478769318290071926349729256896635016612791662127807956832319801903450012288111364877361285436253567140985012621674588766768711245389023156283247247221503837251251294082718945480294773482675659282975829130021760178406285910741760716386252970659366903441072931845438080209786506255009491973227877860087294829720932002892985240780834569430987308741283036782624786383443107878821064596311572566468408870702360023496220167352952592697924012736432417060887697098190616167199072868314729637585641299948455654894815624830086652753115108040254266028360718591248999635227483843895937683845072476135284938568337316517378009243860407643232977813092602911058763660963140973215282715526252185276347839170233313189203061634241631100069396526529891610978531225765305234078250175819927290141811759259479869433458950750764360595722763435734369691405819493092509252667823250645998668432033872927019769938883949449411435176922486725624759165086586493763764964561451965274625463764379278380029610962376337908144567561440267953158803086538817950646934880101207317946029386239330212448725847143233450562764132320580007264077012482838637651269568624078431264434913373822218383268468121502145874205455805280937524842577688908229797751033058316252529371740666298959897150719232170258071946375591853766873783001545459047561055908702613433126651112195496793436889396341410506681933371133879713100474524204816770641645210886,
    78131726426732740832163237063124055529143793626391406731840322768224679110486139402048948096887339236467429636771203928743122858587390932072007927217233133955581371929483839240631852097753076384942777137441321801034993866150257178631162423643176647705156425175761058860522330308839247495170629460508586613350480591820149863605744683563051463968724409424720296631629585530680404296209997863679506131970112253810304837280887096391738955137123302993301877111398291869840812651599331609629866521010754653198857056991321735177044183907575438174803901732183180954993657540521514598994211611251786923427447345365286541974487023958284377261161906653740229176309451745058649133750095187316708137409592811623310972282326447320626293550524082003753089655076530759597297901304936432719024260939702072263771774879192845643706638953662000702960415545364092937133261160542187729794620889396015485745447087391214785280665758144554232274812791638281547214928177662046711468184346262590657067986801235536671085289498783283465125654373635030882433940406527162912522463147070684846935499184802803668446378762469278369635530138402135580244003760016185751037019013307384479514140256539148802078899537139525858265364438233829584742243001288614183518411011667230005100683216937887409340810326544568308852439746856868486542328666451816141234747466361888515593460871058407108222621429334484558487959313829242556862166760418555009036141706868432890265387450940760106919628551558977520457106428609004704875547166612136191626586678368447618866124164978866166244481528678280247555151806124872440602452875117108678196519706539259281705700706613792779696846007181681087087041330433875045279581570355896066933787600023213324413498440879274199393065291422684786575241421114498832678766923421143339092298870068714633093495702495582907431677349716362944389274783273259929818426087008427350432840860625344799734865765714147493692284408425161269742943765230652705067313458549820648144257654348370339149516847200867428186955178563095766849177728771560766440877864344519938775279368066508820154736470483550095739714354927751762487349781855264618070982213705431678372042040442257491100594138166015824770686092261080329845606088750910971704354863241791521689515797742532637101527237683658238044332166913269854000104368180058242054124860980278949764238285836034127561057310511262046199132510458221041540910438828457857715993383971705141517613478850024316400953140370687261189417389037016987764090685985212466046856682958039843218617316352598545224581963935106127915157516219517257915459013835174241302048892227391279967740301540497833902816890854528651616107507314751709453841216901695550138142051627873380392651234865839016659619533164152748376996699215359778715005013933005549292064420725979331968922317121571538061133779608795554436351761296004119964094142131857269220125419687848783871436603088969007500881889772852025991406279119516321205689689485015982716572440313314883720747337160879926788433548168649502742561868368820658354189732420211950267847113965324178911335447390292235262116429953943566564392266056405167114,
)
l = 193

n, e = pubkey
cx, cy, cz = enc
sz = 2 ** (8 * l // 2)

PR = PolynomialRing(ZZ, ["x", "y"])
x, y = PR.gens()


# Res(cx ^ 3 + c * cy ^ 3 + c ^ 2 * cz ^ 3 - 3 * c * cx * cy * cz - 1, x ^ 3 + c * y ^ 3 - 1, c)
# = y^6 * cx^3 + y^3 * (1 - x^3) * cy^3 + (1 - x^3)^2 * cz^3 - 3 * y^3 * (1 - x^3) * cx * cy * cz - y^6
# we can simplify it by letting u = 1 - x^3 and v = y^3

PR = PolynomialRing(ZZ, ["u", "v"])
u, v = PR.gens()
f = v**2 * cx**3 + v * u * cy**3 + u**2 * cz**3 - 3 * v * u * cx * cy * cz - v**2


def small_polys(f, bounds, m=1, d=None):
    if d is None:
        d = f.degree()

    R = f.base_ring()
    N = R.cardinality()
    f_ = (f // f.lc()).change_ring(ZZ)
    f = f.change_ring(ZZ)
    l = f.lm()

    M = []
    for k in range(m + 1):
        M_k = set()
        T = set((f ^ (m - k)).monomials())
        for mon in (f ^ m).monomials():
            if mon // l ^ k in T:
                for extra in itertools.product(range(d), repeat=f.nvariables()):
                    g = mon * prod(map(power, f.variables(), extra))
                    M_k.add(g)
        M.append(M_k)
    M.append(set())

    shifts = Sequence([], f.parent())
    for k in range(m + 1):
        for mon in M[k] - M[k + 1]:
            g = mon // l ^ k * f_ ^ k * N ^ (m - k)
            shifts.append(g)

    B, monomials = polynomials_to_matrix(shifts)

    factors = [monomial(*bounds) for monomial in monomials]
    for i, factor in enumerate(factors):
        B.rescale_col(i, factor)

    B = flatter(B)

    B = B.change_ring(QQ)
    for i, factor in enumerate(factors):
        B.rescale_col(i, 1 / factor)
    B = B.change_ring(ZZ)
    H = Sequence([h for h in B * monomials if not h.is_zero()])
    return H


H = small_polys(f.change_ring(Zmod(n)), (sz**3, sz**3), m=5)
h = H[0].gcd(H[1])  # a*u+b*v
c = -h.coefficients()[1] / h.coefficients()[0] % n
assert (cx ^ 3 + c * cy ^ 3 + c ^ 2 * cz ^ 3 - 3 * c * cx * cy * cz - 1) % n == 0, "???"

# a*u+b*v=0
# a*(1-x^3)+b*y^3=0
# y^3=k*a for some k=gcd(1-x^3,y^3)

for k in range(1, 100):
    try:
        y = (k * h).coefficients()[0].nth_root(3)
        uval = h.subs(v=y ^ 3).univariate_polynomial().roots(multiplicities=False)[0]
        x = (1 - uval).nth_root(3)
        print(long_to_bytes(int(x)) + long_to_bytes(int(y)))
        break
    except:
        pass
