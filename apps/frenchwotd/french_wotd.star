"""
Applet: French WOTD
Summary: French word of the day
Description: Pick a random french word for each day and display definition in English.
Author: tavdog
"""

load("hash.star", "hash")
load("math.star", "math")
load("render.star", "render")
load("time.star", "time")

# regex to convert tsv to array
# ^([^\t]*)\t(.*$)
# ["$1","$2"],

word_array = [
    ["lors", "while"],
    ["afin que", "so that"],
    ["un ou une vierge", "virgin"],
    ["bouger", "to budge"],
    ["reussir", "to accomplish"],
    ["ignorer", "to not know"],
    ["ainsi", "in this way, thus"],
    ["un naufrage", "shipwreck"],
    ["un radeau", "a raft"],
    ["lever", "to raise"],
    ["sauter", "to jump, leap"],
    ["une foudre", "a lightning bolt"],
    ["une carrière", "a career"],
    ["égarer", "to lead astray"],
    ["s'égarer", "to get lost, to lose one's way"],
    ["surtout", "above all"],
    ["hâter", "to hasten"],
    ["démonter", "to dismantle"],
    ["entraînant", "lively; swinging (music)"],
    ["griffoner", "to scribble; to scrawl"],
    ["suffire", "to be enough"],
    ["pencher", "to tip up; to tilt"],
    ["entrevoir", "to make out; to catch sight of"],
    ["aussitôt", "immediately"],
    ["debout", "standing up"],
    ["la lueur", "faint light (de)"],
    ["loin", "far"],
    ["dedans", "inside"],
    ["dehors", "outside"],
    ["une chiffre", "figure; number"],
    ["un toit", "a roof"],
    ["parvenir", "to reach; to succeed"],
    ["parvenu", "upstart"],
    ["traiter", "to treat"],
    ["conter", "to tell; to relate; to recount"],
    ["tâtonner", "to grope around"],
    ["soigneux, -euse", "conscientious; neat; careful"],
    ["épuiser", "to exhaust; to wear out"],
    ["rancune", "resentment; grudge"],
    ["rassurer", "to reassure"],
    ["un manteau", "a hammer"],
    ["l'honte (f.)", "shame"],
    ["impitoyable", "merciless (avec); petiless (envers); relentless; ruthless"],
    ["secouer", "to shake"],
    ["le vent", "wind"],
    ["dorer", "to gild; to glaze; to turn to gold"],
    ["se dorer", "to sunbathe"],
    ["tant", "so much"],
    ["la volonté", "will"],
    ["ramoner", "to sweep chimneys"],
    ["une commode (n.)", "a chest of drawers"],
    ["commode (adj.)", "practical; convenient; easy; not difficult"],
    ["un tas", "a heap; a pile"],
    ["arracher", "to pull; to dig up"],
    ["pousser", "to push; to shift"],
    ["un abri", "a shelter"],
    ["arroser", "to water"],
    ["sot ou sotte", "foolish; stupid"],
    ["une tâche", "task; job"],
    ["sinon", "except; other than"],
    ["trainer", "to drag"],
    ["agaçant", "annoying; irritating"],
    ["l'orgueil (m.)", "pride"],
    ["orgueilleux, -euse", "proud (gen.); overproud (trop)"],
    ["instruire", "to teach"],
    ["s'instruire", "to learn"],
    ["siéger", "to sit; to be in session"],
    ["s'asseoir", "to sit"],
    ["un pourpre", "a crimson (color)"],
    ["pourpre (adj)", "crimson (color)"],
    ["cependant", "nevertheless"],
    ["bailler", "to yawn"],
    ["empêcher", "to prevent; to stop"],
    ["ordonner", "to prescribe"],
    ["bredrouiller", "to mumble"],
    ["couramment", "fluently"],
    ["l'aisance (f.)", "ease"],
    ["ramener", "to bring back"],
    ["tel ou telle", "such; like"],
    ["pareil(le)", "similar (à)"],
    ["émerveiller", "to fill sb with wonder"],
    ["tirer", "to pull"],
    ["une chaise", "a chair"],
    ["enhardir", "to embolden"],
    ["exiger", "to demand; to require"],
    ["un abord", "manner (comportment)"],
    ["abords (m. pl.)", "area around"],
    ["enteindre", "to listen to"],
    ["la louange", "praise"],
    ["vide", "empty"],
    ["plein", "full"],
    ["rallumer", "to relight"],
    ["éteindre", "to put out; to extinguish; to turn off"],
    ["la baliverne", "nonsense"],
    ["les absurdités", "foolishness"],
    ["un hanneton", "June bug"],
    ["tomber en panne", "to run out of gas; to breakdown"],
    ["avoir une panne", "to have a breakdown"],
    ["repandre", "to spread (sur on, dans in); to pour (liquide); to spill"],
    ["flâner", "to stroll"],
    ["une abeille", "a bee"],
    ["ivre", "to be drunk"],
    ["être chaud", "to be drunk (inf. Québec)"],
    ["grincheux, -euse", "grouchy"],
    ["songer", "to think of something or somebody (à)"],
    ["gérer", "to manage"],
    ["un foulard", "scarf"],
    ["emporter", "to take"],
    ["loger", "to live"],
    ["réverbérer", "to reflect"],
    ["la consigne", "orders (pl.)"],
    ["éponger", "to mop or sponge"],
    ["un mouchoir", "handkerchief"],
    ["un carreau, carreaux (pl.)", "a tile or tiles"],
    ["mentir", "to lie"],
    ["entraîner", "to lead; to bring about"],
    ["découvrir", "to discover"],
    ["fournir", "to supply"],
    ["la preuve", "proof"],
    ["paresseux, -euse", "lazy"],
    ["poursuivre", "to pursue"],
    ["enjamber", "to step over"],
    ["tandis que", "while"],
    ["suivre", "to follow"],
    ["le mépris", "contempt; scorn"],
    ["paraître", "to appear"],
    ["avouer", "to confess"],
    ["benir", "to bless"],
    ["soudain", "suddenly"],
    ["un souci", "worry; problem"],
    ["sur le vif", "on the spot"],
    ["menacer", "to threaten"],
    ["quelconque", "ordinary; any"],
    ["mille", "thousand"],
    ["un millier", "a thousand"],
    ["un million", "a million"],
    ["escamoter", "to make something dissapear"],
    ["un confrère", "a colleague"],
    ["mener", "to lead"],
    ["l'oisiveté", "idleness"],
    ["l'espirit", "mind"],
    ["tenir", "to hold"],
    ["longer", "to go along; to border"],
    ["un anneau", "a ring"],
    ["le sable", "sand"],
    ["remuer", "to move"],
    ["hasard", "coincidence"],
    ["le sien", "his"],
    ["la sienne", "hers"],
    ["les siens", "theirs; its"],
    ["les siennes", "theirs (f. pl.)"],
    ["dessus", "on top"],
    ["dessous", "under"],
    ["la cheville", "ankle"],
    ["dont", "whose; which"],
    ["rendre", "to give back"],
    ["resoudre", "to solve; to resolve"],
    ["reconter", "to tell; to relate; to recount"],
    ["manquer", "to spoil; to ruin; to botch"],
    ["une racine", "a root"],
    ["gener", "to bother; to disturb"],
    ["un tabouret", "a stool"],
    ["donc", "thus; therefore; so"],
    ["salé", "salty"],
    ["semblable", "similar (à)"],
    ["échapper", "to get away from; to elude (à)"],
    ["soigner", "to treat; to nurse"],
    ["retourner", "to turn something over"],
    ["apprivoiser", "to tame"],
    ["un fusil", "a gun"],
    ["une arme à feu", "a gun"],
    ["chasser", "to hunt"],
    ["élever", "to raise"],
    ["les poules (f.)", "hens"],
    ["ressembler", "to resemble (à)"],
    ["un bruit", "a sound"],
    ["hors", "except; apart from"],
    ["un champ", "a field"],
    ["doré(e)", "gilded"],
    ["un coin", "a corner"],
    ["le lendemain", "the following day"],
    ["inquiet, inquiète", "anxious"],
    ["un vignoble", "a vineyard"],
    ["puisque", "since"],
    ["la gêne", "embarrassment; discomfort"],
    ["passant (adj.)", "busy"],
    ["un passant", "a passerby"],
    ["arbriter", "to shelter"],
    ["une chenille", "caterpillar"],
    ["plaindre", "to pity"],
    ["aiguiller", "to guide; to direct (vers)"],
    ["aiguiller", "to steer conversation towards (sur)"],
    ["un tri", "a sorting"],
    ["tantôt", "sometimes"],
    ["gronder", "scold for doing something"],
    ["le tonnerre", "thunder"],
    ["un trajet", "journey; crossing (par mer); route"],
    ["un parcours (s. or pl.)", "route (trajet); course (de fleuve)"],
    ["ennuyer", "to irritate; to annoy; to bore"],
    ["dépenser", "to spend"],
    ["un signe", "a sign (fig.)"],
    ["autant", "as much; as many"],
    ["autant de", "so many; so much"],
    ["hélas", "alas"],
    ["la campagne", "the countryside"],
    ["monter", "to go up; to climb"],
    ["un couloir", "a corridor"],
    ["la taille", "size"],
    ["à moins que ", "unless (avant un nom)"],
    ["à moins de", "unless (avant un verbe)"],
    ["pour que", "in order to"],
    ["pourvu que", "provided that"],
    ["sans que", "without; without that"],
    ["garder", "to keep"],
    ["l'envie (f.)", "want; urge (de faire); craving (de choses à manger)"],
    ["un(e) motard(e)", "motorcyclist; biker (inf.)"],
    ["emmener", "to take a person (à, jusqu'à)"],
    ["le sommeil", "sleep"],
    ["une boîte", "a box; tin"],
    ["écraser", "to crush; to smash (fig.)"],
    ["une poupée", "a doll"],
    ["enlever", "to remove"],
    ["marchand(e)", "marketable"],
    ["un(e) marchand", "merchant"],
    ["un tas", "an untidy heap (de)"],
    ["une pile", "a stack (de)"],
    ["apaisant(e)", "soothing"],
    ["la soif", "thirst"],
    ["éprouver", "to have (sensation, doute, difficulté)"],
    ["éprouver", "to feel (regret, désir, amour)"],
    ["avaler", "to swallow"],
    ["épargner", "to save"],
    ["doucereux, -euse", "unctuous"],
    ["agir", "to act"],
    ["un conduit", "a pipe (for many types of construction conduits)"],
    ["un pli", "fold; pleat"],
    ["un rayon", "a beam (de); a ray (fig.)"],
    ["embellir", "to embellish; make more attractive; to beautify"],
    ["lorsque", "when"],
    ["le fond", "the bottom"],
    ["entrouvert(e)", "ajar; half open"],
    ["ébaucher", "to sketch out; to draft"],
    ["au lever du jour", "at daybreak"],
    ["enfourner", "to put something in the oven"],
    ["rapide", "fast"],
    ["creuser", "to dig"],
    ["un trou", "hole"],
    ["rêver", "to dream"],
    ["un seau", "a bucket (de)"],
    ["une giroutte", "a windvane; weathercock (fig. pers.)"],
    ["lentement", "slowly"],
    ["hisser", "to hoist"],
    ["une marge", "a margin"],
    ["un aplomb", "aplomb"],
    ["un aliment", "food"],
    ["aveugle", "blind"],
    ["un museau", "a muzzle"],
    ["chou, choux (pl.)", "sweet"],
    ["un choux", "a cabbage (soupe aux choux)"],
    ["une corne", "horn"],
    ["une chute", "fall (lit. or fig.)"],
    ["un mur", "a wall"],
    ["un endroit", "a place"],
    ["un bond", "a leap"],
    ["entendre", "to hear; to listen to"],
    ["dresser", "to train; to pitch (tente); to draw up; to set"],
    ["fouiller", "to search"],
    ["presser", "to squeeze"],
    ["se faufiler", "to worm one's way or squeeze in"],
    ["de la monnaie", "change (from larger denominations)"],
    ["pièce d'or", "gold coin"],
    ["defaire", "to undo"],
    ["cacher", "to hide"],
    ["mouler", "to mold"],
    ["une tempe", "a temple"],
    ["oser", "to dare"],
    ["couler", "to flow"],
    ["un abîme", "abyss; gulf; ruin"],
    ["retenir", "to hold back"],
    ["réchauffer", "to heat; to reheat"],
    ["glacer", "to freeze"],
    ["supporter", "to support"],
    ["un tour", "circuit; excursion; tour"],
    ["établir", "to set up; establish"],
    ["de toute façon", "anyway; in any case"],
    ["le mode", "the style"],
    ["mettre au régime", "to go on a diet"],
    ["un étranger", "a foreigner"],
    ["ramasser", "to collect; to pick up"],
    ["un chemin", "road; way"],
    ["haletant", "breathless"],
    ["s'élancer", "to dash forward"],
    ["une fouille", "a search"],
    ["un tableau, tableaux (pl.)", "painting or paintings"],
    ["une vedette", "a star; a celebrity"],
    ["crever", "to burst"],
    ["un loup", "wolf"],
    ["valoir", "to be worth"],
    ["déménager", "to move house; to move; to relocate"],
    ["un beau-père", "father-in-law"],
    ["un(e) colocataire", "roomate"],
    ["le loyer", "rent"],
    ["cesser", "to cease; to stop"],
    ["arrêter", "to stop the advancement of"],
    ["une ferme", "farm"],
    ["dérchirer", "to tear something up"],
    ["la moitié", "half"],
    ["battre", "to beat; to defeat"],
    ["commode", "convenient"],
    ["boucher", "to block; to cork"],
    ["se boucher", "to hold one's (nose, ears); to get blocked or clogged up"],
    ["gratter", "to scratch"],
    ["un but", "a goal"],
    ["la spéléologie", "caving; spelunking"],
    ["émouvant(e)", "moving; thrilling"],
    ["une relique", "relic"],
    ["s'attendre", "to expect"],
    ["coudre", "to sew"],
    ["auparavant", "previously"],
    ["au fond", "at the bottom"],
    ["les films féeriques", "magic films"],
    ["la pellicule", "film (physical)"],
    ["remboliner", "to rewind"],
    ["tourner", "rotate; swivel"],
    ["se consacrer", "devote oneself to (à)"],
    ["terminer", "to finish"],
    ["une baisse", "downturn; fall"],
    ["décrire", "to dsecribe; to depict"],
    ["un métrage", "a length"],
    ["les bandes dessinées", "comic strips"],
    ["une cagoule", "a hood"],
    ["un maillot", "undershirt; jersey; (de bain) swimsuit"],
    ["suprendre", "to surprise"],
    ["à l'aise", "to be at ease, to be comfortable"],
    ["empoisonner", "to poison"],
    ["un enlèvement", "kidnapping, abduction"],
    ["concurrencer", "to compete with"],
    ["augmenter", "to increase (de)"],
    ["grandir", "to grow, to increase"],
    ["désormais", "from now on, henceforth"],
    ["aisé(e)", "easy; wealthy"],
    ["tromper", "to deceive; to mislead"],
    ["se tromper", "miscalculate"],
    ["au bout du compte", "the bottom line; after all"],
    ["exhorter", "encourage"],
    ["laisser", "to leave; to let"],
    ["prier", "to beg; to plead"],
    ["une auberge", "an inn; a hostel"],
    ["gaillard(e)", "strapping; energetic"],
    ["l'herbe", "grass"],
    ["s'éloigner", "to move somebody or something away (de)"],
    ["s'éloigner", "to move oneself away (de)"],
    ["un manche", "handle; neck"],
    ["une manche", "sleeve"],
    ["un rang", "a row; rank"],
    ["s'inscrire", "to enroll, to register"],
    ["jouir", "to have an orgasm"],
    ["un cas", "a case (circumstance)"],
    ["savoir", "to know (more in the sense of facts)"],
    ["connaitre", "to know (more in the sense of to be familiar with)"],
    ["pleuvoir", "to rain"],
    ["parer", "to parry; to fend off; to ward off"],
    ["troubler", "to blur; to disturb; to disconcert; to affect"],
    ["souffrir", "to put up with anything from somebody"],
    ["atteindre", "to reach"],
    ["avoir tort (m.)", "to be wrong"],
    ["le loisir", "leisure; spare time"],
    ["quand même", "despite, in spite of"],
    ["la peine", "sorrow, grief; effort, troulbe"],
    ["causer", "to cause"],
    ["confier", "to confide; to entrust somebody with something"],
    ["l'asile (m.)", "refuge; asylum; sanctuary"],
    ["la voie", "the way (fig.)"],
    ["se fournir", "to buy from; to get supplies from"],
    ["un poulailler", "a chicken coop"],
    ["entamer", "to start; to initiate; to enter into; to open"],
    ["ôter", "to take off; to remove (de)"],
    ["se débarrasser", "to get rid of"],
    ["l'avenir (m.)", "the future"],
    ["la crainte", "fear"],
    ["la foi", "faith"],
    ["fou, fol, folle", "crazy"],
    ["un mulet", "a mule"],
    ["une gabelle", "salt tax"],
    ["une rencontre", "a meeting (avec, entre)"],
    ["mépriser", "to dispise; to be scornful of; to disregard"],
    ["néanmois", "nevertheless"],
    ["le néant", "nothingness (philosophy); emptiness (absence de valeur)"],
    ["acquérir", "to acquire"],
    ["un(e) gredin(e)", "rascal"],
    ["voguer", "to sail (vers); to wander (fig.)"],
    ["enseigner", "to teach"],
    ["accomoder", "to adapt; to prepare (food)"],
    ["le fil", "thread; string"],
    ["la livraison", "delivery"],
    ["d'ailleurs", "by the way"],
    ["échouer", "to fail; to beach"],
    ["un ouvrier ou une ouvrière", "a worker"],
    ["réduire", "to reduce"],
    ["un renvoi", "an expulsion, dismissal (de)"],
    ["le chômage", "unemployment"],
    ["un écart", "distance, gap; difference"],
    ["s'accomoder", "to make the best of"],
    ["un chêne", "oak tree"],
    ["une plaine", "a plain"],
    ["une tableu", "a table"],
    ["dérouler", "to unroll; to unfold (history)"],
    ["gronder", "to tell off"],
    ["un grondement", "a rumble, roar, growl"],
    ["le fleuve", "river"],
    ["mousser", "to bubble; to foam; to lather"],
    ["écumer", "to foam at the mouth"],
    ["l'écume (f.)", "foam"],
    ["enfoncer", "to push in"],
    ["s'enfoncer", "to sink (in snow or sand); to go into scenery"],
    ["lointain(e)", "distant"],
    ["une allumette", "a match"],
    ["un copain", "boyfriend"],
    ["une copaine", "girlfriend"],
    ["un(e) voisin(e)", "a neighbor"],
    ["voisin(e)", "neighboring"],
    ["un toboggan", "slide (in a playground)"],
    ["amener", "to take or to bring somebody somewhere"],
    ["emdommager", "to damage"],
    ["un alamanach", "an almanac"],
    ["avertir", "warn; caution"],
    ["les ténèbres (f. pl.)", "darkness"],
    ["le bois", "wood"],
    ["encore", "still; not yet; again; more"],
    ["une cloche", "a bell"],
    ["l'âme (f.)", "soul"],
    ["la colline", "hill"],
    ["la carrière", "career"],
    ["le séjour", "a stay"],
    ["une feuille", "leaf"],
    ["le vallon", "valley"],
    ["orageux ou orageuse", "stormy"],
    ["un flot de", "a stream of"],
    ["abîmer", "to damage"],
    ["le loup", "a wolf"],
    ["immuable", "immutable"],
    ["tranchant(e)", "sharp (knife); forthright (person)"],
    ["un tranchant", "sharp edge of a knife"],
    ["argenter", "to silver"],
    ["un meuble", "a piece of furniture"],
    ["la coupe", "a cut"],
    ["le cidre", "cider"],
    ["glisser", "to slip object (dans); to slip in a remark"],
    ["une somme", "a sum"],
    ["un accueil", "a welcome"],
    ["l'orgueil", "pride"],
    ["ailleurs", "elsewhere"],
    ["entretenir", "to look after"],
    ["associer", "to combine (à, et); to bring people together"],
    ["reconnaissant(e)", "grateful (de, envers)"],
    ["soulager", "to relieve"],
    ["un maçon", "a mason"],
    ["un fermier, une fermière", "a farmer"],
    ["un haillon", "rag"],
    ["dépasser", "to overtake"],
    ["le foin", "hay"],
    ["jurer", "to swear, vow"],
    ["une étreinte", "embrace; grip; hug"],
    ["soutenir", "to support"],
    ["un cochon", "a pig"],
    ["la baleine", "a whale"],
    ["cueillir", "to gather"],
    ["le brouillard", "fog"],
    ["un tareau", "a bull"],
    ["aveugler", "to blind"],
    ["le soin", "care; attention"],
    ["l'âne (m.)", "donkey, ass"],
    ["une jument", "a mare"],
    ["une seringue", "a syringe"],
    ["un bateau, bateaux (pl.)", "a boat"],
    ["rhabiller", "to put someone's clothes back on"],
    ["congédier", "to fire; to dismiss"],
    ["couronner", "to crown"],
    ["abaisser", "to reduce; to lower; to pull down; to humiliate; to humble"],
    ["la dentelle", "lace"],
    ["dissiper", "to dispel; to clear up"],
    ["un(e) vierge", "a virgin"],
    ["le cierge", "candle"],
    ["l'aube (f.)", "daybreak"],
    ["l'auberge (f.)", "inn ; hostel"],
    ["le glas", "toll, knell"],
    ["le seuil", "doorstep, threshold"],
    ["le deuil", "bereavement; mourning; grief"],
    ["la poitrine", "the chest"],
    ["la messe", "Mass"],
    ["outre", "in addition to"],
    ["le gazon", "grass, turf"],
    ["un perroquet", "parrot"],
    ["accourir", "to run up"],
    ["émouvoir", "to move; agitate; disturb; touch"],
    ["éprouvanter", "to scare; to terrify; to upset"],
    ["le faîte", "summit"],
    ["surhumain(e)", "superhuman"],
    ["tenter", "to attempt; to tempt"],
    ["attirer", "to attract; to draw"],
    ["heurter", "to hit, to strike; to collide with; to bump into"],
    ["affreux, -euse", "creepy; hideous; dreadful; terrible; ugly; dispicable"],
    ["guère", "not; hardly; barely"],
    ["un banc", "a bench"],
    ["le charbon", "coal"],
    ["tout à l'heure", "soon; in a moment"],
    ["tout de suite", "at once; right away"],
    ["tout d'un coup", "suddenly; all at once"],
    ["tout à fait", "quite; absolutely"],
    ["foncer", "to make a color darker"],
    ["la plafond", "ceiling"],
    ["l'appentis (m.)", "shed"],
    ["puiser", "to draw from"],
    ["un ravitaillement", "provision of fresh supplies"],
    ["la tourmente", "storm"],
    ["la récolte", "harvest"],
    ["le bout", "the end"],
    ["le côté", "side"],
    ["fêlé ou fêlée", "cracked; off one's rocker"],
    ["gêner", "to disturb"],
    ["pourtant", "though"],
    ["boueux, -euse", "muddy"],
    ["découper", "to cut up; to divide up"],
    ["une baraque", "a shack; a pad (inf.); a hefty person"],
    ["un phare", "headlight"],
    ["un talus", "embankment; bank, slope"],
    ["peiner", "to sadden, to upset"],
    ["extirpir", "to drag (de)"],
    ["la pente", "slope"],
    ["le bord", "edge; side; bank"],
    ["lointain", "distant; indirect"],
    ["sourd", "deaf"],
    ["étouffer", "to stifle; to suppress"],
    ["un flot", "a flood"],
    ["à flot", "to flow"],
    ["un crapaud", "a toad"],
    ["rapprocher", "to move closer, to bring forward (de)"],
    ["appuyer", "to lean, to rest (sur, contre)"],
    ["autrefois", "once"],
    ["une gourmandise", "a weakness for sweets or good food"],
    ["un souvenir", "a memory"],
    ["un sentier", "a path; track"],
    ["la serge", "durable twilled wool or worsted fabric"],
    ["marteau, -eaux", "cracked"],
    ["un marteau", "hammer"],
    ["le talon", "heel"],
    ["la barbe", "beard"],
    ["la hanch", "hip"],
    ["une bougie", "a chandle"],
    ["un ronflement", "snore"],
    ["un costume", "a (men's) suit"],
    ["un tailleur", "a (woman's) suit"],
    ["un complet", "a suit"],
    ["un parvis", "a squre (d'église) or forecourt (de bâtiment)"],
    ["le parloir", "visitor's room; parlour"],
    ["relier", "to link up"],
    ["une nouvelle", "a short story; a news story"],
    ["la longueur", "length (dimension); length (duration)"],
    ["la durée", "length, duration"],
    ["obséquieux, -euse", "obsequious"],
    ["par conséquent", "therefore, as a result"],
    ["excuser", "to forgive"],
    ["s'excuser", "to apologize"],
    ["quoique", "although, though"],
    ["à moins que", "unless"],
    ["jusqu'à", "until; to"],
    ["pourvoir à", "provide with"],
    ["feindre", "to fake"],
    ["chuchoter", "to shush"],
    ["protager", "to protect"],
    ["un mouton", "a sheep"],
    ["une ruse", "a trick"],
    ["un voile", "a veil"],
    ["l'inimité (f.)", "enmity; animosity"],
    ["une ronce", "a bramble"],
    ["un rossignol", "a nightengale"],
    ["davantage", "more"],
    ["une coutume", "a custom"],
    ["une demeure", "a residence"],
    ["le taffetas", "fine silk"],
    ["broder", "to embroider"],
    ["tel", "such"],
    ["vif, vive", "bright, vivid"],
    ["octroyer", "to grant sb sth"],
    ["s'octroyer", "to allow oneself"],
    ["le congé", "leave"],
    ["épais", "thick"],
    ["le courroux", "wrath, ire (formal)"],
    ["un crabe", "a crab"],
    ["un cancre", "dunce"],
    ["un cuvier", "a large washtub"],
    ["charger", "to load; to charge"],
    ["un valet", "an employee; a servant"],
    ["gâter", "to spoil"],
    ["une besogne", "a job"],
    ["une écuelle", "a bowl"],
    ["il fallait", "it was necessary"],
    ["un berger, une bergère", "a shepherd"],
    ["une morsure", "a bite"],
    ["supplier", "to beg; to plead"],
    ["plaider", "to plead"],
    ["emprunter", "to borrow"],
    ["un lien", "a bond, strap, string; a link"],
    ["la parole", "speech"],
    ["quiconque", "whoever; who; anybody"],
    ["les bornes (f. pl.)", "the limits"],
    ["lâche", "cowardly"],
    ["l'effroi (m.)", "dread, terror"],
    ["un aïeul, une aïeule", "grandfather, grandmother"],
    ["les aïeux (m. pl.)", "ancestors"],
    ["malin, -igne", "clever; malicious; malignant"],
    ["frotter", "rub; scrub"],
    ["effrayant(e)", "frightening; dreadful"],
    ["la fréquence", "frequency"],
    ["une lutte", "a fight"],
    ["se trouver face à", "to contront a challenge"],
    ["comme une solution", "as a solution"],
    ["le paradis", "heaven"],
    ["au fil du temps", "over time, over the course of time"],
    ["le remerciement", "thanks"],
    ["faciliter les chose", "to make things easier"],
    ["un escroc", "swindler, crook"],
    ["une devineresse", "a soothsayer"],
    ["un brigand", "brigand, bandit"],
    ["un charletan", "a charletan"],
    ["l'espirit vif", "quick witted"],
    ["l'attrait (m.)", "appeal, attraction"],
    ["mordre", "to bite"],
    ["le jumelage", "twinning (of clubs, communities); syncing"],
    ["trancher", "to cut, to slice"],
    ["satisfaire", "to satisfy"],
    ["bréger", "to shorten"],
    ["un peigne", "a comb"],
    ["la gratitude", "gratitude"],
    ["le sol", "ground; floor (origin of soil)"],
    ["un sol", "ancient piece of money"],
    ["une touffe", "tuft of hair; clump of trees"],
    ["une barque", "a small boat"],
    ["une toque", "a type of hat (definitions vary)"],
    ["une courroie de cuir", "a long thin piece of leather"],
    ["l'envers (m.)", "the back; the inverse; the reverse"],
    ["une écharpe", "a scarf"],
    ["pareillement", "(in) the same way"],
    ["une gorgie", "a gulp"],
    ["un fosse", "a ditch"],
    ["le gibier", "game (hunting, cooking)"],
    ["une dot", "a dowry"],
    ["chargé(e)", "loaded; heavy"],
    ["siffler", "to whistle"],
    ["une tache", "a stain"],
    ["une sangle", "a strap"],
    ["émincer", "to mince; to cut thinly"],
    ["ramper", "to crawl"],
    ["un portail", "a gate"],
    ["dévoiler", "to devulge"],
    ["depanner", "convenience store (Québec); mechanics shop"],
    ["la veille", "the day before"],
    ["il y avait", "there were"],
    ["un filet", "a net; netting; mesh"],
    ["apparenté(e)", "related (à)"],
    ["espionner", "to spy"],
    ["redresser", "to straighten; to rectify"],
    ["déclencher", "to set off; to start; to initiate"],
    ["un défilé", "a parade; a procession"],
    ["un évêque", "a bishop (de)"],
    ["une appartenance", "a membership"],
    ["délaisser", "to leave, to abandon; to neglect"],
    ["laïciser", "to secularize"],
    ["un medium", "media"],
    ["un ou une intermédaire", "through the medium (de)"],
    ["amorphous", "shapeless"],
    ["la main d'oeuvre", "labor"],
    ["le tort", "prejudice"],
    ["douteux, -euse", "uncertain; ambiguous; suspicious"],
    ["chialer", "cry; blubber"],
    ["taire", "hush up; conceal"],
    ["brancher", "to plug in; to connect up"],
    ["en scred", "keep something on the down low (inf.)"],
    ["s'énerver", "to get worked up; to excite oneself"],
    ["énerver", "to annoy; to irritate"],
    ["envahir", "to overpower; to invade"],
    ["ménager", "to handle carefully"],
    ["témoigner", "to testify (que); to show (de)"],
    ["un témoin", "a witness"],
    ["un établissement", "organization, establishment, institution"],
    ["une table des matières", "a table of contents"],
    ["égal", "equal to"],
    ["également", "also, too"],
    ["insécable", "indivisible"],
    ["tout est finchu", "all is lost"],
    ["le solfège", "music theory"],
    ["dès", "since; ever since"],
    ["une promesse creuse", "a hollow promise"],
    ["affronter", "to face"],
    ["une glissade", "a slide"],
    ["l'édifice (m.)", "an edifice (also fig.)"],
    ["ressentir", "to feel"],
    ["se ressentir", "to feel the affects of; to suffer from"],
    ["n'a pas encore reconnue", "has not yet been recognized"],
    ["un chiffre", "a number, figure; statistic; code (likely origin of cipher)"],
    ["un livre blanc", "authoritative text on an issue"],
    ["une aranque", "sindle; rip-off (inf.)"],
    ["bien au dessus", "not very much below"],
    ["un journal intime", "a diary"],
    ["un reseignment", "a piece of information"],
    ["neuf, -uve", "new"],
    ["la punition", "punishment (stronger)"],
    ["les environs (m. pl.)", "surroundings"],
    ["le cadre", "surroundings; scene"],
    ["un milieu, milieux (pl.)", "environment"],
    ["un enregistrement", "a video or sound recording"],
    ["une lame", "a blade"],
    ["une nappe", "a tablecloth"],
    ["une surface", "a surface"],
    ["une guele", "mouth of an animal"],
    ["la bouche", "mouth of a human or horse"],
    ["corriger", "to correct"],
    ["Je reconnais mon erreur", "I stand corrected"],
    ["une faute", "error in text, spelling, or typing"],
    ["une erreur", "error in sum, calculation, judgement, procedure"],
    ["un concombre", "a cucumber"],
    ["le guacamole", "guacamole"],
    ["l'avocat (m.)", "avacado"],
    ["la laitue", "lettuce"],
    ["les olives noires (f.)", "black olives"],
    ["un piment", "hot pepper"],
    ["les piments bananes (m.)", "banana peppers"],
    ["le poivron vert", "green pepper"],
    ["une souris", "a mouse"],
    ["une fonction", "post; duties; job"],
    ["une propriété", "a property"],
    ["réparer", "to fix"],
    ["régler", "to sort out or to fix a problem"],
    ["un linceul", "a shroud"],
    ["hypernoréen(ne)", "of the extreme north"],
    ["une haie", "a hedge; a hurdle"],
    ["à comble raide", "avec un toir pentu - with a steep roof"],
    ["une aile", "a wing of a building"],
    ["un fournil", "a bakehouse"],
    ["une buanderie", "a laundry room"],
    ["un pavillion", "a pavillon"],
    ["un puits", "a well"],
    ["une grange", "a farm"],
    ["un jardin potager", "un jardin de légumes"],
    ["un verger", "an orchard"],
    ["la cime", "the top"],
    ["un coteau", "a hill"],
    ["se vanter", "to brag (de)"],
    ["vanter", "to praise"],
    ["l'aurore", "dawn"],
    ["à la hête", "in a hurry"],
    ["constater", "to determine"],
    ["rater", "to miss"],
    ["étonnant", "amazing, astonishing, surprising"],
    ["d'après", "according to"],
    ["la place", "the square"],
    ["détendre", "to release; to relax; to slacken"],
    ["méprisable", "contemptable, dispicable"],
    ["pousser", "to grow"],
    ["tronquer", "to truncate"],
    ["fendre", "to chop; to split; to slit"],
    ["effrayer", "to frighten"],
    ["enroué(e)", "a husky or hoarse voice"],
    ["peindre", "to paint"],
    ["une maison", "a house"],
    ["dès que", "as soon as"],
    ["entêté", "stubborn"],
    ["têtu(e)", "stubborn"],
    ["obstiné(e)", "stubborn"],
    ["tenance", "stubborn; long-lasting; persistent"],
    ["opiniâtre", "dogged; tenacious; persistent"],
    ["rebelle", "rebellious; resistant"],
    ["une vitre", "windowpane; pane of glass"],
    ["causatif, -ive", "causative"],
    ["ceindre", "to put on"],
    ["l'acier (m.)", "steel"],
    ["munir", "to provide someone (de)"],
    ["trempé", "soaked; drenched"],
    ["le conférencier, la conférencère", "speaker; lecturer"],
    ["un sou", "a penny"],
    ["un diplôme", "a university degree"],
    ["affiner", "to refine"],
    ["s'affiner", "to become keener"],
    ["un manager", "manager (sport)"],
    ["un fateuil", "chair; armchair"],
    ["un tableau", "a picture; a painting"],
    ["une théorie", "a theory"],
    ["un magazine", "a magazine"],
    ["un voyou", "a hoodlum; a lout"],
    ["un emploi", "a job"],
    ["un poste", "a job"],
    ["un renseignment", "piece of information"],
    ["les sœurs jumelles", "twin sisters"],
    ["les matières", "material; matter; subject"],
    ["un rideau", "a curtain"],
    ["une joue", "cheek"],
    ["une nuque", "nape of the neck"],
    ["la serrure", "the keyhole"],
    ["récolter", "to harvest; to dig up"],
    ["toute la journée", "the whole day"],
    ["toute la matinée", "the whole morning"],
    ["toute la soirée", "the whole evening"],
    ["tous les jours", "every day"],
    ["toes les matins", "every morning"],
    ["tous les soirs", "every evening"],
    ["le caractère", "one's character"],
    ["coller (inf.)", "to fail	ddd"],
    ["un dirigeant", "a leader"],
    ["diriger", "to control; to conduct"],
    ["un achat", "a purchase"],
    ["convenir", "to suit"],
    ["le printemps", "spring"],
    ["l'hiver (m.)", "winter"],
    ["l'été (m.)", "summer"],
    ["l'automne", "fall; autumn"],
    ["tout à coup", "suddenly"],
    ["une clairière", "a clearing"],
    ["une épine dorsale", "spinal column"],
    ["résoudre", "to resolve"],
    ["un(e) cadet(te)", "the youngest son or daughter/child"],
    ["désaxer", "to umbalance someone"],
    ["étendre", "to stretch; to spread"],
    ["répartir", "to split"],
    ["une paroi", "side; wall"],
    ["aveuglant", "blinding; glaringly obvious"],
    ["le mérite", "meritè; credit"],
    ["esthétique", "aesthetic; pleasing; graceful"],
    ["boueux, -euse", "muddy"],
    ["un aménagement", "development"],
    ["accéder", "to reach; to get to"],
    ["penché(e)", "sloping; leaning"],
    ["inespéré(e)", "hope for"],
    ["par ailleurs", "in addition; moreover; also; in some respects"],
    ["consistant(e)", "substantial"],
    ["une démarche", "reasoning"],
    ["une baie vitrée", "bay window"],
    ["éclairer", "to light up; to clarify; to enlighten"],
    ["l'édification", "building, construction"],
    ["à peu près", "about; roughly"],
    ["gésir", "to lie; to be lying about"],
    ["chaleureux, -euse", "warm; friendly; welcoming"],
    ["s'éprendre", "to become enamoured of; to fall in love with"],
    ["de plus", "furthermore"],
    ["en outre", "furthermore"],
    ["dévouement", "dedication; devotion"],
    ["la malchance", "bad luck"],
    ["en principe", "in theory"],
    ["démarche", "walk; approach; reasoning"],
    ["diffuser", "to broadcast; to spread"],
    ["plutôt", "rather; instead"],
    ["s'agir", "to be about"],
    ["embaucher", "to hire"],
    ["de là", "from there"],
    ["priver", "to deprive"],
    ["un cauchemar", "a nightmare"],
    ["un nouveau-né", "a newborn"],
    ["contourner", "to bypass; to skirt"],
    ["un canapé", "a sofa"],
    ["la limpidité", "clarity; lucidity"],
    ["à perte de vue", "as far as one can see"],
    ["remboîter", "to fit something back into something"],
    ["un quinquennat", "a five-year plan"],
    ["alentour", "surrounding"],
    ["la chair de poule", "goosebumps"],
    ["chair (adj.)", "flesh-colored"],
    ["herbeux, -euse", "grassy"],
    ["transparaître", "to show through (sur, dans)"],
    ["s'agenouiller", "to kneel down"],
    ["un dispositif", "device; system"],
    ["actionner", "to activate; to operate"],
    ["le déclic", "trigger"],
    ["l'objectif", "lens"],
    ["tel(le)", "such; like"],
    ["à partir de", "from"],
    ["un(e) concurrent(e)", "a competitor"],
    ["net (adj.)", "sharp; flat; marked; distinct"],
    ["à nouveau", "again"],
    ["flippant(e)", "spooky, creepy (inf.)"],
    ["viser", "to aim at; to be intended for"],
    ["au bas mot", "to say the least"],
    ["par habitude", "due to habit; out of habit"],
    ["un milliard", "a billion"],
    ["des centaines de millions", "hundreds of millions"],
    ["une écurie", "a stable"],
    ["l'avoine (f.)", "oats"],
    ["une expérience", "an experiment"],
    ["vraisemblance", "verisimilitude"],
    ["un aperçu", "glimpse (de); insight (sur); taste (de); outline (de)"],
    ["une déesse", "a goddess"],
    ["d'autre part", "on the other hand"],
    ["le soulagement", "relief (from pain, stress, anxiety)"],
    ["l'allégresse (f.)", "joy"],
    ["une plaque", "a patch"],
    ["le givre", "frost"],
    ["un flocon", "a flake of show or soap; a speck of dust"],
    ["tourbillonner", "to swirl, to whirl; to twirl"],
    ["durcir", "to harden"],
    ["rider", "to wrinkle; to ripple"],
    ["un proche", "a close relative; a close friend"],
    ["épaisse (adj.)", "thick"],
    ["la fourrure", "fur"],
    ["un type", "a guy (inf.)"],
    ["un royonnage", "a shelf"],
    ["désespérant(e)", "hopeless; heart-breaking"],
    ["les plus-values (f.)", "capital gains"],
    ["l'entente (f.)", "harmony; understanding"],
    ["les plus jeunes (m.)", "younger people; the younger generation"],
    ["par contre", "in contrast"],
    ["l'ordinaire (m.)", "everyday faire; the commonplace"],
    ["survenir", "happen; occur; take place"],
    ["une tranche", "a slice"],
    ["un boucher", "a butcher"],
    ["pénible", "painful; hard; difficult"],
    ["fortuit(e)", "accidental; chance; fortuitous"],
    ["foutraque", "loony, crazy (inf.)"],
    ["du moins", "at least"],
    ["planifier", "to plan; to schedule; to program"],
]

def render_error():
    return render.Root(
        render.WrappedText("Something went wrong getting today's word!"),
    )

def main():
    print("Starting")

    date = str(time.now())[0:10]

    print(date)

    # do a weird hash thing to the date to get the randomish word
    word_index = abs(int(math.remainder(int(hash.md5(date), 16), len(word_array))))
    print(int(word_index))

    word = word_array[word_index][0]
    definition = word_array[word_index][1]

    return render.Root(
        child = render.Column(
            children = [
                render.Marquee(
                    child = render.Column(
                        children = [
                            render.WrappedText(
                                content = word,
                                color = "#00eeff",
                                font = "5x8",
                            ),
                            render.WrappedText(
                                content = definition,
                                font = "5x8",
                            ),
                        ],
                    ),
                    height = 25,
                    offset_start = 23,
                    scroll_direction = "vertical",
                ),
                render.Box(
                    height = 1,
                    color = "#fa0",
                ),
                render.Text(
                    content = "French WotD",
                    height = 6,
                    font = "CG-pixel-3x5-mono",
                ),
            ],
        ),
        delay = 140,
    )
