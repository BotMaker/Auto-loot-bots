-- Execution-count profile.
-- Left margin shows the exact number of times that
-- the statement(s) on that line were executed.

       |constant SPEED_MULTIPLIER = 7.462686567164179E-5
       |--?SPEED_MULTIPLIER
       |constant SPEED_BASE=0.0034999999999999996
       |--?SPEED_BASE
       |
       |--?SPEED_BASE + (SPEED_MULTIPLIER)
       |
       |
       |constant globallimt =4
       |integer globalcount
     1 |globalcount=0
       |
       |
       |function remove_line(sequence string, integer line)
       |sequence temp
       |integer len
       |  len=length(string)
       |  if line=1 then
       |    return string[2..len]
       |  elsif line=len then
       |    return string[1..len-1]
       |  else
       |    temp=string[1..line-1]
       |    return temp&string[line+1..len]
       |  end if
       |end function
       |
       |function file_exsist(sequence fname)
       |  integer fn
       |  fn=open(fname,"r")
       |  if fn!=-1  then
       |    close(fn)
       |  	return 1
       |  end if
       |  return 0
       |end function
       |
       |function real(sequence string)
       |sequence temp
       |temp=value(string)
       |return temp[2]
       |end function
       |
       |global atom hMutex
       |integer arg
       |constant
       |    xSetLastError = registerw32Procedure(kernel32, "SetLastError",{C_INT}),
       |    xCreateMutex = registerw32Function(kernel32, "CreateMutexA",
       |                                                {C_POINTER,C_INT,C_POINTER},C_LONG),
       |    xReleaseMutex  = registerw32Procedure(kernel32, "ReleaseMutex",{C_LONG}),
       |
       |	xScrollWindow = registerw32Procedure( user32, "ScrollWindow", {C_LONG,C_LONG,C_LONG,C_POINTER,C_POINTER} )
       |
     1 |arg = allocate_string("looosdnms")
     1 |hMutex = w32Func(xCreateMutex,{0, 0, arg})
     1 |if w32Func(GetLastError,{}) = ERROR_ALREADY_EXISTS then
       |    w32Proc(xReleaseMutex,{hMutex})
       |    free(arg)
       |    --free_console()
       |    --abort(0)
       |end if
       |
       |
       |sequence accounts
     1 |accounts={}
       |
       |procedure load_accounts()
       |  integer fn, count,number
       |  object line
       |  sequence buffer
     1 |  fn=open("accounts.txt","r")
     1 |  buffer={}
     1 |  while 1 do
    17 |  	line=gets(fn)
    17 |  	if integer(line) then
     1 |  	  exit	
       |  	end if
    16 |  	if line[length(line)]=10 then
    16 |  	  buffer=append(buffer,line[1..length(line)-1])
       |    else
       |      buffer=append(buffer,line[1..length(line)])
       |  	end if
       |  	
    16 |  end while	
       |	
     1 |  count=1
     1 |  number=floor(length(buffer)/4)
     1 |  for i=1 to number do
     4 |  	accounts=append(accounts,{buffer[count],buffer[count+1],buffer[count+2],buffer[count+3],0})
     4 |  	count+=4
     4 |  	if i>=globallimt then
     1 |  	  exit	
       |  	end if
     3 |  end for
       |
       |
     1 |  for i=1 to length(accounts) do
     4 |  	addItem(List_accounts,accounts[i][1]&":"&accounts[i][2]&":"&accounts[i][3]&":"&accounts[i][4])
     4 |  end for
     1 |end procedure
     1 |load_accounts()
       |
       |
       |
       |--winsocket global vars
       |atom hWndMainWindow
       |constant SM_ASYNC = #FFFF
       |--integer packet_id,packet_len --global some functions might need to uses these
       |
       |sequence server_list
     1 |server_list={
       |{"USWest","50.18.113.133"},
       |{"USMidWest","107.22.218.252"},
       |{"EUWest","46.137.187.86"},
       |{"USEast","184.72.218.199"},
       |{"AsiaSouthEast","46.137.247.5"},
       |{"USSouth","107.22.231.55"},
       |{"USSouthWest","50.18.176.194"},
       |{"EUEast","46.51.176.123"},
       |{"EUNorth","176.34.240.11"},  --9
       |{"EUSouthWest","176.34.240.126"},
       |{"USEast3","50.19.47.160"},
       |{"USWest2","184.169.130.44"},
       |{"USMidWest2","174.129.56.145"},
       |{"USEast2","23.21.243.164"},
       |{"USNorthWest","184.169.131.108"},
       |{"USSouth2","107.20.55.255"},
       |{"AsiaEast","46.137.218.95"},
       |{"USSouth3","204.236.195.161"},
       |{"EUSouth","176.34.71.225"},
       |{"EUNorth2","46.137.38.91"},
       |{"EUWest2","176.34.195.206"}
       |}
       |
     1 |for i=1 to length(server_list) do
    21 |  addItem(combox_serverlist,server_list[i][1])	
    21 |end for
       |--setIndex(combox_serverlist,9)--eu north
     1 |setIndex(combox_serverlist,1)--us west
       |
       |
       |--with profile
       |--with profile_time
       |--profile(1)
       |
       |include item_ids.ew
       |
       |
       |global constant item_ids ={
       |{#5E2D,"Treasure Map"},
       |{#1500,"Black Cat Egg"},
       |{#1501,"Grey Cat Egg"},
       |{#1502,"Orange Cat Egg"},
       |{#1503,"Tan Cat Egg"},
       |{#1504,"Yellow Cat Egg"},
       |{#1505,"Brown Pup Egg"},
       |{#1506,"Grey Pup Egg"},
       |{#1507,"Golden Pup Egg"},
       |{#1508,"White Cat Egg"},
       |{#1509,"Blue Snail Egg"},
       |{#150A,"Grey Wolf Egg"},
       |{#150B,"Brown Fox Egg"},
       |{#150C,"Green Frog Egg"},
       |{#150D,"Lion Egg"},
       |{#150E,"Penguin Egg"},
       |{#150F,"Sheepdog Egg"},
       |{#1510,"Panda Egg"},
       |{#1511,"Purple Snail Egg"},
       |{#1512,"Black Wolf Egg"},
       |{#1513,"Grey Fox Egg"},
       |{#1514,"Purple Frog Egg"},
       |{#1515,"White Lion Egg"},
       |{#1516,"Green Penguin Egg"},
       |{#1517,"Golden Sheepdog Egg"},
       |{#1518,"Blue Parrot Egg"},
       |{#1519,"Chick Egg"},
       |{#151A,"Pig Egg"},
       |{#151B,"Sea Slurp Egg"},
       |{#151C,"Squirrel Egg"},
       |{#151D,"Bat Egg"},
       |{#151E,"Lil' Ghost Egg"},
       |{#151F,"Valentine Generator"},
       |{#1520,"Leprechaun Egg"},
       |{#1521,"Lil' Oryx Egg"},
       |{#1522,"Toucan Egg"},
       |{#1523,"Skunk Egg"},
       |{#1524,"Mallard Egg"},
       |{#1525,"Duck Egg"},
       |{#1526,"Eagle Egg"},
       |{#1527,"Turtle Egg"},
       |{#1528,"Jelly Egg"},
       |{#1529,"Bee Egg"},
       |{#152A,"Raven Egg"},
       |{#152B,"Grape Penguin Egg"},
       |{#152C,"Grass Penguin Egg"},
       |{#152D,"Elf Egg"},
       |{#152E,"Crab Egg"},
       |{#152F,"Hamster Egg"},
       |{#1530,"Dino Egg"},
       |{#1531,"Elephant Egg"},
       |{#1532,"Demon Frog Egg"},
       |{#1533,"Gargoyle Egg"},
       |{#1534,"Gummy Bear Egg"},
       |{#1535,"Dragonfly Egg"},
       |{#1536,"Lil' Cyclops Egg"},
       |{#1537,"Snowy Owl Egg"},
       |{#1538,"Turkey Egg"},
       |{#1539,"Baby Egg"},
       |{#153A,"Baby Dragon Egg"},
       |{#153B,"Karate Penguin Red Egg"},
       |{#153C,"Karate Penguin Blue Egg"},
       |{#153D,"Karate Penguin Yellow Egg"},
       |{#153E,"Karate Penguin Purple Egg"},
       |{#153F,"Beach Ball Generator"},
       |{#1540,"Robobuddy Egg"},
       |{#1541,"Snowman Egg"},
       |{#1542,"Black Ant Egg"},
       |{#1543,"Blue Ant Egg"},
       |{#1544,"Green Ant Egg"},
       |{#1545,"Red Ant Egg"},
       |{#1546,"Purple Ant Egg"},
       |{#1547,"Beer Slurp Generator"},
       |{#1549,"Peppermint Snail Egg"},
       |{#154A,"Relief Oriole Egg"},
       |{#154B,"Relief Goldfinch Egg"},
       |{#154C,"Relief Bluebird Egg"},
       |{#154D,"Relief Cardinal Egg"},
       |{#154E,"Werewolf Cub Egg"},
       |{#154F,"Tomb Snake Egg"},
       |{#1550,"Ninja Cat Egg"},
       |{#1551,"Praying Mantis Egg"},
       |{#1552,"Dreidel Egg"},
       |{#1553,"Reindeer Egg"},
       |{#1555,"Koala Egg"},
       |{#1556,"USA Eagle Egg"},
       |{#1557,"Spirit Egg"},
       |{#1558,"Sprite Star Egg"},
       |{#C85,"Common Feline Egg"},
       |{#C86,"Uncommon Feline Egg"},
       |{#C87,"Rare Feline Egg"},
       |{#C88,"Legendary Feline Egg"},
       |{#C89,"Common Canine Egg"},
       |{#C8A,"Uncommon Canine Egg"},
       |{#C8B,"Rare Canine Egg"},
       |{#C8C,"Legendary Canine Egg"},
       |{#C8D,"Common Avian Egg"},
       |{#C8E,"Uncommon Avian Egg"},
       |{#C8F,"Rare Avian Egg"},
       |{#C90,"Legendary Avian Egg"},
       |{#C91,"Common Exotic Egg"},
       |{#C92,"Uncommon Exotic Egg"},
       |{#C93,"Rare Exotic Egg"},
       |{#C94,"Legendary Exotic Egg"},
       |{#C95,"Common Farm Egg"},
       |{#C96,"Uncommon Farm Egg"},
       |{#C97,"Rare Farm Egg"},
       |{#C98,"Legendary Farm Egg"},
       |{#C99,"Common Woodland Egg"},
       |{#C9A,"Uncommon Woodland Egg"},
       |{#C9B,"Rare Woodland Egg"},
       |{#C9C,"Legendary Woodland Egg"},
       |{#C9D,"Common Reptile Egg"},
       |{#C9E,"Uncommon Reptile Egg"},
       |{#C9F,"Rare Reptile Egg"},
       |{#CA0,"Legendary Reptile Egg"},
       |{#CA1,"Common Insect Egg"},
       |{#CA2,"Uncommon Insect Egg"},
       |{#CA3,"Rare Insect Egg"},
       |{#CA4,"Legendary Insect Egg"},
       |{#CA5,"Common Penguin Egg"},
       |{#CA6,"Uncommon Penguin Egg"},
       |{#CA7,"Rare Penguin Egg"},
       |{#CA8,"Legendary Penguin Egg"},
       |{#CA9,"Common Aquatic Egg"},
       |{#CAA,"Uncommon Aquatic Egg"},
       |{#CAB,"Rare Aquatic Egg"},
       |{#CAC,"Legendary Aquatic Egg"},
       |{#CAD,"Common Spooky Egg"},
       |{#CAE,"Uncommon Spooky Egg"},
       |{#CAF,"Rare Spooky Egg"},
       |{#CB0,"Legendary Spooky Egg"},
       |{#CB1,"Common Humanoid Egg"},
       |{#CB2,"Uncommon Humanoid Egg"},
       |{#CB3,"Rare Humanoid Egg"},
       |{#CB4,"Legendary Humanoid Egg"},
       |{#CB5,"Common ???? Egg"},
       |{#CB6,"Uncommon ???? Egg"},
       |{#CB7,"Rare ???? Egg"},
       |{#CB8,"Legendary ???? Egg"},
       |{#CB9,"Common Automaton Egg"},
       |{#CBA,"Uncommon Automaton Egg"},
       |{#CBB,"Rare Automaton Egg"},
       |{#CBC,"Legendary Automaton Egg"},
       |{#CBD,"Common Mystery Egg"},
       |{#CBE,"Uncommon Mystery Egg"},
       |{#CBF,"Rare Mystery Egg"},
       |{#CC0,"Legendary Mystery Egg"},
       |{#A00,"Short Sword"},
       |{#A6C,"Broad Sword"},
       |{#A6D,"Saber"},
       |{#A01,"Long Sword"},
       |{#A6E,"Falchion"},
       |{#A3B,"Fire Sword"},
       |{#A3C,"Glass Sword"},
       |{#A02,"Golden Sword"},
       |{#A82,"Ravenheart Sword"},
       |{#A83,"Dragonsoul Sword"},
       |{#A84,"Archon Sword"},
       |{#A47,"Skysplitter Sword"},
       |{#B0B,"Sword of Acclaim"},
       |{#9C8,"Sword of Splendor"},
       |{#9C9,"Sword of Majesty"},
       |{#A03,"Crystal Sword"},
       |{#C01,"Demon Blade"},
       |{#C05,"Ancient Stone Sword"},
       |{#A04,"Fire Wand"},
       |{#A6F,"Force Wand"},
       |{#A70,"Power Wand"},
       |{#A05,"Missile Wand"},
       |{#A71,"Eldritch Wand"},
       |{#A06,"Hell's Fire Wand"},
       |{#A3D,"Wand of Dark Magic"},
       |{#AE0,"Wand of Arcane Flame"},
       |{#A4B,"Sprite Wand"},
       |{#A07,"Wand of Death"},
       |{#A85,"Wand of Deep Sorcery"},
       |{#A86,"Wand of Shadow"},
       |{#A87,"Wand of Ancient Warning"},
       |{#AF6,"Wand of Recompense"},
       |{#9CA,"Wand of Evocation"},
       |{#9C0,"Wand of Retribution"},
       |{#B3F,"Crystal Wand"},
       |{#C04,"Wand of the Bulwark"},
       |{#A08,"Wooden Shield"},
       |{#A09,"Iron Shield"},
       |{#A0A,"Steel Shield"},
       |{#ACF,"Reinforced Shield"},
       |{#A0B,"Golden Shield"},
       |{#A0C,"Mithril Shield"},
       |{#B22,"Colossus Shield"},
       |{#A40,"Snake Skin Shield"},
       |{#C0F,"Shield of Ogmur"},
       |{#A78,"Wolfskin Armor"},
       |{#A0D,"Leather Armor"},
       |{#A79,"Basilisk Hide Armor"},
       |{#A7A,"Minotaur Hide Armor"},
       |{#AD0,"Bearskin Armor"},
       |{#AD1,"Chimera Hide Armor"},
       |{#AD2,"Wyvern Skin Armor"},
       |{#A0E,"Studded Leather Armor"},
       |{#A3E,"Snake Skin Armor"},
       |{#AD3,"Drake Hide Armor"},
       |{#A8E,"Roc Leather Armor"},
       |{#A8F,"Hippogriff Hide Armor"},
       |{#A90,"Griffon Hide Armor"},
       |{#AF9,"Hydra Skin Armor"},
       |{#9C1,"Wyrmhide Armor"},
       |{#9C3,"Leviathan Armor"},
       |{#A7B,"Iron Mail"},
       |{#A0F,"Chainmail"},
       |{#A7C,"Blue Steel Mail"},
       |{#A7D,"Silver Chainmail"},
       |{#A10,"Golden Chainmail"},
       |{#A11,"Plate Mail"},
       |{#ADF,"Mithril Chainmail"},
       |{#A12,"Mithril Armor"},
       |{#A13,"Dragonscale Armor"},
       |{#A91,"Desolation Armor"},
       |{#A92,"Vengeance Armor"},
       |{#A93,"Abyssal Armor"},
       |{#AFC,"Acropolis Armor"},
       |{#9C4,"Dominion Armor"},
       |{#9C5,"Annihilation Armor"},
       |{#A14,"Steel Dagger"},
       |{#A15,"Dirk"},
       |{#A72,"Blue Steel Dagger"},
       |{#A73,"Dusky Rose Dagger"},
       |{#A74,"Silver Dagger"},
       |{#A16,"Golden Dagger"},
       |{#A17,"Obsidian Dagger"},
       |{#709,"Poison Fang Dagger"},
       |{#A18,"Mithril Dagger"},
       |{#A19,"Fire Dagger"},
       |{#A88,"Ragetalon Dagger"},
       |{#A89,"Emeraldshard Dagger"},
       |{#A8A,"Agateclaw Dagger"},
       |{#AFF,"Dagger of Foul Malevolence"},
       |{#9C6,"Dagger of Sinister Deeds"},
       |{#9C7,"Dagger of Dire Hatred"},
       |{#C0A,"Dirk of Cronus"},
       |{#A1A,"Shortbow"},
       |{#A75,"Reinforced Bow"},
       |{#A1B,"Crossbow"},
       |{#A76,"Greywood Bow"},
       |{#A77,"Ironwood Bow"},
       |{#A1C,"Fire Bow"},
       |{#A1D,"Double Bow"},
       |{#A3A,"Heavy Crossbow"},
       |{#A1E,"Golden Bow"},
       |{#A8B,"Verdant Bow"},
       |{#A8C,"Bow of Fey Magic"},
       |{#A8D,"Bow of Innocent Blood"},
       |{#B02,"Bow of Covert Havens"},
       |{#9CC,"Bow of Mystical Energy"},
       |{#9CD,"Bow of Deep Enchantment"},
       |{#C02,"Doom Bow"},
       |{#C10,"Coral Bow"},
       |{#A1F,"Potion of Attack"},
       |{#A20,"Potion of Defense"},
       |{#A21,"Potion of Speed"},
       |{#A34,"Potion of Vitality"},
       |{#A35,"Potion of Wisdom"},
       |{#A4C,"Potion of Dexterity"},
       |{#AE9,"Potion of Life"},
       |{#AEA,"Potion of Mana"},
       |{#AB0,"Minor Health Potion"},
       |{#ADD,"Minor Magic Potion"},
       |{#A22,"Health Potion"},
       |{#A23,"Magic Potion"},
       |{#B34,"Fire Water"},
       |{#B35,"Cream Spirit"},
       |{#B36,"Chardonnay"},
       |{#B37,"Melon Liqueur"},
       |{#B38,"Cabernet"},
       |{#B39,"Vintage Port"},
       |{#B3A,"Sauvignon Blanc"},
       |{#B3B,"Muscat"},
       |{#B3C,"Rice Wine"},
       |{#B3D,"Shiraz"},
       |{#B14,"Elixir of Health 7"},
       |{#B15,"Elixir of Health 6"},
       |{#B16,"Elixir of Health 5"},
       |{#B17,"Elixir of Health 4"},
       |{#A81,"Elixir of Health 3"},
       |{#A48,"Elixir of Health 2"},
       |{#A49,"Elixir of Health 1"},
       |{#B18,"Elixir of Magic 7"},
       |{#B19,"Elixir of Magic 6"},
       |{#B1A,"Elixir of Magic 5"},
       |{#B1B,"Elixir of Magic 4"},
       |{#A4A,"Elixir of Magic 3"},
       |{#AED,"Elixir of Magic 2"},
       |{#AEE,"Elixir of Magic 1"},
       |{#A3F,"Snake Oil"},
       |{#707,"Healing Ichor"},
       |{#AEB,"Greater Health Potion"},
       |{#AEC,"Greater Magic Potion"},
       |{#77B,"Tincture of Fear"},
       |{#77C,"Tincture of Courage"},
       |{#B0C,"Tincture of Dexterity"},
       |{#B0D,"Tincture of Life"},
       |{#B0E,"Tincture of Mana"},
       |{#B0F,"Tincture of Defense"},
       |{#B10,"Effusion of Dexterity"},
       |{#B11,"Effusion of Life"},
       |{#B12,"Effusion of Mana"},
       |{#B13,"Effusion of Defense"},
       |{#A41,"Snake Eye Ring"},
       |{#708,"Spider's Eye Ring"},
       |{#A4F,"Ring of Minor Defense"},
       |{#A24,"Ring of Attack"},
       |{#A25,"Ring of Defense"},
       |{#A26,"Ring of Speed"},
       |{#A36,"Ring of Vitality"},
       |{#A37,"Ring of Wisdom"},
       |{#A4D,"Ring of Dexterity"},
       |{#A27,"Ring of Health"},
       |{#A28,"Ring of Magic"},
       |{#A29,"Ring of Greater Attack"},
       |{#A2A,"Ring of Greater Defense"},
       |{#A2B,"Ring of Greater Speed"},
       |{#A38,"Ring of Greater Vitality"},
       |{#A39,"Ring of Greater Wisdom"},
       |{#A4E,"Ring of Greater Dexterity"},
       |{#A2C,"Ring of Greater Health"},
       |{#A2D,"Ring of Greater Magic"},
       |{#AB7,"Ring of Superior Attack"},
       |{#AB8,"Ring of Superior Defense"},
       |{#AB9,"Ring of Superior Speed"},
       |{#ABA,"Ring of Superior Vitality"},
       |{#ABB,"Ring of Superior Wisdom"},
       |{#ABC,"Ring of Superior Dexterity"},
       |{#ABD,"Ring of Superior Health"},
       |{#ABE,"Ring of Superior Magic"},
       |{#ABF,"Ring of Paramount Attack"},
       |{#AC0,"Ring of Paramount Defense"},
       |{#AC1,"Ring of Paramount Speed"},
       |{#AC2,"Ring of Paramount Vitality"},
       |{#AC3,"Ring of Paramount Wisdom"},
       |{#AC4,"Ring of Paramount Dexterity"},
       |{#AC5,"Ring of Paramount Health"},
       |{#AC6,"Ring of Paramount Magic"},
       |{#AC7,"Ring of Exalted Attack"},
       |{#AC8,"Ring of Exalted Defense"},
       |{#AC9,"Ring of Exalted Speed"},
       |{#ACA,"Ring of Exalted Vitality"},
       |{#ACB,"Ring of Exalted Wisdom"},
       |{#ACC,"Ring of Exalted Dexterity"},
       |{#ACD,"Ring of Exalted Health"},
       |{#ACE,"Ring of Exalted Magic"},
       |{#BA0,"Ring of the Sphinx"},
       |{#BA1,"Ring of the Nile"},
       |{#BA2,"Ring of the Pyramid"},
       |{#A2E,"Fire Spray Spell"},
       |{#AD4,"Flame Burst Spell"},
       |{#A2F,"Fire Nova Spell"},
       |{#AD5,"Scorching Blast Spell"},
       |{#AD6,"Destruction Sphere Spell"},
       |{#A30,"Magic Nova Spell"},
       |{#B24,"Elemental Detonation Spell"},
       |{#9CE,"Penetrating Blast Spell"},
       |{#A31,"Healing Tome"},
       |{#AD7,"Remedy Tome"},
       |{#A32,"Spirit Salve Tome"},
       |{#AD8,"Tome of Rejuvenation"},
       |{#A33,"Tome of Renewing"},
       |{#A5B,"Tome of Divine Favor"},
       |{#B25,"Tome of Holy Guidance"},
       |{#A50,"Pirate Rum"},
       |{#A51,"Magic Mushroom"},
       |{#A52,"Seal of the Initiate"},
       |{#AD9,"Seal of the Pilgrim"},
       |{#A53,"Seal of the Seeker"},
       |{#ADA,"Seal of the Aspirant"},
       |{#A54,"Seal of the Divine"},
       |{#A55,"Seal of the Holy Warrior"},
       |{#B26,"Seal of the Blessed Champion"},
       |{#C06,"Seal of Blasphemous Prayer"},
       |{#A56,"Cloak of Shadows"},
       |{#A57,"Cloak of Darkness"},
       |{#A58,"Cloak of Speed"},
       |{#ADB,"Cloak of the Night Thief"},
       |{#A59,"Cloak of the Red Agent"},
       |{#AE1,"Cloak of Endless Twilight"},
       |{#B27,"Cloak of Ghostly Concealment"},
       |{#A5A,"Cloak of the Planewalker"},
       |{#A5C,"Robe of the Neophyte"},
       |{#A7E,"Robe of the Apprentice"},
       |{#A5D,"Robe of the Acolyte"},
       |{#A7F,"Robe of the Student"},
       |{#A80,"Robe of the Conjurer"},
       |{#A5E,"Robe of the Adept"},
       |{#A5F,"Robe of the Invoker"},
       |{#ADC,"Robe of the Illusionist"},
       |{#A60,"Robe of the Master"},
       |{#A94,"Robe of the Shadow Magus"},
       |{#A95,"Robe of the Moon Wizard"},
       |{#A96,"Robe of the Elder Warlock"},
       |{#B05,"Robe of the Grand Sorcerer"},
       |{#9CF,"Robe of the Star Mother"},
       |{#9D0,"Robe of the Ancient Intellect"},
       |{#A61,"Magic Quiver"},
       |{#A62,"Reinforced Quiver"},
       |{#A63,"Iron Quiver"},
       |{#ADE,"Elvencraft Quiver"},
       |{#A64,"Magesteel Quiver"},
       |{#A65,"Golden Quiver"},
       |{#B28,"Quiver of Elvish Mastery"},
       |{#C07,"Quiver of Thunder"},
       |{#A66,"Combat Helm"},
       |{#A67,"Bronze Helm"},
       |{#A68,"Black Iron Helm"},
       |{#A69,"Red Iron Helm"},
       |{#A6A,"Steel Helm"},
       |{#A6B,"Golden Helm"},
       |{#B29,"Helm of the Great General"},
       |{#C08,"Helm of the Juggernaut"},
       |{#A97,"Energy Staff"},
       |{#A98,"Firebrand Staff"},
       |{#A99,"Comet Staff"},
       |{#A9A,"Serpentine Staff"},
       |{#A9B,"Meteor Staff"},
       |{#A9C,"Slayer Staff"},
       |{#A9D,"Avenger Staff"},
       |{#A9E,"Staff of Destruction"},
       |{#A9F,"Staff of Horror"},
       |{#AA0,"Staff of Necrotic Arcana"},
       |{#AA1,"Staff of Diabolic Secrets"},
       |{#AA2,"Staff of Astral Knowledge"},
       |{#B08,"Staff of the Cosmic Whole"},
       |{#9D1,"Staff of the Vital Unity"},
       |{#910,"Staff of the Fundamental Core"},
       |{#C03,"Staff of Extreme Prejudice"},
       |{#AA3,"Centipede Poison"},
       |{#AA4,"Spider Venom"},
       |{#AA5,"Pit Viper Poison"},
       |{#AA6,"Stingray Poison"},
       |{#AA7,"Felwasp Toxin"},
       |{#AA8,"Nightwing Venom"},
       |{#B2A,"Baneserpent Poison"},
       |{#AAA,"Necrotic Skull"},
       |{#AAB,"Breathtaker Skull"},
       |{#AAC,"Heartstealer Skull"},
       |{#AAD,"Soul Siphon Skull"},
       |{#AAE,"Essence Tap Skull"},
       |{#AAF,"Lifedrinker Skull"},
       |{#B2B,"Bloodsucker Skull"},
       |{#911,"Skull of Endless Torment"},
       |{#AB1,"Hunting Trap"},
       |{#AB2,"Wilderlands Trap"},
       |{#AB3,"Deepforest Trap"},
       |{#AB4,"Savage Trap"},
       |{#AB5,"Demonhunter Trap"},
       |{#AB6,"Dragonstalker Trap"},
       |{#B2C,"Giantcatcher Trap"},
       |{#AE4,"Stasis Orb"},
       |{#A42,"Suspension Orb"},
       |{#A43,"Imprisonment Orb"},
       |{#A44,"Neutralization Orb"},
       |{#A45,"Timelock Orb"},
       |{#A46,"Banishment Orb"},
       |{#B2D,"Planefetter Orb"},
       |{#C0B,"Orb of Conflict"},
       |{#AA9,"Purple Drake Egg"},
       |{#AEF,"White Drake Egg"},
       |{#AF0,"Blue Drake Egg"},
       |{#AF1,"Orange Drake Egg"},
       |{#AF2,"Green Drake Egg"},
       |{#AF3,"Yellow Drake Egg"},
       |{#AE3,"Decoy Prism"},
       |{#B1C,"Deception Prism"},
       |{#B1D,"Illusion Prism"},
       |{#B1E,"Hallucination Prism"},
       |{#B1F,"Prism of Figments"},
       |{#B20,"Prism of Phantoms"},
       |{#B23,"Prism of Apparitions"},
       |{#912,"Prism of Dancing Swords"},
       |{#B21,"Chicken Leg of Doom"},
       |{#AE5,"Lightning Scepter"},
       |{#B2E,"Discharge Scepter"},
       |{#B2F,"Thunderclap Scepter"},
       |{#B30,"Arcblast Scepter"},
       |{#B31,"Cloudflash Scepter"},
       |{#B32,"Scepter of Skybolts"},
       |{#B33,"Scepter of Storms"},
       |{#B3E,"Amulet of Resurrection"},
       |{#9D4,"Admin Sword"},
       |{#701,"Undead Lair Key"},
       |{#705,"Pirate Cave Key"},
       |{#706,"Spider Den Key"},
       |{#70A,"Abyss of Demons Key"},
       |{#70B,"Snake Pit Key"},
       |{#710,"Tomb of the Ancients Key"},
       |{#71F,"Sprite World Key"},
       |{#722,"Wine Cellar Incantation"},
       |{#C11,"Ocean Trench Key"},
       |{#C12,"Coral Juice"},
       |{#C13,"Coral Ring"},
       |{#C14,"Robe of the Tlatoani"},
       |{#C15,"Staff of the Crystal Serpent"},
       |{#C16,"Cracked Crystal Skull"},
       |{#C17,"Crystal Bone Ring"},
       |{#C18,"Coral Silk Armor"},
       |{#C19,"Totem Key"},
       |{#C1A,"Pollen Powder"},
       |{#9D5,"Thousand Shot"},
       |{#C1C,"Coral Venom Trap"},
       |{#C1D,"St. Abraham's Wand"},
       |{#C1E,"Tome of Holy Protection"},
       |{#C09,"Tome of Purification"},
       |{#C1F,"Chasuble of Holy Light"},
       |{#C20,"Ring of Divine Faith"},
       |{#C21,"Holy Water"},
       |{#C22,"Bone Dagger"},
       |{#C23,"Manor Key"},
       |{#C24,"Anatis Staff"},
       |{#C25,"Ghost Pirate Rum"},
       |{#913,"Crown"},
       |{#C27,"Captain's Ring"},
       |{#C28,"Spectral Cloth Armor"},
       |{#C29,"Spirit Dagger"},
       |{#C2A,"Ghostly Prism"},
       |{#C2B,"Small Firecracker"},
       |{#C2C,"Large Firecracker"},
       |{#C2D,"America Ring"},
       |{#C2E,"Davy's Key"},
       |{#C30,"Scepter of Fulmination"},
       |{#C31,"Experimental Ring"},
       |{#C32,"Robe of the Mad Scientist"},
       |{#C33,"Conducting Wand"},
       |{#C34,"Sand Pail 5"},
       |{#C35,"Sand Pail 4"},
       |{#C36,"Sand Pail 3"},
       |{#C37,"Sand Pail 2"},
       |{#C38,"Sand Pail 1"},
       |{#C39,"Bahama Sunrise"},
       |{#C3A,"Blue Paradise"},
       |{#C3B,"Pink Passion Breeze"},
       |{#C3C,"Lime Jungle Bay"},
       |{#C3D,"Beachzone Key"},
       |{#C3E,"Gold Medal"},
       |{#C3F,"Silver Medal"},
       |{#C40,"Bronze Medal"},
       |{#C2F,"Lab Key"},
       |{#C41,"Transformation Potion"},
       |{#C42,"XP Booster"},
       |{#C43,"XP Booster Test"},
       |{#C44,"Rusty Katana"},
       |{#C45,"Kendo Stick"},
       |{#C46,"Plain Katana"},
       |{#C47,"Thunder Katana"},
       |{#C48,"Line Kutter Katana"},
       |{#C49,"Night Edge"},
       |{#C4A,"Sky Edge"},
       |{#C4B,"Buster Katana"},
       |{#C4C,"Demon Edge"},
       |{#C4D,"Jewel Eye Katana"},
       |{#C4E,"Ichimonji"},
       |{#C4F,"Muramasa"},
       |{#C50,"Masamune"},
       |{#914,"Useless Katana"},
       |{#915,"Ray Katana"},
       |{#C53,"Basic Star"},
       |{#C54,"Four-Point Star"},
       |{#C55,"Spiral Shuriken"},
       |{#C56,"Silver Star"},
       |{#C57,"Wind Circle"},
       |{#C58,"Ice Star"},
       |{#C59,"Doom Circle"},
       |{#916,"Midnight Star"},
       |{#C5B,"Mad God Ale"},
       |{#C5C,"Oryx Stout"},
       |{#C5D,"Realm-wheat Hefeweizen"},
       |{#9CB,"Def Test Sword"},
       |{#C5F,"Ring Pop"},
       |{#C60,"Rock Candy"},
       |{#C61,"Candy-Coated Armor"},
       |{#C62,"Candy Key"},
       |{#C63,"Red Gumball"},
       |{#C64,"Purple Gumball"},
       |{#C65,"Blue Gumball"},
       |{#C66,"Green Gumball"},
       |{#C67,"Yellow Gumball"},
       |{#C68,"Loot Tier Potion"},
       |{#C69,"Loot Drop Potion"},
       |{#C6A,"XP Booster 1 hr"},
       |{#C6B,"XP Booster 20 min"},
       |{#9D3,"Admin Staff"},
       |{#9D2,"Strike Amulet"},
       |{#C6D,"Plague Poison"},
       |{#C6C,"Backpack"},
       |{#C6E,"Resurrected Warrior's Armor"},
       |{#C6F,"Cemetery Key"},
       |{#C70,"Golden Ankh"},
       |{#C71,"Eye of Osiris"},
       |{#C72,"Pharaoh's Mask"},
       |{#C73,"Golden Cockle"},
       |{#C74,"Golden Conch"},
       |{#C75,"Golden Horn Conch"},
       |{#C76,"Golden Nut"},
       |{#C77,"Golden Bolt"},
       |{#C78,"Golden Femur"},
       |{#C79,"Golden Ribcage"},
       |{#C7A,"Golden Skull"},
       |{#C7B,"Golden Candelabra"},
       |{#C7C,"Holy Cross"},
       |{#C7D,"Pearl Necklace"},
       |{#C7E,"Golden Chalice"},
       |{#C7F,"Ruby Gemstone"},
       |{#C80,"Speed Sprout"},
       |{#C81,"Old Firecracker"},
       |{#C82,"Cheater Light Armor"},
       |{#C83,"Cheater Robe"},
       |{#C84,"Cheater Heavy Armor"},
       |{#CC1,"Draconis Key"},
       |{#CC2,"Lucky Clover"},
       |{#CC3,"Saint Patty's Brew"},
       |{#CC9,"Soft Drink"},
       |{#CCB,"Fries"},
       |{#CC6,"Great Taco"},
       |{#CC5,"Power Pizza"},
       |{#CC4,"Chocolate Cream Sandwich Cookie"},
       |{#CCA,"Grapes of Wrath"},
       |{#CC8,"Superburger"},
       |{#CC7,"Double Cheeseburger Deluxe"},
       |{#CCC,"Ambrosia"}}
       |
       |
       |include SrvSckIP.ew
       |--WinSock.ew
       |--Supports Async and blocking Windows Sockets
       |
       |-- WINSOCK.EW -- Euphoria Winsock Wrapper for WSOCK32.DLL
       |-- by jesus consuegra (jconsuegra@redestb.es)
       |--       and Greg Harris (blackdog@cdc.net)
       |-- Homepage: http://www.geocities.com/SiliconValley/Sector/6432/
       |--
       |-- This file corresponds to version 1.1 of the Windows Sockets
       |-- specification.
       |--
       |-- This file includes nomenclatures Copyrighted (c)1982-1986 by Regents
       |-- of the University of California.  All rights reserved.  The
       |-- Berkeley Software License Agreement specifies the terms and
       |-- conditions for redistribution.
       |--
       |-- Although some constants are not used in this implementation,
       |-- they remain here to allow further development.
       |--
       |-- current release is  release 0.13 pre alpha
       |
       |
       |-- History:
       |--
       |-- 0.00 pre Alpha
       |--    Basic calls to test suitability.
       |--    Translated <winsock.h> to Euphoria.ew
       |-- 0.01 pre Alpha
       |--    Implementing WSAStartup and WSACleanup
       |-- 0.02 pre Alpha
       |--    Renaming functions to WsockXXXXX
       |-- 0.03 pre Alpha
       |--    Implementing HostInfo,
       |--    gethostbyname,inet_addr, gethostbyaddr
       |--    Changes in the wrapper structure
       |--    Starting the skeleton of a documentation
       |-- 0.04 pre Alpha July 7th, 1998.
       |--    Changed all c_function names starting by lowercase c to
       |--    avoid confusing them with Euphoria native functions.
       |--    Implemented htonl, htons, ntohl, ntohs, needed before gethostbyaddr.
       |--    Still not being able of seeing hostent struct
       |-- 0.05,0.06,0.07 pre Aplha July 11th, 1998
       |--    Several changes in naming conventions. Greg
       |--    fixed a problem with HostInfo. Writing the real
       |--    socket access calls and some windows demos.
       |-- 0.08 pre Alpha July 13th, 1998
       |--    Implemented socket, closesocket. Readme file.
       |--    Changed WsockInit to store the stackdata.
       |--    Released LHInfo.exw (Local Host Info demo program).
       |--    Released Stackinfo.exw (Prints stack info)
       |-- 0.09 pre Alpha, 14th July 1998
       |--    Greg has implemented the basics for client server connection
       |--    Added a release note.
       |-- 0.10 pre Alpha, 26th July 1998
       |--    Improved socket tracing
       |-- 0.11 pre Alpha, 30th July 1998
       |--    Greg fixed bug in WsockReadData
       |-- 0.12 pre Alpha, 20th August 1998
       |--    Added text to report the errors
       |--    Turned global most constants
       |-- 0.13 pre Alpha, 26th August 1998
       |--    Cosmetic change csocket--> cSocket
       |--    Added C definitions for all the remaining functions
       |--    Fixed WsockHostInfo to return {HostName,IPAddress}
       |
       |
       |
       |atom    SOCKET,
       |        WSAData,
       |        WSServerNameOrAddress,
       |        phostent
       |
       |------------------------------------------------------------
       |-- SocketTrace allows some log messaging to a console box
       |------------------------------------------------------------
       |global integer SocketTrace              -- Default no tracing = 0
       |
     1 |SocketTrace = 0
       |
       |global sequence StackData               -- To hold Stack info
       |constant FD_SETSIZE = 64
       |
       |
       |-- Commands for ioctlsocket(),  taken from the BSD file fcntl.h.
       |-- Ioctl's have the command encoded in the lower word,
       |-- and the size of any in or out parameters in the upper
       |-- word.  The high 2 bits of the upper word are used
       |-- to encode the in/out status of the parameter; for now
       |-- we restrict parameters to at most 128 bytes.
       |
       |constant IOCPARM_MASK   =  #7F      -- parameters must be < 128 bytes
       |constant IOC_VOID       =  #20000000   -- no parameters
       |constant IOC_OUT        =  #40000000   -- copy out parameters
       |constant IOC_IN         =  #80000000   -- copy in parameters
       |
       |--
       |-- Protocols
       |--
       |constant IPPROTO_IP     =  0  -- dummy for IP
       |constant IPPROTO_ICMP   =  1  -- control message protocol
       |constant IPPROTO_GGP    =  2  -- gateway^2 (deprecated)
       |constant IPPROTO_TCP    =  6  -- tcp
       |constant IPPROTO_PUP    =  12 -- pup
       |constant IPPROTO_UDP    =  17 -- user datagram protocol
       |constant IPPROTO_IDP    =  22 -- xns idp
       |constant IPPROTO_ND     =  77 -- UNOFFICIAL net disk proto
       |
       |constant IPPROTO_RAW    =  255   -- raw IP packet
       |constant IPPROTO_MAX    =  256
       |
       |--
       |-- Port/socket numbers: network standard functions
       |--
       |constant IPPORT_ECHO         =    7
       |constant IPPORT_DISCARD      =    9
       |constant IPPORT_SYSTAT       =    11
       |constant IPPORT_DAYTIME      =    13
       |constant IPPORT_NETSTAT      =    15
       |constant IPPORT_FTP          =    21
       |constant IPPORT_TELNET       =    23
       |constant IPPORT_SMTP         =    25
       |constant IPPORT_TIMESERVER   =    37
       |constant IPPORT_NAMESERVER   =    42
       |constant IPPORT_WHOIS        =    43
       |constant IPPORT_MTP          =    57
       |
       |--
       |-- Port/socket numbers: host specific functions
       |--
       |constant IPPORT_TFTP         =    69
       |constant IPPORT_RJE          =    77
       |constant IPPORT_FINGER       =    79
       |constant IPPORT_TTYLINK      =    87
       |constant IPPORT_SUPDUP       =    95
       |
       |--
       |-- UNIX TCP sockets
       |--
       |constant IPPORT_EXECSERVER   =    512
       |constant IPPORT_LOGINSERVER  =    513
       |constant IPPORT_CMDSERVER    =    514
       |constant IPPORT_EFSSERVER    =    520
       |
       |--
       |-- UNIX UDP sockets
       |--
       |constant IPPORT_BIFFUDP      =    512
       |constant IPPORT_WHOSERVER    =    513
       |constant IPPORT_ROUTESERVER   =   520    -- 520+1 also used
       |
       |--
       |-- Ports < IPPORT_RESERVED are reserved for
       |-- privileged processes (e.g. root).
       |--
       |constant IPPORT_RESERVED     =    1024
       |
       |--
       |-- Link numbers
       |--
       |constant IMPLINK_IP          =    155
       |constant IMPLINK_LOWEXPER    =    156
       |constant IMPLINK_HIGHEXPER   =    158
       |
       |--
       |-- Definitions of bits in internet address integers.
       |-- On subnets, the decomposition of addresses to host and net parts
       |-- is done according to subnet mask, not the masks here.
       |--
       |constant IN_CLASSA_NET       =    #FF000000
       |constant IN_CLASSA_NSHIFT    =    24
       |constant IN_CLASSA_HOST      =    #00FFFFFF
       |constant IN_CLASSA_MAX       =    128
       |
       |constant IN_CLASSB_NET       =    #FFFF0000
       |constant IN_CLASSB_NSHIFT    =    16
       |constant IN_CLASSB_HOST      =    #0000FFFF
       |constant IN_CLASSB_MAX       =    65536
       |
       |constant IN_CLASSC_NET       =    #FFFFFF00
       |constant IN_CLASSC_NSHIFT    =    8
       |constant IN_CLASSC_HOST      =    #000000FF
       |
       |
       |constant INADDR_LOOPBACK     =    #7F000001
       |constant INADDR_NONE         =    -1            --  #FFFFFFFF
       |
       |--
       |-- Socket address, internet style.
       |--
       |
       |constant WSADESCRIPTION_LEN   =   256
       |constant WSASYS_STATUS_LEN    =   128
       |
       |--
       |-- Options for use with [gs]etsockopt at the IP level.
       |--
       |constant IP_OPTIONS  =  1     -- set/get IP per-packet options
       |
       |--
       |-- Definitions related to sockets: types, address families, options,
       |-- taken from the BSD file sys/socket.h.
       |--
       |
       |--
       |-- This is used instead of -1, since the
       |-- SOCKET type is unsigned.
       |--
       |constant VALID_SOCKET   =  (0)
       |
       |global constant SOCKET_ERROR   = (-1)
       |
       |--
       |-- Types
       |--
       |global constant SOCK_STREAM =  1  -- stream socket
       |global constant SOCK_DGRAM  =  2  -- datagram socket
       |constant SOCK_RAW    =  3  -- raw-protocol interface
       |constant SOCK_RDM    =  4  -- reliably-delivered message
       |constant SOCK_SEQPACKET =  5  -- sequenced packet stream
       |
       |--
       |-- Option flags per-socket.
       |--
       |constant SO_DEBUG       = #0001     -- turn on debugging info recording
       |constant SO_ACCEPTCONN  = #0002     -- socket has had listen()
       |constant SO_REUSEADDR   = #0004     -- allow local address reuse
       |constant SO_KEEPALIVE   = #0008     -- keep connections alive
       |constant SO_DONTROUTE   = #0010     -- just use interface addresses
       |constant SO_BROADCAST   = #0020     -- permit sending of broadcast msgs
       |constant SO_USELOOPBACK = #0040     -- bypass hardware when possible
       |constant SO_LINGER      = #0080     -- linger on close if data present
       |constant SO_OOBINLINE   = #0100     -- leave received OOB data in line
       |
       |--
       |-- Additional options.
       |--
       |constant SO_SNDBUF      = #1001  -- send buFFer size
       |constant SO_RCVBUF      = #1002  -- receive buFFer size
       |constant SO_SNDLOWAT    = #1003  -- send low-water mark
       |constant SO_RCVLOWAT    = #1004  -- receive low-water mark
       |constant SO_SNDTIMEO    = #1005  -- send timeout
       |constant SO_RCVTIMEO    = #1006  -- receive timeout
       |constant SO_ERROR       = #1007  -- get error status and clear
       |constant SO_TYPE        = #1008  -- get socket type
       |
       |--
       |-- TCP options.
       |--
       |constant TCP_NODELAY    = #0001
       |
       |--
       |-- Address families.
       |--
       |constant AF_UNSPEC      = 0   -- unspecified
       |constant AF_UNIX        = 1   -- local to host (pipes, portals)
       |global constant AF_INET = 2   -- internetwork: UDP, TCP, etc.
       |constant AF_IMPLINK     = 3   -- arpanet imp addresses
       |constant AF_PUP         = 4   -- pup protocols: e.g. BSP
       |constant AF_CHAOS       = 5   -- mit CHAOS protocols
       |constant AF_NS          = 6   -- XEROX NS protocols
       |constant AF_IPX         = 6   -- IPX and SPX
       |constant AF_ISO         = 7   -- ISO protocols
       |constant AF_OSI         = AF_ISO -- OSI is ISO
       |constant AF_ECMA        = 8   -- european computer manufacturers
       |constant AF_DATAKIT     = 9   -- datakit protocols
       |constant AF_CCITT       = 10  -- CCITT protocols, X.25 etc.
       |constant AF_SNA         = 11  -- IBM SNA
       |constant AF_DECnet      = 12  -- DECnet
       |constant AF_DLI         = 13  -- Direct data link interface
       |constant AF_LAT         = 14  -- LAT
       |constant AF_HYLINK      = 15  -- NSC Hyperchannel
       |constant AF_APPLETALK   = 16  -- AppleTalk
       |constant AF_NETBIOS     = 17  -- NetBios-style addresses
       |
       |constant AF_MAX         = 18
       |
       |
       |--
       |-- Protocol families, same as address families for now.
       |--
       |constant PF_UNSPEC      = AF_UNSPEC
       |constant PF_UNIX        = AF_UNIX
       |constant PF_INET        = AF_INET
       |constant PF_IMPLINK     = AF_IMPLINK
       |constant PF_PUP         = AF_PUP
       |constant PF_CHAOS       = AF_CHAOS
       |constant PF_NS          = AF_NS
       |constant PF_IPX         = AF_IPX
       |constant PF_ISO         = AF_ISO
       |constant PF_OSI         = AF_OSI
       |constant PF_ECMA        = AF_ECMA
       |constant PF_DATAKIT     = AF_DATAKIT
       |constant PF_CCITT       = AF_CCITT
       |constant PF_SNA         = AF_SNA
       |constant PF_DECnet      = AF_DECnet
       |constant PF_DLI         = AF_DLI
       |constant PF_LAT         = AF_LAT
       |constant PF_HYLINK      = AF_HYLINK
       |constant PF_APPLETALK   = AF_APPLETALK
       |
       |constant PF_MAX         = AF_MAX
       |
       |
       |--
       |-- Level number for (get/set)sockopt() to apply to socket itself.
       |--
       |constant SOL_SOCKET     = #FFFF          -- options for socket level
       |
       |--
       |-- Maximum queue length specifiable by listen.
       |--
       |constant SOMAXCONN      = 5
       |
       |constant MSG_OOB        = #1             -- process out-of-band data
       |constant MSG_PEEK       = #2             -- peek at incoming message
       |constant MSG_DONTROUTE  = #4             -- send w/o using routing tables
       |
       |constant MSG_MAXIOVLEN  = 16
       |
       |--
       |-- Define constant based on rfc883, used by gethostbyxxxx() calls.
       |--
       |constant MAXGETHOSTSTRUCT      =  1024
       |
       |--
       |-- Define flags to be used with the WSAAsyncSelect() call.
       |--
       |global constant FD_READ     =  #01
       |global constant FD_WRITE    =  #02
       |global constant FD_OOB      =  #04
       |global constant FD_ACCEPT   =  #08
       |global constant FD_CONNECT  =  #10
       |global constant FD_CLOSE    =  #20
       |global constant SD_READ     =  0
       |global constant SD_SEND     =  1
       |global constant SD_BOTH     =  2
       |--
       |-- All Windows Sockets error constants are biased by WSABASEERR from
       |-- the "normal"
       |--
       |global constant WSABASEERR     = 10000
       |
       |--
       |-- Windows Sockets definitions of regular Microsoft C error constants
       |--
       |global constant WSAEINTR       = (WSABASEERR+4)
       |global constant WSAEBADF       = (WSABASEERR+9)
       |global constant WSAEACCES      = (WSABASEERR+13)
       |global constant WSAEFAULT      = (WSABASEERR+14)
       |global constant WSAEINVAL      = (WSABASEERR+22)
       |global constant WSAEMFILE      = (WSABASEERR+24)
       |
       |--
       |-- Windows Sockets definitions of regular Berkeley error constants
       |--
       |global constant WSAEWOULDBLOCK  =        (WSABASEERR+35)
       |global constant WSAEINPROGRESS  =        (WSABASEERR+36)
       |global constant WSAEALREADY     =        (WSABASEERR+37)
       |global constant WSAENOTSOCK     =        (WSABASEERR+38)
       |global constant WSAEDESTADDRREQ =        (WSABASEERR+39)
       |global constant WSAEMSGSIZE     =        (WSABASEERR+40)
       |global constant WSAEPROTOTYPE   =        (WSABASEERR+41)
       |global constant WSAENOPROTOOPT  =        (WSABASEERR+42)
       |global constant WSAEPROTONOSUPPORT  =    (WSABASEERR+43)
       |global constant WSAESOCKTNOSUPPORT  =    (WSABASEERR+44)
       |global constant WSAEOPNOTSUPP       =    (WSABASEERR+45)
       |global constant WSAEPFNOSUPPORT     =    (WSABASEERR+46)
       |global constant WSAEAFNOSUPPORT     =    (WSABASEERR+47)
       |global constant WSAEADDRINUSE       =    (WSABASEERR+48)
       |global constant WSAEADDRNOTAVAIL    =    (WSABASEERR+49)
       |global constant WSAENETDOWN         =    (WSABASEERR+50)
       |global constant WSAENETUNREACH      =    (WSABASEERR+51)
       |global constant WSAENETRESET        =    (WSABASEERR+52)
       |global constant WSAECONNABORTED     =    (WSABASEERR+53)
       |global constant WSAECONNRESET       =    (WSABASEERR+54)
       |global constant WSAENOBUFS          =    (WSABASEERR+55)
       |global constant WSAEISCONN          =    (WSABASEERR+56)
       |global constant WSAENOTCONN         =    (WSABASEERR+57)
       |global constant WSAESHUTDOWN        =    (WSABASEERR+58)
       |global constant WSAETOOMANYREFS     =    (WSABASEERR+59)
       |global constant WSAETIMEDOUT        =    (WSABASEERR+60)
       |global constant WSAECONNREFUSED     =    (WSABASEERR+61)
       |global constant WSAELOOP            =    (WSABASEERR+62)
       |global constant WSAENAMETOOLONG     =    (WSABASEERR+63)
       |global constant WSAEHOSTDOWN        =    (WSABASEERR+64)
       |global constant WSAEHOSTUNREACH     =    (WSABASEERR+65)
       |global constant WSAENOTEMPTY        =    (WSABASEERR+66)
       |global constant WSAEPROCLIM         =    (WSABASEERR+67)
       |global constant WSAEUSERS           =    (WSABASEERR+68)
       |global constant WSAEDQUOT           =    (WSABASEERR+69)
       |global constant WSAESTALE           =    (WSABASEERR+70)
       |global constant WSAEREMOTE          =    (WSABASEERR+71)
       |
       |--
       |-- Extended Windows Sockets error constant definitions
       |--
       |global constant WSASYSNOTREADY      =    (WSABASEERR+91)
       |global constant WSAVERNOTSUPPORTED  =    (WSABASEERR+92)
       |global constant WSANOTINITIALISED   =    (WSABASEERR+93)
       |
       |--
       |-- Error return codes from gethostbyname() and gethostbyaddr()
       |-- (when using the resolver). Note that these errors are
       |-- retrieved via WSAGetLastError() and must therefore follow
       |-- the rules for avoiding clashes with error numbers from
       |-- specific implementations or language run-time systems.
       |-- For this reason the codes are based at WSABASEERR+1001.
       |-- Note also that [WSA]NO_ADDRESS is defined only for
       |-- compatibility purposes.
       |--
       |
       |-- Authoritative Answer: Host not found
       |global constant WSAHOST_NOT_FOUND   =    (WSABASEERR+1001)
       |global constant HOST_NOT_FOUND      =    WSAHOST_NOT_FOUND
       |
       |-- Non-Authoritative: Host not found, or SERVERFAIL
       |global constant WSATRY_AGAIN        =    (WSABASEERR+1002)
       |global constant TRY_AGAIN           =    WSATRY_AGAIN
       |
       |-- Non recoverable errors, FORMERR, REFUSED, NOTIMP
       |global constant WSANO_RECOVERY      =    (WSABASEERR+1003)
       |global constant NO_RECOVERY         =    WSANO_RECOVERY
       |
       |-- Valid name, no data record of requested type
       |global constant WSANO_DATA          =    (WSABASEERR+1004)
       |global constant NO_DATA             =    WSANO_DATA
       |
       |-- no address, look for MX record --
       |global constant WSANO_ADDRESS       =     WSANO_DATA
       |global constant NO_ADDRESS          =    WSANO_ADDRESS
       |
       |--
       |-- Windows Sockets errors redefined as regular Berkeley error constants
       |--
       |global constant EWOULDBLOCK         =    WSAEWOULDBLOCK
       |global constant EINPROGRESS         =    WSAEINPROGRESS
       |global constant EALREADY            =    WSAEALREADY
       |global constant ENOTSOCK            =    WSAENOTSOCK
       |global constant EDESTADDRREQ        =    WSAEDESTADDRREQ
       |global constant EMSGSIZE            =    WSAEMSGSIZE
       |global constant EPROTOTYPE          =    WSAEPROTOTYPE
       |global constant ENOPROTOOPT         =    WSAENOPROTOOPT
       |global constant EPROTONOSUPPORT     =    WSAEPROTONOSUPPORT
       |global constant ESOCKTNOSUPPORT     =    WSAESOCKTNOSUPPORT
       |global constant EOPNOTSUPP          =    WSAEOPNOTSUPP
       |global constant EPFNOSUPPORT        =    WSAEPFNOSUPPORT
       |global constant EAFNOSUPPORT        =    WSAEAFNOSUPPORT
       |global constant EADDRINUSE          =    WSAEADDRINUSE
       |global constant EADDRNOTAVAIL       =    WSAEADDRNOTAVAIL
       |global constant ENETDOWN            =    WSAENETDOWN
       |global constant ENETUNREACH         =    WSAENETUNREACH
       |global constant ENETRESET           =    WSAENETRESET
       |global constant ECONNABORTED        =    WSAECONNABORTED
       |global constant ECONNRESET          =    WSAECONNRESET
       |global constant ENOBUFS             =    WSAENOBUFS
       |global constant EISCONN             =    WSAEISCONN
       |global constant ENOTCONN            =    WSAENOTCONN
       |global constant ESHUTDOWN           =    WSAESHUTDOWN
       |global constant ETOOMANYREFS        =    WSAETOOMANYREFS
       |global constant ETIMEDOUT           =    WSAETIMEDOUT
       |global constant ECONNREFUSED        =    WSAECONNREFUSED
       |global constant ELOOP               =    WSAELOOP
       |global constant ENAMETOOLONG        =    WSAENAMETOOLONG
       |global constant EHOSTDOWN           =    WSAEHOSTDOWN
       |global constant EHOSTUNREACH        =    WSAEHOSTUNREACH
       |global constant ENOTEMPTY           =    WSAENOTEMPTY
       |global constant EPROCLIM            =    WSAEPROCLIM
       |global constant EUSERS              =    WSAEUSERS
       |global constant EDQUOT              =    WSAEDQUOT
       |global constant ESTALE              =    WSAESTALE
       |global constant EREMOTE             =    WSAEREMOTE
       |
       |constant NumCodes            =    62
       |
       |
       |--
       |-- WinSock error descriptions
       |--
       |
       |-- There are some error messages corresponding to later versions
       |-- of the Winsock 1.1 specification. There are included here for future reference
       |
       |------------------------------------------------------------
       |-- WsockErrorInit   Sets up the global sequence ErrorCodes
       |------------------------------------------------------------
       |global sequence ErrorCodes
       |
       |procedure WsockErrorInit()
       |
       |        ErrorCodes = {
       |   {WSAEINTR,
       |   "WSAEINTR: Interrupted function call"},
       |   {WSAEBADF,
       |   "WSAEBADF: Bad file number"},
       |   {WSAEACCES,
       |   "WSAEACCES: Permission denied"},
       |   {WSAEFAULT,
       |   "WSAEFAULT: Address fault"},
       |   {WSAEINVAL,
       |   "WSAEINVAL: Invalid argument"},
       |   {WSAEMFILE,
       |   "WSAEMFILE: Too many open files"},
       |   {WSAEWOULDBLOCK,
       |   "WSAEWOULDBLOCK: Resource temporarily unavailable (Would block)"},
       |   {WSAEINPROGRESS,
       |   "WSAEINPROGRESS: Operation now in progress"},
       |   {WSAEALREADY,
       |   "WSAEALREADY: Operation already in progress"},
       |   {WSAENOTSOCK,
       |   "WSAENOTSOCK: Socket operation on non-socket"},
       |   {WSAEDESTADDRREQ,
       |   "WSAEDESTADDRREQ: Destination address required"},
       |   {WSAEMSGSIZE,
       |   "WSAEMSGSIZE: Message too long"},
       |   {WSAEPROTOTYPE,
       |   "WSAEPROTOTYPE: Protocol wrong type for socket"},
       |   {WSAENOPROTOOPT,
       |   "WSAENOPROTOOPT: Bad protocol option"},
       |   {WSAEPROTONOSUPPORT,
       |   "WSAEPROTONOSUPPORT: Protocol not supported"},
       |   {WSAESOCKTNOSUPPORT,
       |   "WSAESOCKTNOSUPPORT: Socket type not supported"},
       |   {WSAEOPNOTSUPP,
       |   "WSAEOPNOTSUPP: Operation not supported"},
       |   {WSAEPFNOSUPPORT,
       |   "WSAEPFNOSUPPORT: Protocol family not supported"},
       |   {WSAEAFNOSUPPORT,
       |   "WSAEAFNOSUPPORT: Address family not supported by protocol family"},
       |   {WSAEADDRINUSE,
       |   "WSAEADDRINUSE: Address already in use"},
       |   {WSAEADDRNOTAVAIL,
       |   "WSAEADDRNOTAVAIL: Cannot assign requested address"},
       |   {WSAENETDOWN,
       |   "WSAENETDOWN: Network is down"},
       |   {WSAENETUNREACH,
       |   "WSAENETUNREACH: Network is unreachable"},
       |   {WSAENETRESET,
       |   "WSAENETRESET: Network dropped connection on reset"},
       |   {WSAECONNABORTED,
       |   "WSAECONNABORTED: Software caused connection abort"},
       |   {WSAECONNRESET,
       |   "WSAECONNRESET: Connection reset by peer"},
       |   {WSAENOBUFS,
       |   "WSAENOBUFS: No buffer space available"},
       |   {WSAEISCONN,
       |   "WSAEISCONN: Socket is already connected"},
       |   {WSAENOTCONN,
       |   "WSAENOTCONN: Socket is not connected"},
       |   {WSAESHUTDOWN,
       |   "WSAESHUTDOWN: Cannot send after socket shutdown"},
       |   {WSAETOOMANYREFS,
       |   "WSAETOOMANYREFS: Too many references"},
       |   {WSAETIMEDOUT,
       |   "WSAETIMEDOUT: Connection timed out"},
       |   {WSAECONNREFUSED,
       |   "WSAECONNREFUSED: Connection refused"},
       |   {WSAELOOP,
       |
       |   "WSAELOOP: Loop"},
       |   {WSAENAMETOOLONG,
       |   "WSAENAMETOOLONG: Name too long"},
       |   {WSAEHOSTDOWN,
       |   "WSAEHOSTDOWN: Host is down"},
       |   {WSAEHOSTUNREACH,
       |   "WSAEHOSTUNREACH: No route to host"},
       |   {WSAENOTEMPTY,
       |   "WSAENOTEMPTY: Directory not empty"},
       |   {WSAEPROCLIM,
       |   "WSAEPROCLIM: Too many processes"},
       |   {WSAEUSERS,
       |   "WSAEUSERS: Too many users"},
       |   {WSAEDQUOT,
       |   "WSAEDQUOT: Disk quota"},
       |   {WSAESTALE,
       |   "WSAESTALE: Stale"},
       |   {WSAEREMOTE,
       |   "WSAEREMOTE: Remote"},
       |   {WSASYSNOTREADY,
       |   "SYSNOTREADY: Network subsystem is unavailable"},
       |   {WSAVERNOTSUPPORTED,
       |   "VERNOTSUPPORTED: WINSOCK.DLL version out of range"},
       |   {WSANOTINITIALISED,
       |   "NOTINITIALISED: Successful Startup() not yet performed"},
       |-- {WSAEDISCON,
       |-- "WSAEDISCON: Graceful shutdown in progress"},
       |   {WSAHOST_NOT_FOUND,
       |   "HOST_NOT_FOUND: Host not found"},
       |   {WSATRY_AGAIN,
       |   "TRY_AGAIN: Non-authoritative host not found"},
       |   {WSANO_RECOVERY,
       |   "NO_RECOVERY: Non-recoverable error"},
       |   {WSANO_DATA,
       |   "NO_DATA: Valid name, no data record of requested type"},
       |-- {WSAENOMORE,
       |-- "WSAENOMORE: "},
       |-- {WSAECANCELLED,
       |-- "WSAECANCELLED: Cancelled"},
       |-- {WSAEINVALIDPROCTABLE,
       |-- "WSAEINVALIDPROCTABLE: Invalid procedure table from service provider"},
       |-- {WSAEINVALIDPROVIDER,
       |-- "WSAEINVALIDPROVIDER: Invalid service provider version number"},
       |-- {WSAEPROVIDERFAILEDINIT,
       |-- "WSAEPROVIDERFAILEDINIT: Unable to initialize a service provider"},
       |-- {WSASYSCALLFAILURE,
       |-- "WSASYSCALLFAILURE: System call failure"},
       |-- {WSASERVICE_NOT_FOUND,
       |-- "WSASERVICE_NOT_FOUND: Service not found"},
       |-- {WSATYPE_NOT_FOUND,
       |-- "WSATYPE_NOT_FOUND: Type not found"},
       |-- {WSA_E_NO_MORE,
       |-- "WSA_E_NO_MORE: "},
       |-- {WSA_E_CANCELLED,
       |-- "WSA_E_CANCELLED: "},
       |-- {WSAEREFUSED,
       |-- "WSAEREFUSED: Refused"},
       |   {-1,
       |   "Unknown Error Code"}}
       |end procedure
       |
       |
       |--
       |-- Socket function and procedures
       |--
       |
       |    integer cWSAStartup,
       |      cWSACleanup,
       |      cInet_addr,
       |      cWSAGetLastError,
       |      cNtohl,
       |      cNtohs,
       |      cHtonl,
       |      cHtons,
       |      cGetHostByName,
       |      cGetHostByAddr,
       |      cGetHostName,
       |      cCloseSocket,
       |      cSocket,
       |      cAccept,
       |      cBind,
       |      cListen,
       |      cRecv,
       |      cSend,
       |
       |-- Not implemented so far:
       |
       |      cConnect,
       |      cIoctlsocket,
       |      cGetpeername,
       |      cGetsockname,
       |      cGetsockopt,
       |      cInet_ntoa,
       |      cRecvfrom,
       |      cSelect,
       |      cSendto,
       |      cSetsockop,
       |      cShutdown,
       |      cWSASetLastError,
       |      cWSAIsBlocking,
       |      cWSAUnhookBlockingHook,
       |      cWSASetBlockingHook,
       |      cWSACancelBlockingCall,
       |      cWSACancelAsyncRequest,
       |      cWSAAsyncSelect,
       |      cWSAAsyncGetHostByName,
       |      cWSAAsyncGetHostByAddr
       |
       |include dll.e
       |include msgbox.e
       |
     1 |WSAData = allocate(512)
     1 |WSServerNameOrAddress = allocate(128)
       |
       |--define struct prototypes
       |constant
       |    sin_family = allot(Word),
       |    sin_port   = allot(Word),
       |    sin_addr    = allot(Lpsz),
       |    sin_zero   = allot(8),
       |    SIZE_OF_SOCKADDR = allotted_size(),
       |
       |    in_addr   = allot(Lpsz),
       |    SIZE_OF_INADDR = allotted_size(),
       |
       |    h_name      = allot(Lpsz),
       |    h_aliases   = allot(Lpsz),
       |    h_addrtype  = allot(Word),
       |    h_length    = allot(Word),
       |    h_addr_list = allot(Lpsz),
       |    SIZE_OF_HOSTENT = allotted_size()
       |
       |
     1 |SocketTrace = 0                         -- Default no tracing = 0
       |
       |-----------------------------------------------
       |-- Say
       |-----------------------------------------------
       |
       |
       |global function allocate_struct( integer size )
       |
       |	-- allocate space for a structure
       |	-- and initialize to zero
       |	
       |	atom at
       |	
     1 |	at  = allocate( size )
     1 |	mem_set( at, 0, size )
       |	
     1 |	return at
       |	
       |end function
       |
       |global procedure Say(sequence s, sequence t)
       |    integer response
       |    response = message_box(s,t, MB_OK)
       |end procedure
       |
       |
       |-- Mod JCM July 26
       |
       |-----------------------------------------------
       |-- WsockPuts("Text") Conditionally puts(1,...
       |--     if sockettracing is active
       |-----------------------------------------------
       |procedure WsockPuts(sequence Message)
       |
       |       if SocketTrace = 1 then
       |       puts(1,Message)
       |       end if
       |end procedure
       |-- end mod
       |
       |-- Mod JCM 20th Aug
       |-----------------------------------------------
       |-- WsockTellError
       |-----------------------------------------------
       |
       |global function WsockTellError(atom Code)
       |   integer response, Idx
       |
       |   if Code = 0 then
       |      return {}
       |   else
       |   Idx = 1
       |      while (Idx < 52) do
       |   if Code = ErrorCodes[Idx][1] then
       |      return ErrorCodes[Idx][2]
       |      exit
       |   end if
       |   Idx = Idx + 1
       |   if Idx = 52 then
       |      return "Unknown Error Code"
       |   end if
       |      end while
       |   end if
       |end function
       |-- end mod
       |-- mod JCM July 13
       |
       |atom Winsock
       |
       |----------------------------------------------------
       |-- Procedure WSockInit
       |--     Initializes the environment, opens the .dll
       |----------------------------------------------------
       |global function WsockInit()
       |
       |        integer WsockReturn
       |        atom version
       |        sequence line, s, l1, l2, l3, l4, l5, l6, l7
       |        object NextChar integer NextIndex
       |        WsockErrorInit()
       |        Winsock = open_dll("wsock32")
       |        WsockReturn =0
       |        if Winsock = NULL then
       |        Say("Dll not found: Wsock32.dll ","WINSOCK.EW")
       |      WsockReturn = -1
       |        end if
       |
       |
       |-- Set up the calls to the .dll
       |        cWSAStartup = define_c_func(Winsock,"WSAStartup",
       |    {C_SHORT,C_POINTER},C_INT)
       |
       |
       |-- Does a WSAStartup to init the stuff
       |        StackData = {}
       |        version = bytes_to_int({1,1,0,0}) -- request for specific version
       |        WsockReturn = c_func(cWSAStartup, {version,WSAData})
       |
       |      l1 = sprintf("Winsock version requested:%d.",peek({WSAData,1}))
       |      l1 = l1 & sprintf("%d",peek({WSAData+1,1}))
       |      l2 = sprintf("Winsock highest version supported by this .dll: %d.",
       |        peek({WSAData+2,1}))
       |      l2 = l2 & sprintf("%d",peek({WSAData+3,1}))
       |
       |        -- Prints the description
       |      line={}
       |      for i=4 to 256 do
       |    NextChar =peek({WSAData+i,1})
       |    if (NextChar[1] = 0) then
       |        l4 = sprintf("%s",{line})
       |        NextIndex = i+1
       |        exit
       |    end if
       |      line = line & NextChar
       |      end for
       |
       |        -- Prints the status
       |      line = {}
       |      for i=261 to 389 do
       |    NextChar =peek({WSAData+i,1})
       |    if (NextChar[1] = 0) then
       |        l5 = sprintf("%s", {line})
       |        NextIndex = i+1
       |        exit
       |    end if
       |    line = line & NextChar
       |      end for
       |
       |        -- Prints MaxSockets
       |      s=peek({WSAData+390,2}) &0 &0
       |      l6 = sprintf("Maximum number of sockets a process can handle: %d",
       |        (bytes_to_int(s)))
       |
       |
       |        -- Prints Maxdatagram
       |      s=peek({WSAData+392,2})&0&0
       |      l7 = sprintf("Size in Bytes of the largest datagram: %d",
       |        (bytes_to_int(s)))
       |
       |        -- Store data in Stackdata
       |
       |        StackData = append(StackData, l1)
       |        StackData = append(StackData, l2)
       |        StackData = append(StackData, l4)
       |        StackData = append(StackData, l5)
       |        StackData = append(StackData, l6)
       |        StackData = append(StackData, l7)
       |
       |      -- Link all the library fuctions needed
       |
       |    cWSACleanup         = define_c_func(Winsock,"WSACleanup",{},C_INT)
       |
       |    cInet_addr         =  define_c_func(Winsock,"inet_addr",
       |            {C_POINTER},C_LONG)
       |
       |    cWSAGetLastError   = define_c_func(Winsock,"WSAGetLastError",{}, C_INT)
       |
       |    cNtohl           = define_c_func(Winsock,"ntohl", {C_LONG}, C_LONG)
       |
       |    cNtohs           = define_c_func(Winsock,"ntohs", {C_SHORT}, C_SHORT)
       |    cHtonl           = define_c_func(Winsock,"htonl", {C_LONG}, C_LONG)
       |    cHtons           = define_c_func(Winsock,"htons", {C_SHORT}, C_SHORT)
       |
       |    cGetHostByName = define_c_func(Winsock,"gethostbyname",
       |            {C_POINTER},C_POINTER)
       |
       |    cGetHostByAddr = define_c_func(Winsock,"gethostbyaddr",
       |            {C_POINTER, C_INT, C_INT},C_POINTER)
       |
       |    cGetHostName = define_c_func(Winsock, "gethostname",
       |            {C_POINTER,C_INT}, C_LONG)
       |
       |    cSocket = define_c_func(Winsock, "socket",{C_INT,C_INT,C_INT},C_INT)
       |
       |    cCloseSocket = define_c_proc(Winsock, "closesocket",{C_INT})
       |
       |    cConnect = define_c_func(Winsock, "connect", {C_INT,C_POINTER,C_INT},C_INT)
       |    cBind = define_c_func(Winsock, "bind", {C_INT,C_POINTER,C_INT},C_INT)
       |    cListen = define_c_proc(Winsock, "listen", {C_INT,C_INT})
       |    cAccept = define_c_func(Winsock, "accept", {C_INT, C_POINTER,C_INT},C_INT)
       |    cRecv = define_c_func(Winsock, "recv", {C_INT, C_POINTER, C_INT, C_INT}, C_INT)
       |    cSend = define_c_func(Winsock, "send", {C_INT, C_POINTER, C_INT, C_INT}, C_INT)
       |    cWSAAsyncSelect = define_c_func(Winsock, "WSAAsyncSelect",
       |             {C_INT,C_LONG,C_INT,C_LONG}, C_INT)
       |    cWSAAsyncGetHostByName = define_c_func(Winsock, "WSAAsyncGetHostByName",
       |             {C_INT, C_UINT, C_POINTER,C_POINTER,
       |              C_INT},C_INT)
       |    cWSAAsyncGetHostByAddr = define_c_func(Winsock, "WSAAsyncGetHostByAddr",
       |             {C_INT, C_UINT, C_POINTER, C_INT, C_INT,
       |              C_POINTER, C_INT},C_INT)
       |    cIoctlsocket = define_c_func(Winsock, "Ioctlsocket", {C_INT, C_LONG,
       |                C_POINTER}, C_INT)
       |    cGetpeername = define_c_func(Winsock, "getpeername",
       |           {C_INT,C_POINTER,C_POINTER},C_INT)
       |    cGetsockname = define_c_func(Winsock, "getsockname",
       |               {C_UINT,C_POINTER,C_INT},C_INT)
       |    cGetsockopt = define_c_func(Winsock, "cGetsockopt",
       |              {C_INT,C_INT,C_INT,C_POINTER,C_POINTER},C_INT)
       |    cInet_ntoa = define_c_func(Winsock, "inet_ntoa", {C_POINTER},C_POINTER)
       |    cRecvfrom = define_c_func(Winsock, "Recvfrom",
       |          {C_INT,C_POINTER,C_INT,C_INT,C_POINTER},C_INT)
       |    cSelect = define_c_func(Winsock, "Select",
       |          {C_INT,C_POINTER,C_POINTER,C_POINTER,C_POINTER},C_INT)
       |    cSendto = define_c_func(Winsock, "Sendto",
       |      {C_INT,C_POINTER,C_INT,C_INT,C_POINTER,C_INT},C_INT)
       |    cSetsockop = define_c_func(Winsock, "Setsockop",
       |              {C_INT,C_INT,C_INT,C_POINTER,C_INT},C_INT)
       |    cShutdown = define_c_func(Winsock, "shutdown",
       |              {C_INT,C_INT},C_INT)
       |    cWSASetLastError = define_c_proc(Winsock, "WSASetLastError",
       |              {C_INT})
       |    cWSAIsBlocking = define_c_func(Winsock, "WSAIsBlocking",
       |              {},C_INT)
       |    cWSAUnhookBlockingHook = define_c_func(Winsock, "WSAUnhookBlockingHook",
       |              {},C_INT)
       |    cWSASetBlockingHook = define_c_func(Winsock, "WSASetBlockingHook",
       |              {C_POINTER},C_POINTER)
       |    cWSACancelBlockingCall = define_c_func(Winsock, "WSACancelBlockingCall",
       |              {},C_INT)
       |    cWSACancelAsyncRequest = define_c_func(Winsock, "WSACancelAsyncRequest",
       |              {C_LONG},C_INT)
       |    return WsockReturn
       |
       |end function
       |
       |----------------------------------------------------------
       |-- pokew
       |----------------------------------------------------------
       |global procedure pokew(atom addr,object w) -- poke word
       |    if atom(w) then
       |      poke(addr,{remainder(w,256),floor(w/256)})
       |    else
       |      for i = 1 to length(w) do
       |        poke(addr+(i-1)*2,{remainder(w[i],256),floor(w[i]/256)})
       |      end for
       |    end if
       |end procedure
       |
       |--------------------------------------------------------------
       |-- peekw
       |--------------------------------------------------------------
       |global function peekw(object addr)
       |sequence data
       |    if atom(addr) then
       |        return peek(addr)+peek(addr+1)*256
       |    else
       |      data = {}
       |      for i = 1 to addr[2] do
       |        data = data & peek(addr[1]+i-1)+peek(addr[1]+i-1)*256
       |      end for
       |      return data
       |    end if
       |end function
       |
       |--------------------------------------------------------------
       |--  WsockRelease
       |--------------------------------------------------------------
       |
       |global function WsockRelease()
       |    integer WsockReturn
       |    WsockReturn = c_func(cWSACleanup, {})
       |    return WsockReturn
       |end function
       |
       |--------------------------------------------------------------
       |--  WSAGetLastError
       |--------------------------------------------------------------
       |global function WSAGetLastError()
       |    return c_func(cWSAGetLastError,{})
       |end function
       |
       |--------------------------------------------------------------
       |--  WsockGetHostName()
       |--
       |--  Returns the local host name. Returns {} if hostname cannot
       |--  be resolved
       |------------------------------------------------------------
       |global function WsockGetHostName()
       |    atom loc
       |    integer len
       |    sequence temp
       |    temp = repeat(0,256)
       |    loc = allocate_string(temp)
       |    if loc = 0 then
       |        return {}
       |    end if
       |    len = 256
       |    if c_func(cGetHostName,{loc,len}) = SOCKET_ERROR then
       |        return {}
       |    end if
       |    temp = peek_string(loc)
       |    free(loc)
       |    return temp
       |end function
       |
       |--------------------------------------------------------------
       |--WsockGetIP
       |--
       |--  Returns the IP address of a hostname, returns {} on fail.
       |--  If hostname = "", returns the local machine IP
       |--------------------------------------------------------------
       |global function WsockGetIP(sequence hname)
       |    atom loc, sa
       |    integer len
       |    sequence temp, ip
       |    if length(hname) = 0 then
       |        hname = WsockGetHostName()
       |        if length(hname) = 0 then
       |      return {}
       |        end if
       |    end if
       |    loc = allocate_string(hname)
       |    if loc = 0 then
       |        return {}
       |    end if
       |    sa = c_func(cGetHostByName, {loc})
       |    if sa = 0 then
       |       Say("Cannot resolve " & hname & "IP address","Winsock Error")
       |       free(loc)
       |       return {}
       |    end if
       |
       |    free(loc)
       |
       |    len = fetch(sa, h_length)
       |    temp = peek({peek4u(peek4u(sa+12)),len})
       |
       |    --free(sa)
       |
       |    ip = {}
       |    for x = 1 to length(temp) do
       |        ip=ip & sprintf("%d",temp[x]) & "."
       |    end for
       |    ip = ip[1..length(ip)-1]
       |
       |    return ip
       |end function
       |
       |--------------------------------------------------------------
       |-- WsockHostInfo
       |--
       |--      Returns a sequence containing {HostName, IPAddress}
       |--      given a symbolic or ip address
       |--      Returns an error if the host is unknown
       |--
       |--------------------------------------------------------------
       |
       |global function WsockHostInfo(sequence HostNameOrAddress)
       |
       |    atom InetAddress, tmp
       |    atom HostId, HostAddr, pHostName, ptr
       |    sequence HostDescription, HostName, Info, temp, IPAddress
       |    atom phostent                           -- points to hostent struct
       |
       |    phostent = allocate_struct(SIZE_OF_HOSTENT)
       |    InetAddress = allocate(SIZE_OF_INADDR)
       |
       |    if length(HostNameOrAddress) = 0 then
       |        temp = WsockGetHostName()
       |        HostId = allocate_string(temp)
       |        tmp = INADDR_NONE
       |    else
       |        HostId = allocate_string(HostNameOrAddress)
       |        tmp = c_func(cInet_addr, {HostId})
       |    end if
       |
       |    if tmp = INADDR_NONE then  -- assume name
       |        phostent = c_func(cGetHostByName, {HostId})
       |    else
       |        poke4(InetAddress,tmp)
       |        phostent = c_func(cGetHostByAddr,{InetAddress,4,AF_INET})
       |    end if
       |
       |    if phostent = 0 then
       |        free(HostId)
       |        free(InetAddress)
       |        return {{},{}} --return empty {} for error
       |    end if
       |
       |    HostName = fetch(phostent, h_name)
       |
       |    IPAddress = WsockGetIP(HostName)
       |    free(HostId)
       |    --free(phostent)
       |    free(InetAddress)
       |    return {HostName,IPAddress}
       |end function
       |
       |--------------------------------------------------------------
       |-- WsockCloseSocket
       |--------------------------------------------------------------
       |global procedure WsockCloseSocket(integer nsocket)
       |    c_proc(cCloseSocket, {nsocket})
       |end procedure
       |
       |-------------------------------------------------------------
       |-- WsockSocket
       |-------------------------------------------------------------
       |
       |global function WsockSocket(integer family, integer stype)
       |    return c_func(cSocket, {family,stype,0})
       |end function
       |
       |--------------------------------------------------------------
       |-- Ntohs
       |--------------------------------------------------------------
       |global function Ntohs(integer number)
       |    --Convert Net Byte Order to Host Byte Order short integer (16 bits)
       |    --and_bits is neccessary because c_func return garbage in the upper
       |    --16 bits for some strange reason. Should be fixed in the next release
       |    --of Euphoria
       |    integer x
       |    x = c_func(cNtohs, {number})
       |    return and_bits(x,#FFFF)
       |end function
       |
       |---------------------------------------------------------------
       |-- Htons
       |---------------------------------------------------------------
       |global function Htons(integer number)
       |    --Convert Host Byte Order to Net Byte Order short integer (16 bits)
       |    --and_bits is neccessary because c_func returns garbage in the upper
       |    --16 bits for some strange reason. Should be fixed in the next release
       |    --of Euphoria
       |    integer x
       |    x = c_func(cHtons, {number})
       |    return and_bits(x,#FFFF)
       |end function
       |
       |------------------------------------------------------
       |-- WsockCallSocket
       |-- MOD GH 7/13/98 REV B
       |------------------------------------------------------
       |global function WsockCallSocket(sequence HostNameOrAddress, integer portnum)
       |    integer sock, len, family, tracestatus, port
       |    atom sa, phostent, InetAddress, addr_ptr, HostId 
       |    sequence HostIP, temp, ip
       |    
       |    tracestatus = SocketTrace
       |    
       |--    SocketTrace = 0 --turn it off for now
       |    temp = WsockHostInfo(HostNameOrAddress)
       |	
       |	--puts(1,temp[2])
       |--    SocketTrace = tracestatus --restore SocketTrace
       |
       |    if length(temp) = 0 then
       |       return SOCKET_ERROR
       |    end if
       |-- MOD JCM to reflect changes in WsockHostInfo
       |    HostIP = temp[2]
       |    if length(HostIP) = 0 then
       |       return SOCKET_ERROR
       |    end if
       |
       |    HostId = allocate_string(HostIP)
       |
       |    if HostId = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    addr_ptr = c_func(cInet_addr, {HostId})
       |
       |    if addr_ptr = 0 then      -- not a valid ip address
       |        free(HostId)
       |        return SOCKET_ERROR
       |    end if
       |
       |    free(HostId)
       |
       |    InetAddress = allocate(4)
       |
       |    if InetAddress = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    poke4(InetAddress,addr_ptr)
       |
       |    phostent = c_func(cGetHostByAddr,{InetAddress,4,AF_INET})
       |
       |    if phostent = 0 then
       |         free(InetAddress)
       |         return SOCKET_ERROR --return -1 for error
       |    end if
       |
       |    free(InetAddress)
       |
       |    sa = allocate(16)
       |
       |    if sa = 0 then
       |        return SOCKET_ERROR
       |    end if
       |    
       |    mem_set(sa,0,16)
       |    
       |    --set the family
       |    mem_copy(sa,phostent+8,2)
       |    
       |    --set the portnum
       |   temp = int_to_bytes(and_bits(c_func(cHtons, {portnum}),#0000FFFF))
       |    poke(sa+2, temp[1..2])
       |    
       |    --set the address
       |    poke4(sa+4, addr_ptr)
       |    
       |    --MOD JGH 7/27/98
       |
       |--=================================================
       |-- BJACKSON 16 November 1999
       |-- if socketTrace is off, then family is undefined.
       |--=================================================
       |
       |    family = bytes_to_int(peek({sa,2}) & {0,0})
       |
       |    if SocketTrace !=0 then
       |        ip = peek({sa+4, 4})
       |        port = bytes_to_int(peek({sa+2,2}) & {0,0})
       |        printf(1, "Socket family is %d\n",family)
       |        printf(1, "IP is %d.%d.%d.%d\n",{ip[1],ip[2],ip[3],ip[4]}) 
       |      printf(1, "Host port is %d\n", and_bits(c_func(cNtohs,{port}),
       |                        #0000FFFF))
       |    end if
       |    --END MOD
       |    
       |    sock = c_func(cSocket,{family,SOCK_STREAM,0})
       |    if sock = SOCKET_ERROR then
       |      WsockPuts("Couldn't get socket!\n")
       |        free(sa)
       |        return SOCKET_ERROR 
       |     end if
       |    
       |    if c_func(cConnect, {sock, sa, 16}) = SOCKET_ERROR then
       |      WsockPuts(sprintf("Could not connect on port %d\n", portnum))
       |        c_proc(cCloseSocket,{sock})
       |        free(sa)
       |        return SOCKET_ERROR
       |    end if    
       |
       |    return sock
       |
       |end function
       |
       |global function WSAAsyncSelect(integer s, atom hwnd, atom Msg, atom events)
       |    return c_func(cWSAAsyncSelect, {s,hwnd,Msg,events})
       |end function
       |
       |
       |global function Wsock_new(sequence HostNameOrAddress, integer portnum,atom hwnd, atom Msg,atom events)
       |    integer sock, len, family, tracestatus, port
       |    atom sa, phostent, InetAddress, addr_ptr, HostId 
       |    sequence HostIP, temp, ip
       |	object ret
       |    
       |    tracestatus = SocketTrace
       |    
       |--    SocketTrace = 0 --turn it off for now
       |    temp = WsockHostInfo(HostNameOrAddress)
       |	
       |	--puts(1,temp[2])
       |--    SocketTrace = tracestatus --restore SocketTrace
       |
       |    if length(temp) = 0 then
       |       return SOCKET_ERROR
       |    end if
       |-- MOD JCM to reflect changes in WsockHostInfo
       |    HostIP = temp[2]
       |    if length(HostIP) = 0 then
       |       return SOCKET_ERROR
       |    end if
       |
       |    HostId = allocate_string(HostIP)
       |
       |    if HostId = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    addr_ptr = c_func(cInet_addr, {HostId})
       |
       |    if addr_ptr = 0 then      -- not a valid ip address
       |        free(HostId)
       |        return SOCKET_ERROR
       |    end if
       |
       |    free(HostId)
       |
       |    InetAddress = allocate(4)
       |
       |    if InetAddress = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    poke4(InetAddress,addr_ptr)
       |
       |    phostent = c_func(cGetHostByAddr,{InetAddress,4,AF_INET})
       |
       |    if phostent = 0 then
       |         free(InetAddress)
       |         return SOCKET_ERROR --return -1 for error
       |    end if
       |
       |    free(InetAddress)
       |
       |    sa = allocate(16)
       |
       |    if sa = 0 then
       |        return SOCKET_ERROR
       |    end if
       |    
       |    mem_set(sa,0,16)
       |    
       |    --set the family
       |    mem_copy(sa,phostent+8,2)
       |    
       |    --set the portnum
       |   temp = int_to_bytes(and_bits(c_func(cHtons, {portnum}),#0000FFFF))
       |    poke(sa+2, temp[1..2])
       |    
       |    --set the address
       |    poke4(sa+4, addr_ptr)
       |    
       |    --MOD JGH 7/27/98
       |
       |--=================================================
       |-- BJACKSON 16 November 1999
       |-- if socketTrace is off, then family is undefined.
       |--=================================================
       |
       |    family = bytes_to_int(peek({sa,2}) & {0,0})
       |	
       |	--Set the family
       |    store(sa, sin_family, AF_INET)
       |
       |    --set the portnum
       |    store(sa, sin_port, Htons(portnum))
       |
       |    --family = bytes_to_int(peek({sa,2}) & {0,0})
       |    family = fetch(sa, sin_family)
       |
       |    if 1=0 then
       |        ip = peek({sa+4, 4})
       |        port = bytes_to_int(peek({sa+2,2}) & {0,0})
       |        printf(1, "Socket family is %d\n",family)
       |        printf(1, "IP is %d.%d.%d.%d\n",{ip[1],ip[2],ip[3],ip[4]}) 
       |      printf(1, "Host port is %d\n", and_bits(c_func(cNtohs,{port}),
       |                        #0000FFFF))
       |    end if
       |    --END MOD
       |	
       |	
       |	
       |	
       |    
       |    sock = c_func(cSocket,{family,SOCK_STREAM,6})
       |    if sock = SOCKET_ERROR then
       |      WsockPuts("Couldn't get socket!\n")
       |        free(sa)
       |        return SOCKET_ERROR 
       |     end if
       |	 
       |	ret = WSAAsyncSelect(sock, hwnd, Msg, events)
       |    if c_func(cConnect, {sock, sa, SIZE_OF_SOCKADDR}) = SOCKET_ERROR then
       |        if WSAGetLastError() != WSAEWOULDBLOCK then
       |      c_proc(cCloseSocket,{sock})
       |      free(sa)
       |      return SOCKET_ERROR
       |        end if
       |    end if
       |	 
       |
       |    return sock
       |
       |end function
       |
       |global function Wsock_newblocking(sequence HostNameOrAddress, integer portnum,atom hwnd, atom Msg,atom events)
       |    integer sock, len, family, tracestatus, port
       |    atom sa, phostent, InetAddress, addr_ptr, HostId 
       |    sequence HostIP, temp, ip
       |	object ret
       |    
       |    tracestatus = SocketTrace
       |    
       |--    SocketTrace = 0 --turn it off for now
       |    temp = WsockHostInfo(HostNameOrAddress)
       |	
       |	--puts(1,temp[2])
       |--    SocketTrace = tracestatus --restore SocketTrace
       |
       |    if length(temp) = 0 then
       |       return SOCKET_ERROR
       |    end if
       |-- MOD JCM to reflect changes in WsockHostInfo
       |    HostIP = temp[2]
       |    if length(HostIP) = 0 then
       |       return SOCKET_ERROR
       |    end if
       |
       |    HostId = allocate_string(HostIP)
       |
       |    if HostId = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    addr_ptr = c_func(cInet_addr, {HostId})
       |
       |    if addr_ptr = 0 then      -- not a valid ip address
       |        free(HostId)
       |        return SOCKET_ERROR
       |    end if
       |
       |    free(HostId)
       |
       |    InetAddress = allocate(4)
       |
       |    if InetAddress = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    poke4(InetAddress,addr_ptr)
       |
       |    phostent = c_func(cGetHostByAddr,{InetAddress,4,AF_INET})
       |
       |    if phostent = 0 then
       |         free(InetAddress)
       |         return SOCKET_ERROR --return -1 for error
       |    end if
       |
       |    free(InetAddress)
       |
       |    sa = allocate(16)
       |
       |    if sa = 0 then
       |        return SOCKET_ERROR
       |    end if
       |    
       |    mem_set(sa,0,16)
       |    
       |    --set the family
       |    mem_copy(sa,phostent+8,2)
       |    
       |    --set the portnum
       |   temp = int_to_bytes(and_bits(c_func(cHtons, {portnum}),#0000FFFF))
       |    poke(sa+2, temp[1..2])
       |    
       |    --set the address
       |    poke4(sa+4, addr_ptr)
       |    
       |    --MOD JGH 7/27/98
       |
       |--=================================================
       |-- BJACKSON 16 November 1999
       |-- if socketTrace is off, then family is undefined.
       |--=================================================
       |
       |    family = bytes_to_int(peek({sa,2}) & {0,0})
       |	
       |	--Set the family
       |    store(sa, sin_family, AF_INET)
       |
       |    --set the portnum
       |    store(sa, sin_port, Htons(portnum))
       |
       |    --family = bytes_to_int(peek({sa,2}) & {0,0})
       |    family = fetch(sa, sin_family)
       |
       |    if 1=0 then
       |        ip = peek({sa+4, 4})
       |        port = bytes_to_int(peek({sa+2,2}) & {0,0})
       |        printf(1, "Socket family is %d\n",family)
       |        printf(1, "IP is %d.%d.%d.%d\n",{ip[1],ip[2],ip[3],ip[4]}) 
       |      printf(1, "Host port is %d\n", and_bits(c_func(cNtohs,{port}),
       |                        #0000FFFF))
       |    end if
       |    --END MOD
       |	
       |	
       |	
       |	
       |    
       |    sock = c_func(cSocket,{family,SOCK_STREAM,6})
       |    if sock = SOCKET_ERROR then
       |      WsockPuts("Couldn't get socket!\n")
       |        free(sa)
       |        return SOCKET_ERROR 
       |     end if
       |	 
       |	--ret = WSAAsyncSelect(sock, hwnd, Msg, events)
       |    if c_func(cConnect, {sock, sa, SIZE_OF_SOCKADDR}) = SOCKET_ERROR then
       |        if WSAGetLastError() != WSAEWOULDBLOCK then
       |      c_proc(cCloseSocket,{sock})
       |      free(sa)
       |      return SOCKET_ERROR
       |        end if
       |    end if
       |	 
       |
       |    return sock
       |
       |end function
       |
       |global function WsockReadData222(integer socket, integer bytestoread)
       |
       |    atom buffer, buffer_ptr
       |    integer bcount, bread
       |    sequence temp
       |
       |    if bytestoread <= 0 then
       |       return SOCKET_ERROR --nothing to recv
       |    end if
       |
       |    bcount = 0
       |    bread = 0
       |    temp = {}
       |
       |    buffer = allocate_struct(bytestoread)
       |
       |    if buffer = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    buffer_ptr = buffer
       |
       |      bread=c_func(cRecv, {socket, buffer_ptr, bytestoread-bcount,0})
       |
       |      if bread <= 0 or WSAGetLastError() = WSAEWOULDBLOCK then
       |       -- if  WSAGetLastError() = WSAEWOULDBLOCK then
       |          free(buffer)
       |          return WSAGetLastError()
       |        --elsif bread <= 0 then
       |        --  exit
       |        --end if
       |      end if
       |
       |      bcount = bcount + bread
       |      buffer_ptr = buffer_ptr + bread
       |
       |    if buffer_ptr > buffer then  --make sure we have something to pass back
       |        temp = peek({buffer, buffer_ptr-buffer})
       |    else
       |   free(buffer)
       |   return SOCKET_ERROR
       |    end if
       |    free(buffer)
       |    return temp
       |end function
       |
       |
       |--------------------------------------------------
       |-- WsockListenSocket
       |--------------------------------------------------
       |
       |global function WsockListenSocket(integer portnum)
       |    integer sock, family, port
       |    atom sa
       |
       |    sa = allocate_struct(SIZE_OF_SOCKADDR)
       |
       |    if sa = 0 then
       |       return SOCKET_ERROR
       |    end if
       |
       |    --Set the family
       |    store(sa, sin_family, AF_INET)
       |
       |    --set the portnum
       |    store(sa, sin_port, Htons(portnum))
       |
       |    --family = bytes_to_int(peek({sa,2}) & {0,0})
       |    family = fetch(sa, sin_family)
       |
       |    sock = c_func(cSocket,{family,SOCK_STREAM,0})
       |    if sock = SOCKET_ERROR then
       |        free(sa)
       |        return SOCKET_ERROR
       |    end if
       |
       |    if c_func(cBind, {sock, sa, SIZE_OF_SOCKADDR}) = SOCKET_ERROR then
       |        c_proc(cCloseSocket,{sock})
       |        free(sa)
       |        return SOCKET_ERROR
       |    end if
       |    free(sa)
       |    c_proc(cListen, {sock,3})
       |    return sock
       |end function
       |
       |-------------------------------------------------------------
       |-- Accept
       |-------------------------------------------------------------
       |global function WsockAccept(integer socket)
       |    return c_func(cAccept, {socket, NULL, NULL})
       |end function
       |
       |-------------------------------------------------------------
       |-- WsockReadData
       |--
       |--  Reads data sent over a socket. Return a 1-D sequence
       |--  containing the data or SOCKET_ERROR on error.
       |-------------------------------------------------------------
       |global function WsockReadData(integer socket, integer bytestoread)
       |
       |    atom buffer, buffer_ptr
       |    integer bcount, bread
       |    sequence temp
       |
       |    if bytestoread <= 0 then
       |       return SOCKET_ERROR --nothing to recv
       |    end if
       |
       |    bcount = 0
       |    bread = 0
       |    temp = {}
       |
       |    buffer = allocate_struct(bytestoread)
       |
       |    if buffer = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    buffer_ptr = buffer
       |
       |    while bcount < bytestoread do
       |      bread=c_func(cRecv, {socket, buffer_ptr, bytestoread-bcount,0})
       |      --?bread
       |      if bread = 0 then --or WSAGetLastError() = WSAEWOULDBLOCK then
       |       -- if  WSAGetLastError() = WSAEWOULDBLOCK then
       |          free(buffer)
       |          return 0
       |		  
       |      elsif bread <= 0 then
       |         free(buffer)
       |          return -1
       |      end if
       |
       |      bcount = bcount + bread
       |      buffer_ptr = buffer_ptr + bread
       |    end while
       |
       |    if buffer_ptr > buffer then  --make sure we have something to pass back
       |        temp = peek({buffer, buffer_ptr-buffer})
       |    else
       |   free(buffer)
       |   return SOCKET_ERROR
       |    end if
       |    free(buffer)
       |    return temp
       |end function
       |
       | atom buffer
     1 |buffer = allocate_struct(4096)
       |
       |global function WsockReadData_1024(integer socket, integer bytestoread)
       |
       |   
       |    integer bcount, bread
       |    sequence buffers
       |	
       |    bcount = 0
       |    bread = 0
       |	buffers={}
       |
       |    
       |	
       |
       |    if buffer = 0 then
       |      return SOCKET_ERROR
       |    end if
       |
       |	
       |--If no error occurs, recv returns the number of bytes received and the buffer pointed to by the buf parameter will 
       |--contain this data received. If the connection has been gracefully closed, the return value is zero.
       |
       |--Otherwise, a value of SOCKET_ERROR is returned, and a specific error code can be retrieved by 
       |--calling WSAGetLastError.
       |	
       |	--If the datagram or message is larger than the buffer specified, the buffer is filled with the first part of the datagram, 
       |	--and recv generates the error WSAEMSGSIZE. For unreliable protocols (for example, UDP) the excess data is lost; for reliable protocols, 
       |	--the data is retained by the service provider until it is successfully read by calling recv with a large enough buffer.
       |
       |      bread=c_func(cRecv, {socket, buffer, bytestoread,0})
       |      
       |	  if bread >0 then
       |	    buffers=peek({buffer, bread})
       |		--free(buffer)
       |		return buffers
       |      elsif bread = 0 then
       |        --free(buffer)
       |        return 0
       |      elsif bread <= 0 then
       |	    if WSAGetLastError() = WSAEMSGSIZE then --the message was to large 
       |		
       |		  buffers&=peek({buffer, bytestoread})
       |          while 1 do
       |		    bread=c_func(cRecv, {socket, buffer, bytestoread,0})
       |			if bread >0 then
       |	          buffers=peek({buffer, bread})
       |		      --free(buffer)
       |		      return buffers
       |            elsif bread = 0 then
       |               --free(buffer)
       |               return 0
       |			elsif bread <= 0 then
       |			   if WSAGetLastError() = WSAEMSGSIZE then
       |			     --contiune 
       |				 buffers&=peek({buffer, bytestoread})
       |			   elsif WSAGetLastError() = WSAEWOULDBLOCK then
       |			      
       |			      --free(buffer)
       |				  return buffers
       |			   end if
       |			else
       |			  puts(1,"unkowneror\n")
       |			end if
       |		  end while
       |		  
       |		elsif WSAGetLastError() =  WSAEWOULDBLOCK then
       |		  --free(buffer)
       |          return 0
       |		else
       |		  puts(1,"Read socket un-handled socket error "&sprint(WSAGetLastError())&"\n")
       |		  return 0
       |		end if
       |      end if
       |
       |end function
       |
       |-------------------------------------------------------------
       |-- WsockSendData
       |--
       |-- Sends Data over a socket. Data must be a 1-D sequence.
       |-- Returns bytes sent or SOCKET_ERROR on fail.
       |-------------------------------------------------------------
       |
       |global function WsockSendData(integer socket, sequence data)
       |    atom buffer, buffer_ptr
       |    integer bcount, bsend, bytestosend
       |
       |    if length(data) = 0 then
       |       return SOCKET_ERROR --nothing to send
       |    end if
       |
       |    bcount = 0
       |    bsend = 0
       |
       |    buffer = allocate_string(data)
       |    if buffer = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    poke(buffer,data)
       |
       |    bytestosend = length(data)
       |
       |    buffer_ptr = buffer
       |
       |    while bcount < bytestosend do
       |	 
       |      bsend=c_func(cSend, {socket, buffer_ptr, bytestosend-bcount,0})
       |
       |      if bsend = 0 then --WSAGetLastError() = WSAEWOULDBLOCK then
       |         --socket was fubared so exit the loop.
       |    
       |         free(buffer)
       |         if bsend = 0 then
       |           return 0
       |         else
       |           return -1
       |         end if
       |      elsif bsend < 0 then --socket was fubared really bad. Bail with Error.
       |        free(buffer)
       |        return SOCKET_ERROR
       |      end if
       |
       |      bcount = bcount + bsend
       |      buffer_ptr = buffer_ptr + bsend
       |    end while
       |
       |    free(buffer)
       |    return bcount
       |end function
       |
       |----------------------------------------------------------------------------
       |-- WSAAsyncSelect()
       |--
       |-- Return 0 on success or SOCKET_ERROR on fail
       |----------------------------------------------------------------------------
       |
       |
       |
       |----------------------------------------------------------------------------
       |-- WSAAsyncGetHostByName()
       |--
       |-- Return 0 on success or SOCKET_ERROR on fail
       |----------------------------------------------------------------------------
       |global function WSAAsyncGetHostByName(atom hwnd, integer Message, sequence name, atom buffer, integer len)
       |    atom name_addr, temp
       |    name_addr = allocate_string(name)
       |    temp = c_func(cWSAAsyncGetHostByName, {hwnd, Message, name_addr, buffer, len})
       |    free(name_addr)
       |    return temp
       |end function
       |
       |----------------------------------------------------------------------------
       |-- WsockConnectAsync()
       |--
       |-- Return 0 on success or SOCKET_ERROR on fail
       |----------------------------------------------------------------------------
       |global function WsockConnectAsync(integer sock, integer port, atom hostpointer)
       |    --to be used with AsyncSockets
       |    atom sa, addr, ippoke
       |    sequence temp,ip
       |
       |    sa = allocate_struct(SIZE_OF_SOCKADDR)
       |    if sa = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |
       |    --set the family
       |    mem_copy(sa, hostpointer+8, 2)
       |
       |    --set the port
       |    store(sa, sin_port, Htons(port))
       |
       |    --Set the address
       |    temp = peek({peek4u(peek4u(hostpointer+12)),4})
       |
       |    ip = {}
       |    for x = 1 to length(temp) do
       |        ip=ip & sprintf("%d",temp[x]) & "."
       |    end for
       |    ip = ip[1..length(ip)-1]
       |
       |    ippoke = allocate_string(ip)
       |    addr = c_func(cInet_addr,{ippoke})
       |
       |    if addr = 0 then
       |        free(ippoke)
       |        free(sa)
       |        return SOCKET_ERROR
       |    end if
       |
       |    free(ippoke)
       |
       |    store(sa, sin_addr, addr)
       |
       |    if c_func(cConnect, {sock, sa, SIZE_OF_SOCKADDR}) = SOCKET_ERROR then
       |        if WSAGetLastError() != WSAEWOULDBLOCK then
       |      c_proc(cCloseSocket,{sock})
       |      free(sa)
       |      return SOCKET_ERROR
       |        end if
       |    end if
       |    free(sa)
       |    return 1
       |end function
       |
       |--End Mod
       |
       |global function WsockGetSockName(integer sock)
       |
       |    atom sa, ippoint, len , rtn
       |    sequence ip
       |
       |    sa = allocate_struct(SIZE_OF_SOCKADDR)
       |    if sa = 0 then
       |       return {}
       |    end if
       |    len = allocate(4)
       |    if len = 0 then
       |       free(sa)
       |       return {}
       |    end if
       |
       |    ippoint = allocate(4)
       |    if ippoint = 0 then
       |        free(len)
       |        free(sa)
       |        return {}
       |    end if
       |
       |    store(sa, sin_addr, ippoint)
       |
       |    poke4(len, SIZE_OF_SOCKADDR)
       |
       |    rtn = c_func(cGetpeername, {sock, sa, len})
       |
       |    if rtn !=0 then
       |       free(sa)
       |       free(len)
       |       free(ippoint)
       |       return {}
       |    end if
       |
       |   rtn = c_func(cInet_ntoa,{peek4u(sa+4)})
       |
       |    if rtn = NULL then
       |       return {}
       |    end if
       |
       |    ip =  peek_string(rtn)
       |
       |    free(sa)
       |    free(len)
       |    free(ippoint)
       |    free(rtn)
       |
       |    return ip
       |end function
       |
       |global function WsockListenAsync(integer portnum, atom hwnd, atom Msg,atom events)
       |
       |    --to be used with Async Sockets
       |    integer sock, family, port, errorRtn
       |    atom sa
       |
       |    sa = allocate_struct(SIZE_OF_SOCKADDR)
       |
       |    if sa = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    --Set the family
       |    store(sa, sin_family, AF_INET)
       |
       |    --set the portnum
       |    store(sa, sin_port, Htons(portnum))
       |
       |    --get the family
       |    family = fetch(sa, sin_family)
       |
       |    sock = c_func(cSocket,{family,SOCK_STREAM,6})
       |    if sock = SOCKET_ERROR then
       |        free(sa)
       |        return SOCKET_ERROR
       |    end if
       |
       |    errorRtn = WSAAsyncSelect(sock, hwnd, Msg, events)
       |
       |    if c_func(cBind, {sock, sa, SIZE_OF_SOCKADDR}) = SOCKET_ERROR then
       |        c_proc(cCloseSocket,{sock})
       |        free(sa)
       |        return SOCKET_ERROR
       |    end if
       |    free(sa)
       |    c_proc(cListen, {sock,3})
       |    return sock
       |end function
       |
       |
       |global function WsockShutdown(integer socket, integer how)
       |    return c_func(cShutdown, {socket, how})
       |end function
       |
       |global function IsIP(sequence data)
       |atom HostId
       |atom temp
       |
       |    HostId = allocate_string(data)
       |    if HostId = 0 then
       |        return SOCKET_ERROR
       |    else
       |        temp = c_func(cInet_addr, {HostId})
       |    end if
       |    free(HostId)
       |    if temp = INADDR_NONE then
       |        return 0
       |    else
       |        return 1
       |    end if
       |end function
       |
       |global function WSAAsyncGetHostByAddress(atom hwnd, integer Message, sequence ip,
       |           atom buffer, integer len)
       |    atom ip_addr, temp, InetAddress, tmp
       |    integer nbol
       |
       |    ip_addr = allocate_string(ip)
       |    if ip_addr = 0 then
       |        return SOCKET_ERROR
       |    end if
       |
       |    tmp = c_func(cInet_addr, {ip_addr})
       |
       |    if tmp = INADDR_NONE then
       |        free(ip_addr)
       |        return SOCKET_ERROR
       |    end if
       |
       |    free(ip_addr)
       |
       |    InetAddress = allocate(SIZE_OF_INADDR)
       |    if InetAddress = 0 then
       |       return SOCKET_ERROR
       |    end if
       |
       |    poke4(InetAddress, tmp)
       |    temp = c_func(cWSAAsyncGetHostByAddr, {hwnd, Message, InetAddress, 4, AF_INET, buffer, len})
       |    free(InetAddress)
       |    return temp
       |end function
       |
       |global function WSACancelAsyncRequest(atom hndle)
       |        return c_func(cWSACancelAsyncRequest, {hndle})
       |end function
       |
       |include client.ew
       |include input_stream.ew
       |
       |include machine.e
       |
       |sequence class_list,class_freelist
     1 |class_list={}
     1 |class_freelist={}
       |constant input_buffer = 1
       |
       |global function input_stream_new()
       |  integer handle
       |  if length(class_freelist)>0 then
       |    handle= class_freelist[1]
       |    class_freelist = class_freelist[2..length(class_freelist)]
       |  else
       |    class_list= append(class_list,{""})
       |    handle=length(class_list)
       |  end if
       |
       |  return handle
       |end function
       |
       |global procedure input_stream_delete(integer handle)
       |  class_list[handle]={}
       |  class_freelist =append(class_freelist, handle)
       |end procedure
       |
       |global function input_stream_peek(integer handle, integer pos)
       |  return class_list[handle][input_buffer][pos]
       |end function 
       |
       |global function input_stream_length(integer handle)
       |  return length(class_list[handle][input_buffer])
       |end function 
       |
       |global procedure input_stream_append(integer handle,sequence data)
       |  class_list[handle][input_buffer]&=data
       |end procedure
       |
       |global function input_stream_slice(integer handle, integer pos1, integer pos2)
       |  return class_list[handle][input_buffer][pos1..pos2]
       |end function 
       |
       |global procedure input_stream_set(integer handle,sequence data)
       |  class_list[handle][input_buffer]=data
       |end procedure
       |
       |global function input_stream_get(integer handle)
       |  return class_list[handle][input_buffer]
       |end function 
       |
       |
       |global function input_stream_readutf(integer handle)
       |  integer len
       |  sequence temp
       |  len=bytes_to_int( {class_list[handle][input_buffer][2],class_list[handle][input_buffer][1],0,0} )+2
       |  temp=class_list[handle][input_buffer][3..len]
       |  class_list[handle][input_buffer]=class_list[handle][input_buffer][len+1..length(class_list[handle][input_buffer])]
       |  return temp
       |end function
       |
       |global function input_stream_readint(integer handle)
       |  atom v
       |  v=bytes_to_int( {class_list[handle][input_buffer][4],class_list[handle][input_buffer][3],class_list[handle][input_buffer][2],class_list[handle][input_buffer][1]} )
       |  if v>2147483648 then
       |    v=v-4294967296
       |  end if
       |  class_list[handle][input_buffer]=class_list[handle][input_buffer][5..length(class_list[handle][input_buffer])]
       |  return v
       |end function
       |
       |global function input_stream_readfloat(integer handle)
       |  atom v
       |  v=float32_to_atom( {class_list[handle][input_buffer][4],class_list[handle][input_buffer][3],class_list[handle][input_buffer][2],class_list[handle][input_buffer][1]} )
       |  class_list[handle][input_buffer]=class_list[handle][input_buffer][5..length(class_list[handle][input_buffer])]
       |  return v
       |end function
       |
       |global function input_stream_readshort(integer handle)
       |atom v
       |  v=bytes_to_int( {class_list[handle][input_buffer][2],class_list[handle][input_buffer][1],0,0} )
       |  class_list[handle][input_buffer]=class_list[handle][input_buffer][3..length(class_list[handle][input_buffer])]
       |  return v
       |end function
       |
       |global function input_stream_readfully(integer handle,integer len)
       |  if len=0 then
       |    return class_list[handle][input_buffer]
       |  end if
       |  return class_list[handle][input_buffer][1..len]
       |end function
       |
       |global function input_stream_readbyte(integer handle)
       |  integer temp
       |
       |  temp=class_list[handle][input_buffer][1]
       |  class_list[handle][input_buffer]=class_list[handle][input_buffer][2..length(class_list[handle][input_buffer])]
       |  return temp
       |end function
       |
       |global function input_stream_readbool(integer handle)
       |  integer temp
       |
       |  temp=class_list[handle][input_buffer][1]
       |  class_list[handle][input_buffer]=class_list[handle][input_buffer][2..length(class_list[handle][input_buffer])]
       |  return and_bits(temp,#1)
       |end function
       |
       |include rc4.ew
       |include machine.e
       |
       |
       |
       |sequence class_list,class_freelist
     1 |class_list={}
     1 |class_freelist={}
       |constant rc4_arg1 = 1
       |
       |
       |global function rc4_new()
       |  atom state_address,a_address,b_address,data_address,key_address,max_block_size,arcf_init,key_length_address,arcfour_enc,max_data_address
       |
       |  integer handle
       |
       |  if length(class_freelist)>0 then
       |    handle= class_freelist[1]
       |    class_freelist = class_freelist[2..length(class_freelist)]
       |  else
       |    class_list= append(class_list,{})
       |    handle=length(class_list)
       |  end if
       |
       |  state_address=allocate(256)
       |  a_address=allocate(2)
       |  b_address=a_address+1
       |  max_block_size=1024
       |  data_address=allocate(max_block_size)
       |  key_address = allocate(256)
       |
       |  arcf_init = allocate(88)
       |  poke( arcf_init, and_bits(#FF,
       |  "ÅÈÆÇÌË¦5¦G.uuuuþ@ýx¸s5±uêl¦P3uuuu¦tÿ‰}w‘¬uHÿ©€ý‰€ý©}¼ötuuuuçw¦tµ²"-117&
       |  "üýüünØžüüüüžüüüüZ[VUWT¿"+4))
       |  poke4(arcf_init + 11, state_address)
       |  poke4(arcf_init + 29, key_address)
       |  poke4(arcf_init + 72, a_address)
       |  poke4(arcf_init + 77, b_address)
       |  key_length_address = arcf_init + 55
       |
       |
       |  arcfour_enc = allocate(93)
       |  poke(arcfour_enc, and_bits(#FF,"øûùúÿþÙhÙzH¨¨¨¨2Í¨¨¨¨a¨¨¨¨f¨¨¨¨¦hÙz0j1©w2Ç¨„0Š©r2â0Â0çÙz0‚¨¢2¼²Ø¾"+88&"E€ýÿÿÿÿqÓ¡ÿÿÿÿ‡$ÿÿÿÿ]^YXZWÂ"+1))
       |  poke4(arcfour_enc + 11, a_address)
       |  poke4(arcfour_enc + 17, b_address)
       |  poke4(arcfour_enc + 22, state_address)
       |  poke4(arcfour_enc + 27, data_address)
       |  poke4(arcfour_enc + 76, a_address)
       |  poke4(arcfour_enc + 82, b_address)
       |
       |  max_data_address = arcfour_enc + 69
       |
       |  class_list[handle]={state_address,
       |                      a_address,
       |                      b_address,
       |                      max_block_size,
       |                      data_address,
       |                      key_address,
       |                      arcf_init,
       |                      key_length_address,
       |                      arcfour_enc,
       |                      max_data_address,
       |                      {} --11
       |                      }
       |
       |  return handle
       |end function
       |
       |
       |global procedure rc4_delete(integer handle)
       |  free(class_list[handle][1])
       |  free(class_list[handle][2])
       |  free(class_list[handle][5])
       |  free(class_list[handle][6])
       |  free(class_list[handle][7])
       |  free(class_list[handle][9])
       |  class_list[handle]={}
       |  class_freelist =append(class_freelist, handle)
       |
       |end procedure
       |
       |
       |
       |
       |
       |-- Read, write and clean state
       |function get_state(integer handle)
       |    return {peek(class_list[handle][2]), peek(class_list[handle][3]), peek({class_list[handle][1], 256})}
       |end function
       |
       |procedure put_state(integer handle,sequence state)
       |    poke(class_list[handle][2], state[1])
       |    poke(class_list[handle][3], state[2])
       |    poke(class_list[handle][1], state[3])
       |end procedure
       |
       |procedure clean_state(integer handle)
       |    poke(class_list[handle][2], 0)
       |    poke(class_list[handle][3], 0)
       |    mem_set(class_list[handle][1], 0, 256)
       |end procedure
       |
       |-- Generate state based on key
       |procedure arcfour_init(integer handle,sequence key)
       |    -- Write key length
       |    poke4(class_list[handle][8], length(key))
       |    -- Write key
       |    poke(class_list[handle][6], key)
       |    -- Call initialization routine
       |    call(class_list[handle][7])
       |end procedure
       |
       |
       |
       |function arcfour_encryption(integer handle,sequence data)
       |
       |    -- Store maximum block length
       |    poke4(class_list[handle][10], class_list[handle][5]+class_list[handle][4])
       |
       |    for t=1 to length(data) by class_list[handle][4] do
       |	-- Proccess one block at a time
       |	if t+class_list[handle][4]<=length(data) then   -- Not last block yet
       |
       |	    -- Write data to memory
       |	    poke(class_list[handle][5],data[t..t+class_list[handle][4]-1])
       |	    -- Call encryption/decryption routine
       |	    call(class_list[handle][9])
       |	    -- Store data in sequence
       |	    data[t..t+class_list[handle][4]-1]=peek({class_list[handle][5],class_list[handle][4]})
       |
       |	else                                -- Last block
       |
       |	    -- Write data length
       |	    poke4(class_list[handle][10], class_list[handle][5]+length(data)-t+1)
       |	    -- Write data to memory
       |	    poke(class_list[handle][5],data[t..length(data)])
       |	    -- Call encryption/decryption routine
       |	    call(class_list[handle][9])
       |	    -- Store data in sequence
       |	    data[t..length(data)]=peek({class_list[handle][5],length(data)-t+1})
       |
       |	end if
       |
       |    end for
       |
       |    -- Erase data from memory
       |    mem_set (class_list[handle][5], 0, class_list[handle][4])
       |    return data
       |end function
       |
       |
       |-- Stream routines
       |
       |global procedure rc4_arcfour_init_encrypt(integer handle,sequence key)
       |    arcfour_init(handle,key)
       |    class_list[handle][11] = get_state(handle)
       |    clean_state(handle)
       |end procedure
       |
       |global function rc4_arcfour_encrypt_block(integer handle,sequence data)
       |    put_state(handle, class_list[handle][11])
       |    data = arcfour_encryption (handle,data)
       |    class_list[handle][11] = get_state(handle)
       |    clean_state(handle)
       |    return data
       |end function
       |
       |global function arcfour_decrypt_block(integer handle,sequence data)
       |    return rc4_arcfour_encrypt_block(handle,data)
       |end function
       |
       |-- Simple routines
       |global function arcfour_encrypt(integer handle,sequence data, sequence key)
       |    arcfour_init(handle,key)
       |    data = arcfour_encryption (handle,data)
       |    clean_state(handle)
       |    return data
       |end function
       |
       |global function arcfour_decrypt(integer handle,sequence data, sequence key)
       |    return arcfour_encrypt(handle,data, key)
       |end function
       |
       |
       |sequence key1,key2
     1 |key1={114,197,88,60,175,182,129,137,149,203,215,75,128}
     1 |key2={49,31,128,105,20,81,199,27,9,161,58,42,110}
       |
       |
       |
       |global sequence client_list,client_freelist
     1 |client_list={}
     1 |client_freelist={}
       |global constant client_email = 1
       |global constant client_pass = 2
       |global constant client_serverip = 3
       |global constant client_rc4_1 = 4
       |global constant client_rc4_2 = 5
       |global constant client_inputstream = 6
       |global constant client_socket = 7
       |global constant client_data = 8
       |global constant client_packet_len = 9
       |global constant client_object_id = 10
       |global constant client_account_id = 11
       |global constant client_last_move_time =12
       |global constant client_player_class_handle =13
       |
       |
       |global function client_new(sequence email, sequence pass, sequence serverip, integer sock, integer id, integer account_id )
       |  integer handle
       |  integer rc4_1,rc4_2
       |  if length(client_freelist)>0 then
       |    handle= client_freelist[1]
       |    client_freelist = client_freelist[2..length(client_freelist)]
       |  else
       |    client_list= append(client_list,{0})
       |    handle=length(client_list)
       |  end if
       |  
       |  
       |  rc4_1=rc4_new()
       |  rc4_2=rc4_new()
       |  rc4_arcfour_init_encrypt(rc4_1,key1)
       |  rc4_arcfour_init_encrypt(rc4_2,key2)
       |
       |  client_list[handle]={email,pass,serverip, rc4_1, rc4_2 ,input_stream_new(), sock, id, 0 ,0,account_id,0,0}
       |
       |  return handle
       |end function
       |
       |global procedure client_set_packet_len(integer handle, integer v)
       |  client_list[handle][client_packet_len]=v
       |end procedure
       |
       |
       |global procedure client_delete(integer handle)
       |  client_list[handle]={}
       |  client_freelist =append(client_freelist, handle)
       |end procedure
       |
       |include math.ew
       |global function point_distance(atom x1,atom y1 , atom x2, atom y2)
       |    atom x, y
       |    --x = power(floor(x1) - floor(x2), 2)
       |    --y = power(floor(y1) - floor(y2), 2)
       |
       |    x = power(x1 - x2, 2)
       |    y = power(y1 - y2, 2)
       |
       |    return sqrt(x + y)
       |end function
       |
       |constant HALFPI    = PI/2
       |
       |global function atan2(atom y, atom x)
       |	
       |  if x > 0 then
       |		
       |    return arctan(y/x)
       |	
       |  elsif x < 0 then
       |		
       |    if y < 0 then
       |			
       |      return arctan(y/x) - PI
       |		
       |    else
       |			
       |      return arctan(y/x) + PI
       |		
       |    end if
       |	
       |  elsif y > 0 then
       |		
       |    return HALFPI
       |	
       |  elsif y < 0 then
       |		
       |    return -(HALFPI)
       |	
       |  else
       |		
       |    return 0
       |	
       |  end if
       |
       |end function
       |
       |object junk
     1 |junk = {{},{}}
     1 |for j = 360 to 0 by -1 do
   361 |    junk[1] = append(junk[1], sin(j*PI/180) )
   361 |    junk[2] = append(junk[2], cos(j*PI/180) )
   361 |end for
       |constant sin_loTRUE2up = junk[1], cos_loTRUE2up = junk[2]
       |
       |
       |global function get_angle_to(atom x, atom y, atom x2, atom y2)
       |  return (180- atan2(x2 - x ,y2 - y) *180/PI)
       |
       |end function
       |
       |global function degtorad(atom angle)
       |	  return (angle * (PI/180))
       |end function
       |
       |include win32extra.ew
       |
       |constant xGetTickCount = registerw32Function(kernel32, "GetTickCount", {}, C_LONG)
       |constant xSleep = registerw32Procedure(kernel32, "Sleep", {C_LONG})
       |
       |global procedure usleep(integer v)
       |	w32Proc(xSleep,{v})
       |end procedure
       |
       |global function get_tick_count()
     1 |  return  w32Func(xGetTickCount,{})
       |end function
       |
       |global atom start_time
     1 |start_time=get_tick_count()
       |
       |global function current_time()
       |  return  w32Func(xGetTickCount,{})-start_time
       |end function
       |
       |procedure centerwindow(integer win)
       |integer width,height,window_width,window_height
       |sequence size
       |    size=getCtlSize(win)
       |    window_width=size[1]
       |    window_height=size[2]
       |    width=w32Func(xGetSystemMetrics,{SM_CXSCREEN})
       |    height=w32Func(xGetSystemMetrics,{SM_CYSCREEN})
       |    setRect( win,floor((width/2))-floor((window_width/2)) ,floor((height/2))-floor((window_height/2))-32, window_width, window_height, 0 )
       |end procedure
       |
       |
       |constant window_titlebar_height = getSystemMetrics ( SM_CYCAPTION )
       |constant window_menu_height = getSystemMetrics ( SM_CYMENU )
       |constant window_hscrollbar_width = getSystemMetrics ( SM_CXVSCROLL )
       |constant window_vscrollbar_height = getSystemMetrics ( SM_CYVSCROLL )
       |constant window_border_width = getSystemMetrics ( SM_CXFRAME )
       |constant window_border_height = getSystemMetrics ( SM_CYFRAME )
       |constant window_toolbar_height = 33
       |
       |constant window_all_height=window_titlebar_height+window_menu_height+window_toolbar_height+(getSystemMetrics ( SM_CYFRAME )*2)
       |
       |
       |constant crypt32 = registerw32Library("crypto.dll")
       |constant xrsa_public_key_encyrp= registerw32Function(crypt32, "rsa_public_key_encyrp", {C_POINTER}, C_POINTER)
       |
       |
       |global function rsa_public(sequence data)
       |  atom message,result
       |  integer inc,char
       |  sequence text
       |  message=allocate_string(data)
       |  result=w32Func(xrsa_public_key_encyrp,{message})
       |  inc=0
       |
       |  text=""
       |  while 1 do
       |  	char=peek(result+inc)
       |  	
       |  	if char=0 then
       |  		exit
       |  	end if
       |  	if char!=10 then
       |  	  text&=char
       |  	
       |  	end if
       |  	inc+=1
       |  end while
       |
       |  free(message)
       |  return text
       |end function
       |
       |include stream_write.ew
       |-----------------------------write functions 00------------------------------------
       |
       |global function writeutf(sequence data, sequence v)
       |  sequence s
       |   s=int_to_bytes(length(v))
       |   data&=s[2]&s[1]&v
       |   return data
       |end function
       |
       |global function writeint(sequence data ,atom v)
       |sequence s
       |   s=int_to_bytes(v)
       |   data&=s[4]&s[3]&s[2]&s[1]
       |   return data
       |end function
       |
       |global function writefloat(sequence data ,atom v)
       |sequence s
       |   s = atom_to_float32(v)
       |   data&=s[4]&s[3]&s[2]&s[1]
       |   return data
       |end function
       |
       |global function writebool(sequence data, integer b)
       |   data&=b
       |   return data
       |end function
       |
       |global function writeshort(sequence data ,atom v)
       |sequence s
       |   s=int_to_bytes(v)
       |   data&=s[2]&s[1]
       |   return data
       |end function
       |
       |global function writebyte(sequence data ,integer v)
       |   data&=v
       |   return data
       |end function
       |
       |
       |
       |global procedure socket_send_data(integer socket,sequence data)
       |  integer len
       |  len=WsockSendData(socket,data)
       |  if len!=length(data) then
       |  	puts(1,"sending data error\n")
       |  end if
       |end procedure
       |
       |
       |
       |--each socket is assinged a new instance of autolootbot_list
       |sequence sockets
     1 |sockets=repeat(0,65536) --this is used to index into the autolootbot_list
       |
       |
       |
       |--handling the items and quick indexing code
       |sequence white_list
     1 |white_list={}
       |
       |procedure load_items()
       |  integer fn
       |  object line
       |  sequence buffer
     1 |  fn=open("items.txt","r")
     1 |  buffer={}
     1 |  while 1 do
    87 |  	line=gets(fn)
    87 |  	if integer(line) then
     1 |  	  exit	
       |  	end if
    86 |  	buffer=append(buffer,line[1..length(line)-1])
    86 |  end while	
     1 |  white_list=buffer
     1 |end procedure
       |
     1 |load_items()
       |
       |sequence item_index
     1 |item_index=repeat({0,0,""},60000)
       |
       |procedure init_items()
       |integer found
     1 |for i=1 to length(item_ids) do
   627 |  item_index[item_ids[i][1]][1]=item_ids[i][1]
   627 |  item_index[item_ids[i][1]][3]=item_ids[i][2]
   627 |  found=0
   627 |  for j=1 to length(white_list) do
 50267 |  	if equal(white_list[j],item_ids[i][2])=1 then
    85 |  	  found=1
    85 |	  exit
       |  	end if
 50182 |  end for
   627 |  if found=0 then
   542 |  	addItem(List_items,item_ids[i][2])
       |  else
    85 |    addItem(List_white_items,item_ids[i][2])
       |  end if
   627 |end for
       |
     1 |setIndex(List_items,1)	
     1 |end procedure
     1 |init_items()
       |
       |
       |procedure mark_white_item()
       |sequence text
       |
     1 |  for j=1 to length(item_ids) do
   627 |	 item_index[item_ids[j][1]][2]=0
   627 |  end for
       |
     1 |  for i=1 to getCount( List_white_items ) do
    85 |  	text = getItem( List_white_items, i )
    85 |  	for j=1 to length(item_ids) do
 33089 |	  if equal(item_index[item_ids[j][1]][3],text)=1 then
    85 |	    item_index[item_ids[j][1]][2]=1
    85 |	    exit 	
       |	  end if
 33004 |    end for
    85 |  end for
       |
     1 |end procedure
       |
     1 |mark_white_item()
       |--gui item mangment
       |
       |
       |
       |procedure connect_to_server()
       |	  integer iwork, port
       |	  atom Server_sock
       |  sequence swork,ip
       |
       |  port = 2050
       |
       |  iwork = WsockInit()
       |  if iwork = -1 then -- WinSock failed
       |    iwork = message_box("WSockInit() failed!","Error",MB_TASKMODAL + MB_ICONSTOP + MB_OK)
       |    abort(99)
       |  end if
       |
       |
       |  hWndMainWindow = getHandle(Window1)
       |
       |
       |  --Server_sock=Wsock_new("50.18.113.133", 2050 , hWndMainWindow, SM_ASYNC,or_all({FD_READ,FD_CLOSE,FD_CONNECT}))  --us west
       |  --Server_sock=Wsock_new("176.34.240.11", 2050 , hWndMainWindow, SM_ASYNC,or_all({FD_READ,FD_CLOSE,FD_CONNECT})) --eu north
       |  Server_sock=Wsock_new(server_list[getIndex(combox_serverlist)][2], 2050 , hWndMainWindow, SM_ASYNC,or_all({FD_READ,FD_CLOSE,FD_CONNECT}))  --us west
       |
       |end procedure
       |
       |
       |
       |
       |--connect_to_server()
       |--connect_to_server()
       |
       |--connect_to_server()
       |--connect_to_server()
       |
       |--connect_to_server()
       |--connect_to_server()
       |
       |
       |
       |--setTimer(Window1,1001,1000*1) --this was used for rendering data
       |
     1 |setTimer(Window1,1002,1000*1) --this is used for fixing the issue with fd_read being empty polling it is. also using this for a cool down timer
       |
       |
       |sequence my_stats
       |constant stats_size=100
       |
     1 |my_stats=repeat({},stats_size)
       |
       |--hello packet
       |global integer game_id,key_size
       |global atom key_time
       |global sequence key
     1 |key_size=0
     1 |game_id=-2
     1 |key_time=-1
     1 |key={}
       |--end hello packet
       |
       |--mapinfo packet
       |global integer map_width,map_height
       |global sequence map_name
       |--end mapinfo packet
       |
       |--sequence object_id_to_player_class
       |--object_id_to_player_class=repeat(0,4000000) --4 million objects
       |
       |--required for packets
       |include packets.ew
       |global constant fail_packet=0
       |global constant useportal_packet=3--USEPORTAL = 3;
       |global constant invresult_packet=4--INVRESULT = 4
       |global constant ping_packet=6
       |global constant move_packet=7 --MOVE = 7;
       |global constant global_notification_packet=9
       |global constant updateatt_packet=11--UPDATEATT = 11;
       |global constant tradedone_packet=12--TRADEDONE:int = 12;
       |global constant shoot_packet=13
       |global constant gotoack_packet=14--GOTOACK = 14;
       |global constant pong_packet=16
       |global constant hello_packet=17
       |global constant requesttrade_packet=21--REQUESTTRADE = 21;
       |global constant tradechanged_packet=23--TRADECHANGED = 23;
       |global constant text_packet=25 --TEXT
       |global constant update_packet=26
       |global constant create_suc_packet=31
       |global constant create_packet=36
       |global constant reconnect_packet=39--RECONNECT = 39;
       |global constant play_sound_packet=44
       |global constant load_packet=45
       |global constant accountlist_packet=46
       |global constant goto_packet=52
       |global constant show_effect_packet=56
       |global constant mapinfo_packet=60
       |global constant traderequest_packet=61 --TRADEREQUESTED = 61;
       |global constant new_tick_packet=62-- NEW_TICK = 62
       |global constant notification_packet=63 --NOTIFICATION
       |global constant tradestart_packet=67--TRADESTART = 67;
       |global constant allyshoot_packet=74 --ALLYSHOOT
       |global constant clientstat_packet=75--CLIENTSTAT = 75;
       |global constant invitedtoguild_packet=77--INVITEDTOGUILD = 77;
       |
       |
       |
       |global sequence packet_names,packet_read_id
     1 |packet_names=repeat("",100)
     1 |packet_read_id=repeat(-1,100)
       |
     1 |packet_names[ fail_packet+1 ]= "failed"
     1 |packet_names[ useportal_packet+1 ]= "useportal"
     1 |packet_names[ invresult_packet+1 ] ="invresult"
     1 |packet_names[ ping_packet+1 ]= "ping"
     1 |packet_names[ global_notification_packet+1 ]= "global notifcaion"
     1 |packet_names[ tradedone_packet+1 ]= "tradedone"
     1 |packet_names[ shoot_packet+1 ]= "shoot"
     1 |packet_names[ hello_packet+1 ]= "hello"
     1 |packet_names[ requesttrade_packet+1 ]= "requesttrade"
     1 |packet_names[ tradechanged_packet+1 ]= "tradechanged"
     1 |packet_names[ text_packet+1 ]= "text"
     1 |packet_names[ update_packet+1 ]= "update"
     1 |packet_names[ create_suc_packet+1 ]= "create sucs"
     1 |packet_names[ create_packet+1 ]= "create packet"
     1 |packet_names[ reconnect_packet+1 ]= "reconnect"
     1 |packet_names[ play_sound_packet+1 ]= "play sound"
     1 |packet_names[ load_packet+1 ]= "load packet"
     1 |packet_names[ accountlist_packet+1 ]= "accountlist"
     1 |packet_names[ goto_packet+1 ]= "goto packet"
     1 |packet_names[ show_effect_packet+1 ]= "show effect"
     1 |packet_names[ mapinfo_packet+1 ]= "mapinfo"
     1 |packet_names[ traderequest_packet+1 ]= "traderequest"
     1 |packet_names[ new_tick_packet+1 ]= "new tick"
     1 |packet_names[ notification_packet+1 ]= "notification"
     1 |packet_names[ tradestart_packet+1 ]= "tradestart"
       |--packet_names[ playertext_packet+1 ]= "playertext"
     1 |packet_names[ allyshoot_packet+1 ]= "allyshoot"
     1 |packet_names[ clientstat_packet+1 ]= "clientstat"
     1 |packet_names[ invitedtoguild_packet+1 ]= "invitedtoguild"
       |
       |include input_stream.ew
       |include mapinfo_packet.ew --includes around 10 addional packets
       |include load_packet.ew
       |global function load_packet_write(integer client,integer id)
       |  sequence data,temp
       |  data={}
       |
       |  data=writeint(data,id)
       |  data=writebyte(data,0)
       |
       |  temp=reverse(int_to_bytes(length(data)+5)) &load_packet
       |
       |  data=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],data)
       |  return temp & data
       |end function
       |
       |
       |global function create_packet_write(integer client)
       |  sequence data,temp
       |  data={}
       |
       |  data=writeshort(data,782)
       |  data=writeshort(data,0)
       |
       |  temp=reverse(int_to_bytes(length(data)+5)) &create_packet
       |
       |  data=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],data)
       |
       |  return temp & data
       |end function
       |
       |
       |procedure mapinfo_packet_read(integer client,integer inputstream)
       | object temp
       |  sequence data
       |  integer count
       |  count=0
       |	map_width=input_stream_readint(inputstream)
       |	count+=4
       |	map_height=input_stream_readint(inputstream)
       |	count+=4
       |	map_name=input_stream_readutf(inputstream)
       |	count+=length(map_name)+2
       |	temp=input_stream_readint(inputstream)
       |	count+=4
       |	temp=input_stream_readint(inputstream)
       |	count+=4
       |	temp=input_stream_readbool(inputstream)
       |	count+=1
       |	temp=input_stream_readbool(inputstream)
       |	count+=1
       |	
       |    --debug(input_stream_slice(inputstream,1, (packet_length-5)-count )&"\n")
       |    --need to slice the correct amount from the map info pack
       |    
       |   input_stream_set(inputstream, input_stream_slice(inputstream, ((client_list[client][client_packet_len]-5)-count)+1, input_stream_length(inputstream) ) )
       |
       |
       |  
       |end procedure
     1 |packet_read_id[mapinfo_packet+1]=routine_id("mapinfo_packet_read")
       |
       |procedure global_notification_read(integer client,integer inputstream)
       |   object res
       |   --puts(1,"global_notification \n")
       |   res=input_stream_readint(inputstream)
       |   res=input_stream_readutf(inputstream)
       |end procedure
     1 |packet_read_id[global_notification_packet+1]=routine_id("global_notification_read")
       |
       |procedure accountlist_read(integer client,integer inputstream)
       |  object res
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readshort(inputstream)
       |  for i=1 to res do
       |    res=input_stream_readint(inputstream)
       |  end for
       |end procedure
     1 |packet_read_id[accountlist_packet+1]=routine_id("accountlist_read")
       |
       |procedure show_effect_read(integer client,integer inputstream)
       |  object res
       |  res=input_stream_readbyte(inputstream)
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readfloat(inputstream)
       |  res=input_stream_readfloat(inputstream)
       |  res=input_stream_readfloat(inputstream)
       |  res=input_stream_readfloat(inputstream)
       |  --res=location_new_from_input(inputstream)
       |  --location_delete(res)
       |  --res=location_new_from_input(inputstream)
       |  --location_delete(res)
       |  res=input_stream_readint(inputstream)
       |end procedure
     1 |packet_read_id[show_effect_packet+1]=routine_id("show_effect_read")
       |
       |procedure allyshoot_read(integer client,integer inputstream)
       |  object res
       |  res=input_stream_readbyte(inputstream)
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readshort(inputstream)
       |  res=input_stream_readint(inputstream)
       |end procedure
     1 |packet_read_id[allyshoot_packet+1]=routine_id("allyshoot_read")
       |
       |procedure notification_read(integer client,integer inputstream)
       |  object res
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readutf(inputstream)
       |  res=input_stream_readint(inputstream)
       |end procedure
       |
     1 |packet_read_id[notification_packet+1]=routine_id("notification_read")
       |
       |
       |
       |
       |procedure ping_packet_read(integer client,integer inputstream)
       |  object res
       |  sequence write,temp
       |  res=input_stream_readint(inputstream)
       |
       |  write=""
       |  write=writeint(write,res) --serial
       |  write=writeint(write,current_time()) --time
       |
       |  --PONG = 16;
       |  temp=reverse(int_to_bytes(length(write)+5)) &pong_packet
       |  write=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],write)
       |  socket_send_data(client_list[client][client_socket],temp&write)
       |end procedure
       |
     1 |packet_read_id[ping_packet+1]=routine_id("ping_packet_read")
       |
       |
       |
       |
       |procedure shoot_packet_read(integer client,integer inputstream)
       |  object res
       |  res=input_stream_readbyte(inputstream)
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readint(inputstream)
       |
       |  res=input_stream_readfloat(inputstream)
       |  res=input_stream_readfloat(inputstream)
       |
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readshort(inputstream)
       |end procedure
       |
     1 |packet_read_id[shoot_packet+1]=routine_id("shoot_packet_read")
       |
       |procedure play_sound_packet_read(integer client,integer inputstream)
       |  object res
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readbyte(inputstream)
       |end procedure
       |
     1 |packet_read_id[play_sound_packet+1]=routine_id("play_sound_packet_read")
       |
       |
       |procedure traderequest_packet_read(integer client,integer inputstream)
       |  object res
       |  sequence data,temp
       |  data={}
       |  res=input_stream_readutf(inputstream)
       |end procedure
       |
     1 |packet_read_id[traderequest_packet+1]=routine_id("traderequest_packet_read")
       |
       |procedure invitedtoguild_packet_read(integer client,integer inputstream)
       |  object res
       |  res=input_stream_readutf(inputstream)	
       |  res=input_stream_readutf(inputstream)	
       |end procedure
       |
     1 |packet_read_id[invitedtoguild_packet+1]=routine_id("invitedtoguild_packet_read")
       |
       |
       |
       |include hello_packet.ew
       |sequence guild_len
     1 |guild_len="DD07BF9C5B705619407D6130A5B289EA856859A8"
       |
       |global function create_random_guild()
       |sequence temp,char_set
       |   char_set={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
       |   temp={}
       |   for i=1 to length(guild_len) do
       |   	 temp&=char_set[rand(length(char_set))]
       |   end for	
       |   return temp
       |end function
       |
       |
       |global function hello_packet_write(integer client,sequence email, sequence pass)
       |  sequence data,temp
       |  data={}
       |  --puts(1,"hello_packet\n")
       |  data=writeutf(data,"15.0") --build version
       |  --?game_id
       |  data=writeint(data,game_id) --game id
       |  --data=writeutf(data,"XRU8xQGLzCLaQR2BMOVLE9aPLggIPbNcig/rA1Wyi+KnlfIO02VXKpDEMO7hjscFXccRGOnTHpKoLkbuo2OXrU0wGWzJLsNGSf007Ga71Eu6VCZ61dNIzm71qKl9B5z7ERceI/JFk9NQ7RvmdQpK1s+bB9qAsVWGwhlECBA4EU0=")--create_guest_guid_java())--"PAP6RSeDHDRLpNVO4dw7oMsZS/6gIdnSFj9LHjI/YL8Al61XUPAxMtx5d/fYzmdwbgdRed6X1pHcVKUX16q59wvlzVouQZeim0P8HwXxbuMWwS+Bf9YFUANoriQzjMV/PlNAc17GfxkVQAn2LNYSV3m+BfEAwE6/WUNtyIYZJWI=") --guid
       |  --data=writeutf(data,"Z+TWxbDpdKsNAKn358XZHOTI4nZEI4/oCrOB7CI8uDYdgWmXN4DKwfCcONgurW+xrGEWoLzviOyg5yRYxaeV55N7OB75OSGtslcs4Tjc8oNRILQG5wofw2YH+MG/jWshUfxC8yQBWJ/Akn+j1ROuS4+CEgjklZjLGC/Oc0EVgDQ=")
       |
       |   --login deatils
       |  --temp=create_login_guid_java("gdasgdshgdsh@gmail.com","123456")
       |  data=writeutf(data,rsa_public(email) )
       |  data=writeutf(data, rsa_public(pass) )
       |  --puts(1,temp[1]&"\n")
       |  --puts(1,temp[2]&"\n")
       |
       |  --guest accoun login
       |  --data=writeutf(data,create_guest_guid_java())
       |  --data=writeutf(data,"") --pass
       |
       |  data=writeutf(data,"") --secert
       |  data=writeint(data,key_time) --key time
       |  data=writeshort(data,key_size) --key_size
       |  if key_size!=0 then
       |  	--data=writebyte(data,0) -- key
       |  	for i=1 to key_size do
       |  		data=writebyte(data,key[i])
       |  	end for
       |  end if
       |
       |
       |  data=writeint(data,0)  --jd length
       |  --data=writebyte(data,0) -- jd bytes
       |
       |  data=writeutf(data,"") --pk
       |  data=writeutf(data,"rotmg") --tq
       |  data=writeutf(data,"") --h
       |  data=writeutf(data,"rotmg") --platforum
       |
       |  data=writeutf(data,"") --unknow
       |
       |  temp=reverse(int_to_bytes(length(data)+5)) &hello_packet
       |
       |  data=temp&rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],data)
       |  --if WsockSendData(Server_sock,data)!=length(data) then
       |  --	puts(1,"sending error\n")
       |  --end if
       |  return data
       |end function
       |
       |include text_packet.ew
       |procedure text_packet_read(integer client,integer inputstream)
       |  object res
       |  atom object_id
       |  res=input_stream_readutf(inputstream)
       |  object_id=input_stream_readint(inputstream)
       |  res=input_stream_readint(inputstream)
       |  res=input_stream_readbyte(inputstream)
       |  res=input_stream_readutf(inputstream)
       |  res=input_stream_readutf(inputstream)
       |  --puts(1,res&"\n")
       |
       |  --if object_id!=-1 then
       |  --  player_message_set(object_id_to_player_class[object_id],{res,33*12})
       |  --end if
       |
       |  res=input_stream_readutf(inputstream)
       |
       |  --	this.name_ = badi.readUTF(); // UTF
       |	--	this.objectId_ = badi.readInt(); // Int
       |	--	this.numStars_ = badi.readInt(); // Int
       |	--	this.bubbleTime_ = badi.readUnsignedByte(); // UnsignedByte
       |	--	this.recipient_ = badi.readUTF(); // UTF
       |	--	this.text_ = badi.readUTF(); // UTF
       |	--	this.cleanText_ = badi.readUTF(); // UTF
       |end procedure
       |
     1 |packet_read_id[text_packet+1]=routine_id("text_packet_read")
       |
       |include load_packet.ew
       |include create_suc_packet.ew
       |
       |procedure create_suc_packet_read(integer client,integer inputstream)
       |  object res
       |  --puts(1,"create_suc\n")
       |  client_list[client][client_object_id] =input_stream_readint(inputstream) --require my object id
       |  --?my_object_id
       |  --?res
       |  res=input_stream_readint(inputstream)
       |  --?res
       |  --?res
       |end procedure
     1 |packet_read_id[create_suc_packet+1]=routine_id("create_suc_packet_read")
       |
       |include players.ew
       |global sequence player_class_list,class_freelist
     1 |player_class_list={}
     1 |class_freelist={}
       |global constant player_object_id = 1
       |global constant player_stats = 2
       |global constant player_position = 3
       |global constant player_class = 4
       |global constant player_2dposition = 5
       |global constant player_name = 6
       |global constant player_message = 7
       |global constant player_client = 8
       |
       |--{temp[1],stats,location_get(temp[2]),found}
       |
       |sequence grid
     1 |grid={}
     1 |for i=1 to 255 do
   255 |  grid=append(grid,repeat({},255))	
   255 |end for
       |
       |procedure insert_into_grid(atom x, atom y, integer handle)
       |  grid[floor(y)][floor(x)]&=handle
       |  --?grid[floor(y)][floor(x)]
       |end procedure
       |
       |procedure remove_from_grid(atom x, atom y, integer handle)
       |sequence data
       |  data={}
       |  --?grid[floor(y)][floor(x)]
       |  for i=1 to length(grid[floor(y)][floor(x)]) do
       |  	 if grid[floor(y)][floor(x)][i]!=handle then
       |  	  	data&=grid[floor(y)][floor(x)][i]
       |  	 end if
       |  end for
       |  grid[floor(y)][floor(x)]=data
       |end procedure
       |
       |global function get_grid(atom x, atom y)
       |  return grid[floor(y)][floor(x)]&
       |  grid[floor(y-1)][floor(x-1)]& grid[floor(y-1)][floor(x)]&grid[floor(y-1)][floor(x+1)]&
       |         grid[floor(y)][floor(x-1)]&grid[floor(y)][floor(x+1)]&
       |         grid[floor(y+1)][floor(x-1)]&grid[floor(y+1)][floor(x)]&grid[floor(y+1)][floor(x+1)]
       |end function
       |
       |global function player_new(integer object_id, sequence stats, sequence position, integer class,sequence position2d,sequence name,integer client)
       |  integer handle
       |  if length(class_freelist)>0 then
       |    handle= class_freelist[1]
       |    class_freelist = class_freelist[2..length(class_freelist)]
       |  else
       |    player_class_list= append(player_class_list,{})
       |    handle=length(player_class_list)
       |  end if
       |
       |   player_class_list[handle]={object_id,stats,position,class,position2d,name,{"",0},client}
       |   
       |   --if class!=1280 then
       |   --  insert_into_grid(position[1],position[2],handle)
       |   --end if
       |
       |  return handle
       |end function
       |
       |global procedure player_update(integer handle,sequence stats, sequence position,sequence position2d)
       |  --if player_class_list[handle][player_class]!=1280 then
       |  --  remove_from_grid(player_class_list[handle][player_position][1],player_class_list[handle][player_position][2],handle)--previous position 
       |  --end if
       |  player_class_list[handle][player_stats]=stats
       |  player_class_list[handle][player_position]=position
       |  player_class_list[handle][player_2dposition]=position2d
       |  --if player_class_list[handle][player_class]!=1280 then
       |  --insert_into_grid(player_class_list[handle][player_position][1],player_class_list[handle][player_position][2],handle)-- new positon 
       |  --end if
       |end procedure
       |
       |global procedure player_message_set(integer handle,sequence message)
       |  player_class_list[handle][player_message]=message
       |end procedure
       |
       |global procedure player_stats_set(integer handle,sequence message)
       |  player_class_list[handle][player_stats]=message
       |end procedure
       |
       |global function player_stats_get(integer handle)
       |  return player_class_list[handle][player_stats]
       |end function
       |
       |global function player_objectid_get(integer handle)
       |  return player_class_list[handle][player_object_id]
       |end function
       |
       |global function player_client_get(integer handle)
       |  return player_class_list[handle][player_client]
       |end function
       |
       |global function player_class_get(integer handle)
       |  return player_class_list[handle][player_class]
       |end function
       |
       |global function player_message_get(integer handle)
       |  return player_class_list[handle][player_message]
       |end function
       |
       |global procedure player_delete(integer handle)
       |  --if player_class_list[handle][player_class]!=1280 then
       |  --remove_from_grid(player_class_list[handle][player_position][1],player_class_list[handle][player_position][2],handle)
       |  --end if
       |  player_class_list[handle]={}
       |  class_freelist =append(class_freelist, handle)
       |end procedure
       |
       |global procedure player_freelist_delete()--hack
       |  class_freelist={}
       |end procedure
       |
       |
       |
       |
       |sequence autolootbots_list
     1 |autolootbots_list={}
       |
       |constant autoloot_first_update=1
       |constant autoloot_first=2
       |constant autoloot_mx=3
       |constant autoloot_my=4
       |constant autoloot_tx=5
       |constant autoloot_ty=6
       |constant autoloot_object_id_to_player_class=7
       |constant autoloot_target_id=8 --not sure what this is now
       |constant autoloot_enable_move=9
       |constant autoloot_lootbag_id=10
       |constant autoloot_teleport_cooldown=11
       |constant autoloot_lootx=12
       |constant autoloot_looty=13
       |constant autoloot_itemtype=14
       |constant autoloot_timing=15
       |constant autoloot_px=16
       |constant autoloot_py=17
       |
       |function autolootbot_create()
       |    --1first update
       |    --2first
       |    --3my x
       |    --4my y
       |    --5tx
       |    --6ty
       |    --7object_id_to_player_class
       |    --8target id
       |    --9 enable move
       |    --10current loot bag target id
       |    --11 teleport cool down timer
       |    --12 loot x
       |    --13 loot y
       |    --14 the loot stat {11,itemid,-1}
       |	autolootbots_list=append(autolootbots_list, {0,0,134,140,0,0,repeat(0,4000000),-1,1,0,0,0,0,0,0,0,0})
       |	return length(autolootbots_list)
       |end function
       |
       |
       |
       |
       |
       |procedure process_update_packet(integer client,sequence data)
       |object object_type,object_id,stats
       |atom x,y,statdata_size
       |integer loc,inputstream,statdata_type
       |  --puts(1,"process_update_packet\n")
       |  object_type=int_to_bytes(782)
       |  object_id=int_to_bytes(client_list[client][client_object_id])
       |
       |  loc=match({object_type[2], object_type[1], object_id[4],object_id[3],object_id[2],object_id[1]}, data)
       |  if loc=0 then
       |  	puts(1,"a serious error as happend\n")
       |  	return
       |  end if
       |
       |  puts(1,"my stats updated\n")
       |
       |  inputstream = input_stream_new()
       |  input_stream_set(inputstream, data[loc..length(data)])	
       |
       |
       |  stats=repeat({},stats_size) --the most number of stats a object can have
       |
       |      object_type=input_stream_readshort(inputstream)
       |      object_id=input_stream_readint(inputstream)
       |      x=input_stream_readfloat(inputstream)
       |      y=input_stream_readfloat(inputstream)
       |      statdata_size=input_stream_readshort(inputstream)
       |
       |      --?statdata_size
       |      for j=1 to statdata_size do
       |      	statdata_type=input_stream_readbyte(inputstream)
       |        if statdata_type=31 or statdata_type=62 or statdata_type=82 then
       |          stats[statdata_type+1]={statdata_type,0,input_stream_readutf(inputstream)}
       |        else
       |          stats[statdata_type+1]={statdata_type,input_stream_readint(inputstream),0}
       |        end if
       |
       |      end for
       |      --?stats
       |      --782 wizard
       |      if object_type=806 or object_type=805 or object_type=804 or object_type=803 or object_type=802 or object_type=801 or object_type=800
       |      or object_type=799 or object_type=798 or object_type=797 or object_type=784 or object_type=782 or object_type=775 or object_type=768 then
       |       -- integer object_id, sequence stats, sequence position, integer class,sequence position2d,sequence name
       |	    --object_id_to_player_class[object_id]=player_new(object_id,stats,{x,y},object_type,{0,0},"")
       |	    autolootbots_list[client_list[client][client_data]][7][object_id]=player_new(object_id,stats,{x,y},object_type,{0,0},"",client)
       |	
       |	    --?autolootbots_list[client_list[client][client_data]][7][object_id]
       |	
       |	    if object_id=client_list[client][client_object_id] then
       |	      autolootbots_list[client_list[client][client_data]][3]=x
       |	      autolootbots_list[client_list[client][client_data]][4]=y
       |	    end if
       |      end if
       |
       |
       |  --?object_type
       |  --?object_id
       |  --for i=1 to length(data)-6 do
       | -- 	if data[i]=object_type[2] and data[i+1]=object_type[1] then
       |  --	  if data[i+2]=object_id[4] and data[i+3]=object_id[3] and data[i+4]=object_id[2] and data[i+5]=object_id[1] then
       | -- 		puts(1,"found\n")
       |  --	  end if
       | -- 	end if
       | -- end for
       |  --?length(data)
       |  	--my guessing is the bytes at the end of the packet are my object
       |  	--update shouldent ever destory anything for the first update packet
       |  	-- noew i just need to read them quickly
       |end procedure
       |
       |
       |sequence loot_bag_ids
     1 |loot_bag_ids={}
       |
       |procedure remove_loot_bag_id(integer id)
       |sequence data
       |  data={}
       |	for i=1 to length(loot_bag_ids) do
       |	  if loot_bag_ids[i]!=id then
       |	  	data&=loot_bag_ids[i]
       |	  end if
       |	end for
       |	loot_bag_ids=data
       |end procedure
       |
       |
       |procedure update_packet_read(integer client,integer inputstream)
       |  sequence temp
       |  integer player_handle,autoloot_handle
       |  --tiles
       |  sequence tiles
       |  integer tile_size,typee
       |  atom x,y
       |
       |  --newobjs
       |  sequence newobjs,stats
       |  integer newobj_size,object_type,object_id,statdata_size,statdata_type
       |  integer dropsize
       |
       |  sequence data,mystats,write
       |  atom found_loot,dist,dist_small,player_small
       |  autoloot_handle=client_list[client][client_data]
       |
       |
       |
       |
       |  tile_size=input_stream_readshort(inputstream)
       |  tiles={}
       |
       |  if tile_size!=0 then --tiles
       |
       |  	for i=1 to tile_size do
       |  	  x=input_stream_readshort(inputstream)
       |  	  y=input_stream_readshort(inputstream)
       |  	  typee=input_stream_readshort(inputstream)
       |  	  tiles=append(tiles,{x,y,typee})
       |
       |
       |    end for
       |
       |  end if
       |
       |  newobj_size=input_stream_readshort(inputstream)
       |  newobjs={}
       |
       |
       |  if newobj_size!=0 then --newobjs
       |
       |
       |
       |  	for i=1 to newobj_size do
       |
       |      stats=repeat({},stats_size) --the most number of stats a object can have
       |
       |      object_type=input_stream_readshort(inputstream)
       |      object_id=input_stream_readint(inputstream)
       |      x=input_stream_readfloat(inputstream)
       |      y=input_stream_readfloat(inputstream)
       |      statdata_size=input_stream_readshort(inputstream)
       |
       |      --?statdata_size
       |      for j=1 to statdata_size do
       |      	statdata_type=input_stream_readbyte(inputstream)
       |        if statdata_type=31 or statdata_type=62 or statdata_type=82 then
       |          stats[statdata_type+1]={statdata_type,0,input_stream_readutf(inputstream)}
       |        else
       |          stats[statdata_type+1]={statdata_type,input_stream_readint(inputstream),0}
       |        end if
       |
       |      end for
       |      --782 wizard
       |      if object_type=806 or object_type=805 or object_type=804 or object_type=803 or object_type=802 or object_type=801 or object_type=800
       |      or object_type=799 or object_type=798 or object_type=797 or object_type=784 or object_type=782 or object_type=775 or object_type=768 then
       |       -- integer object_id, sequence stats, sequence position, integer class,sequence position2d,sequence name
       |	    --object_id_to_player_class[object_id]=player_new(object_id,stats,{x,y},object_type,{0,0},"")
       |        autolootbots_list[autoloot_handle][7][object_id]=player_new(object_id,stats,{x,y},object_type,{0,0},"",client)
       |      end if
       |
       |      if object_type=1280 then
       |
       |      	--puts(1,"loot bag found\n")
       |      	--object_id_to_player_class[object_id]=player_new(object_id,stats,{x,y},object_type,{0,0},"")
       |      	autolootbots_list[autoloot_handle][7][object_id]=player_new(object_id,stats,{x,y},object_type,{0,0},"",client)
       |      	--for j=9 to 9+7 do
       |      	  --if stats[j][2]!=-1 then
       |      	  	--if item_index[ stats[j][2] ][2]=1  then
       |      	  	  --puts(1,"would loot\n")	
       |      	  	  --exit
       |      	  	--end if
       |      	  --end if
       |      	  --?stats[j]	
       |      	--end for
       |      	
       |
       |
       |      	for j=9 to 9+7 do
       |      	  --?stats[j]	
       |      	  if stats[j][2]!=-1 then
       |      	  	if item_index[stats[j][2]][2]=1  then--this means the item is on the auto loot list
       |      	  	  if find(object_id, loot_bag_ids)=0 and autolootbots_list[autoloot_handle][autoloot_teleport_cooldown]=0 then --loot bag as not been seen yet
       |      	  	    puts(1,"would loot "&item_index[stats[j][2]][3]&"\n")	
       |      	  	    --data=get_grid(x,y) --list of player handerles
       |      	  	    found_loot=0
       |      	  	    dist_small=10
       |      	  	    player_small=0
       |      	  	    for k=1 to length(player_class_list) do
       |      	  	      if length(player_class_list[k]) and player_class_list[k][player_client]=client then
       |      	  	        dist=point_distance(player_class_list[k][player_position][1],player_class_list[k][player_position][2],x,y)
       |      	  	        if dist<dist_small then
       |      	  	          dist_small=dist	
       |      	  	          player_small=k
       |      	  	        end if
       |                  end if
       |                end for
       |
       |      	  	     mystats=player_stats_get(autolootbots_list[autoloot_handle][7][ client_list[client][client_object_id] ])
       |      	  	        for l=13 to 13+7 do
       |      	  	          if mystats[l][2]=-1 then
       |      	  	            puts(1,"found\n")
       |      	  	 	        autolootbots_list[autoloot_handle][autoloot_target_id]=player_class_list[player_small][player_object_id]
       |      	  	 	        write=""
       |      	  	 	        autolootbots_list[autoloot_handle][autoloot_enable_move]=0
       |  	                    write=writeint(write,player_class_list[player_small][player_object_id])
       |                        temp=reverse(int_to_bytes(length(write)+5)) &49
       |                        write=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],write)
       |                        socket_send_data(client_list[client][client_socket],temp&write)
       |                        loot_bag_ids&=object_id
       |                        autolootbots_list[autoloot_handle][autoloot_lootbag_id]=object_id
       |                        autolootbots_list[autoloot_handle][autoloot_lootx]=x
       |                        autolootbots_list[autoloot_handle][autoloot_looty]=y
       |                        found_loot=1
       |                        exit --l
       |                      end if
       |                    end for--l
       |
       |      	  	    exit --j
       |      	  	  end if
       |      	  	end if
       |      	  end if
       |      	end for--j
       |      	
       |      end if
       |
       |    end for
       |
       |
       |
       |  end if
       |
       |
       |  dropsize=input_stream_readshort(inputstream)
       |  --if autolootbots_list[client_list[client][client_data]][1]=0 and dropsize!=0 then
       |  --	puts(1,"updated kabamed\n")
       |  --end if
       |  for i=1 to dropsize do
       |  	 object_id=input_stream_readint(inputstream)
       |  	
       |     --if object_id_to_player_class[object_id]!=0 then --object to be deleted is a player
       |     player_handle=autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][object_id]
       |     if  player_handle!=0 then
       |       player_delete(player_handle)
       |       autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][object_id]=0
       |     end if
       |  	
       |  end for
       |
       |
       |  if autolootbots_list[autoloot_handle][1]=0 then --required first update logic
       |    autolootbots_list[autoloot_handle][1]=1
       |  end if
       |
       |
       |  --UPDATEATT = 11;
       |  temp=reverse(int_to_bytes(length("")+5)) &updateatt_packet
       |
       |  socket_send_data(client_list[client][client_socket],temp)
       |end procedure
     1 |packet_read_id[update_packet+1]=routine_id("update_packet_read")
       |
       |
       |
       |procedure inv_swap(sequence myslot, sequence there_slot, integer myid, integer thereid, atom x, atom y, integer client)
       |  sequence write,temp
       |  	--1 is the stat id
       |  	--2 is the item id
       |  	--3 is ?
       |  	--?myslot
       |  	--?there_slot
       |  	
       |    --bado.writeInt(time_);
       |	--	position_.writeToOutput(bado);
       |	--	slotObject1_.writeToOutput(bado);
       |	--	slotObject2_.writeToOutput(bado);
       |  	
       |   -- bado.writeInt(objectId); --this is the object id owner
       |	--	bado.writeByte(slotId);
       |	--	bado.writeShort(itemType);
       |  autolootbots_list[client_list[client][client_data]][14]=there_slot[2]
       |  write=""
       |   --time
       |  write=writeint(write,current_time())
       |  --position
       |  write=writefloat(write,x)
       |  write=writefloat(write,y)
       |
       |  --INVSWAP [18993 , location [134.68716, 140.44598] , item [591921, 0, 2711] , item [591921, 4, -1]]
       |  --my stats
       |  --11 -1
       |  ---thyere
       |  --8 2711 0
       |
       |  write=writeint(write,myid)
       |  write=writebyte(write,myslot[1]-8)
       |  write=writeshort(write,myslot[2])
       |
       |  write=writeint(write,thereid)
       |  write=writebyte(write,there_slot[1]-8)
       |  write=writeshort(write,there_slot[2])
       |
       |
       |  --INVSWAP = 65;
       |  temp=reverse(int_to_bytes(length(write)+5)) &65
       |  write=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],write)
       |  socket_send_data(client_list[client][client_socket],temp&write)
       |end procedure
       |
       |atom speed
     1 |speed=SPEED_BASE + (SPEED_MULTIPLIER)
       |
       |
       |procedure move(integer client,integer autoloot_handle)
       |atom mx,my,tx,ty,angle,stime
       |
       |sequence stats, mystats
       |
       |
       |
       |  mx=autolootbots_list[autoloot_handle][autoloot_mx]
       |  my=autolootbots_list[autoloot_handle][autoloot_my]
       |  --autolootbots_list[autoloot_handle][autoloot_px]=mx
       |  --autolootbots_list[autoloot_handle][autoloot_py]=my
       |  tx=autolootbots_list[autoloot_handle][autoloot_tx]
       |  ty=autolootbots_list[autoloot_handle][autoloot_ty]
       |
       |  ?mx
       |  ?my
       |  ?autolootbots_list[autoloot_handle][autoloot_px]
       |  ?autolootbots_list[autoloot_handle][autoloot_py]
       |
       |  --?current_time()-client_list[client][client_last_move_time]
       |
       |  if autolootbots_list[autoloot_handle][autoloot_enable_move]=1 and point_distance( mx, my, tx, ty)>1 then
       |    --?point_distance( autolootbots_list[client_list[client][client_data]][3], autolootbots_list[client_list[client][client_data]][4], autolootbots_list[client_list[client][client_data]][5], autolootbots_list[client_list[client][client_data]][6])
       |    angle=get_angle_to(mx,my,tx,ty)
       |
       |    stime=current_time()-client_list[client][client_last_move_time]
       |
       |    --if client=1 then
       |    --?(stime * speed)*sin(degtorad(angle))
       |    --end if
       |      if stime>600 then
       |      	stime=600
       |      end if
       |
       |
       |    --autolootbots_list[autoloot_handle][autoloot_mx]+=(stime * speed)*sin(degtorad(angle))
       |    --autolootbots_list[autoloot_handle][autoloot_my]-=(stime * speed)*cos(degtorad(angle))
       |
       |  elsif autolootbots_list[autoloot_handle][autoloot_enable_move]=0 and point_distance( mx, my, autolootbots_list[autoloot_handle][autoloot_lootx], autolootbots_list[autoloot_handle][autoloot_looty])>0.6 then
       |    puts(1,"moving in teleport function\n")
       |    angle=get_angle_to(mx,my,tx,ty)
       |    speed=SPEED_BASE + (SPEED_MULTIPLIER)
       |    stime=current_time()-client_list[client][client_last_move_time]
       |    --if client=1 then
       |    --?(stime * speed)*sin(degtorad(angle))
       |    --end if
       |      if stime>600 then
       |      	stime=600
       |      end if
       |
       |  	angle=get_angle_to(mx,my ,autolootbots_list[autoloot_handle][autoloot_lootx],autolootbots_list[autoloot_handle][autoloot_looty])
       |    --autolootbots_list[autoloot_handle][autoloot_mx]+=(stime * speed)*sin(degtorad(angle))
       |    --autolootbots_list[autoloot_handle][autoloot_my]-=(stime * speed)*cos(degtorad(angle))
       |  else
       |    if autolootbots_list[autoloot_handle][autoloot_enable_move]=0 then
       |      --check stats of loot bag and loot1
       |      puts(1,"would looting in teleport function\n")
       |      if autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][ autolootbots_list[autoloot_handle][autoloot_lootbag_id] ]!=0 then
       |      	stats=player_stats_get(autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][ autolootbots_list[autoloot_handle][autoloot_lootbag_id] ])
       |      	for j=9 to 9+7 do
       |      	  if stats[j][2]!=-1 then
       |      	  	if item_index[stats[j][2]][2]=1  then--this means the item is on the auto loot list
       |      	  	puts(1,"looting in teleport function\n")
       |      	  	  mystats=player_stats_get(autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][ client_list[client][client_object_id] ])
       |      	  	  for k=13 to 13+7 do
       |      	  	    if mystats[k][2]=-1 then
       |      	  	      --autolootbots_list[autoloot_handle][autoloot_px]
       |      	  	      usleep(500)
       |      	  	      inv_swap(mystats[k],stats[j], client_list[client][client_object_id] ,autolootbots_list[autoloot_handle][autoloot_lootbag_id], autolootbots_list[autoloot_handle][autoloot_px], autolootbots_list[autoloot_handle][autoloot_py], client )
       |      	  	      exit
       |      	  	    end if
       |              end for
       |              exit
       |            end if
       |          end if
       |        end for
       |      end if
       |    end if
       |    autolootbots_list[autoloot_handle][autoloot_enable_move]=1
       |  end if
       |end procedure
       |
       |
       |procedure new_tick_packet_read(integer client,integer inputstream)
       |  integer player_handle,autoloot_handle
       |  integer size,tick_id,tick_time
       |  sequence temp,write,stats,data,mystats
       |  integer object_id,statdata_size,statdata_type,found_loot
       |  atom x,y,angle,mx,my,tx,ty,lootx,looty,ttime,speed,stime
       |
       |  atom dist,dist_small,player_small,dtime
       |
       |  atom tstart
       |
       |  tstart=get_tick_count()
       |
       |  tick_id=input_stream_readint(inputstream)
       |  tick_time=input_stream_readint(inputstream)
       |  size=input_stream_readshort(inputstream)
       |
       |  autoloot_handle=client_list[client][client_data]
       |
       |
       |
       |
       |  stats=repeat({},stats_size) --the most number of stats a object can have
       |
       |
       |  for i=1 to size do
       |
       |    object_id=input_stream_readint(inputstream)
       |    x=input_stream_readfloat(inputstream)
       |    y=input_stream_readfloat(inputstream)
       |
       |    player_handle=autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][object_id]
       |
       |    if player_handle!=0 then-- if object_id_to_player_class[object_id]!=0 then
       |      stats=player_stats_get(player_handle)
       |      statdata_size=input_stream_readshort(inputstream)
       |      for j=1 to statdata_size do
       |        statdata_type=input_stream_readbyte(inputstream)
       |        if statdata_type=31 or statdata_type=62 or statdata_type=82 then
       |          stats[statdata_type+1]={statdata_type,0,input_stream_readutf(inputstream)}
       |        else
       |          stats[statdata_type+1]={statdata_type,input_stream_readint(inputstream),0}
       |        end if
       |      end for
       |    else-- if object_id_to_player_class[object_id]!=0 then
       |      statdata_size=input_stream_readshort(inputstream)
       |      for j=1 to statdata_size do
       |        statdata_type=input_stream_readbyte(inputstream)
       |        if statdata_type=31 or statdata_type=62 or statdata_type=82 then
       |          stats[statdata_type+1]={statdata_type,0,input_stream_readutf(inputstream)}
       |        else
       |          stats[statdata_type+1]={statdata_type,input_stream_readint(inputstream),0}
       |        end if
       |      end for
       |    end if -- if object_id_to_player_class[object_id]!=0 then
       |
       |    if player_handle!=0 then --object to be updated is a player or loobag lol
       |
       |
       |      if object_id=client_list[client][client_object_id] then --my inventory
       |        --puts(1,"done\n")
       |      	--for j=9 to 9+11 do
       |      	  --?stats[j]	
       |      	--end for
       |      end if
       |
       |
       |
       |      if player_class_get(player_handle)=1280 then
       |      	--puts(1,"loot bag tick\n")
       |      	
       |      	for j=9 to 9+7 do
       |      	  --?stats[j]	
       |      	  if stats[j][2]!=-1 then
       |      	  	if item_index[stats[j][2]][2]=1  then--this means the item is on the auto loot list
       |      	  	  if find(object_id, loot_bag_ids)=0 and autolootbots_list[autoloot_handle][autoloot_teleport_cooldown]=0 then --loot bag as not been seen yet
       |      	  	    puts(1,"would loot "&item_index[stats[j][2]][3]&"\n")	
       |      	  	    --data=get_grid(x,y) --list of player handerles
       |      	  	    found_loot=0
       |      	  	    dist_small=10
       |      	  	    player_small=0
       |      	  	    puts(1,"dist checking\n")
       |      	  	    dtime=get_tick_count()
       |      	  	    ?dtime
       |      	  	    for k=1 to length(player_class_list) do
       |      	  	      if length(player_class_list[k]) and player_class_list[k][player_client]=client and player_class_list[k][player_class]!=1280 then
       |      	  	        dist=point_distance(player_class_list[k][player_position][1],player_class_list[k][player_position][2],x,y)
       |      	  	        if dist<dist_small then
       |      	  	          dist_small=dist	
       |      	  	          player_small=k
       |      	  	        end if
       |                  end if
       |                end for
       |                ?get_tick_count()-dtime
       |      	  	     mystats=player_stats_get(autolootbots_list[autoloot_handle][7][ client_list[client][client_object_id] ])
       |      	  	        for l=13 to 13+7 do
       |      	  	          if mystats[l][2]=-1 then
       |      	  	            puts(1,"found\n")
       |      	  	            ?get_tick_count()-tstart
       |      	  	            autolootbots_list[autoloot_handle][autoloot_timing]=get_tick_count()
       |      	  	 	        autolootbots_list[autoloot_handle][autoloot_target_id]=player_class_list[player_small][player_object_id]
       |      	  	 	        write=""
       |      	  	 	        autolootbots_list[autoloot_handle][autoloot_enable_move]=0
       |  	                    write=writeint(write,player_class_list[player_small][player_object_id])
       |                        temp=reverse(int_to_bytes(length(write)+5)) &49
       |                        write=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],write)
       |                        socket_send_data(client_list[client][client_socket],temp&write)
       |                        loot_bag_ids&=object_id
       |                        autolootbots_list[autoloot_handle][autoloot_lootbag_id]=object_id
       |                        autolootbots_list[autoloot_handle][autoloot_lootx]=x
       |                        autolootbots_list[autoloot_handle][autoloot_looty]=y
       |                        found_loot=1
       |                        exit --l
       |                      end if
       |                    end for--l
       |
       |      	  	    exit --j
       |      	  	  end if
       |      	  	end if
       |      	  end if
       |      	end for--j
       |      	
       |      end if
       |
       |
       |      player_update(  player_handle ,stats, {x,y}, {0,0} )
       |    end if
       |
       |  end for --i
       |
       |
       |  mx=autolootbots_list[autoloot_handle][autoloot_mx]
       |  my=autolootbots_list[autoloot_handle][autoloot_my]
       |
       |  tx=autolootbots_list[autoloot_handle][autoloot_tx]
       |  ty=autolootbots_list[autoloot_handle][autoloot_ty]
       |
       |  --?current_time()-client_list[client][client_last_move_time]
       |
       |  if autolootbots_list[autoloot_handle][autoloot_enable_move]=1 and point_distance( mx, my, tx, ty)>1 then
       |    --?point_distance( autolootbots_list[client_list[client][client_data]][3], autolootbots_list[client_list[client][client_data]][4], autolootbots_list[client_list[client][client_data]][5], autolootbots_list[client_list[client][client_data]][6])
       |    angle=get_angle_to(mx,my,tx,ty)
       |    speed=SPEED_BASE + (SPEED_MULTIPLIER)
       |    stime=current_time()-client_list[client][client_last_move_time]
       |
       |    --if client=1 then
       |    --?(stime * speed)*sin(degtorad(angle))
       |    --end if
       |      if stime>600 then
       |      	stime=600
       |      end if
       |
       |
       |    autolootbots_list[autoloot_handle][autoloot_mx]+=(stime * speed)*sin(degtorad(angle))
       |    autolootbots_list[autoloot_handle][autoloot_my]-=(stime * speed)*cos(degtorad(angle))
       |
       |  elsif autolootbots_list[autoloot_handle][autoloot_enable_move]=0 and point_distance( mx, my, autolootbots_list[autoloot_handle][autoloot_lootx], autolootbots_list[autoloot_handle][autoloot_looty])>0.6 then
       |    puts(1,"moving in new tick function\n")
       |    angle=get_angle_to(mx,my,tx,ty)
       |    speed=SPEED_BASE + (SPEED_MULTIPLIER)
       |    stime=current_time()-client_list[client][client_last_move_time]
       |    --if client=1 then
       |    --?(stime * speed)*sin(degtorad(angle))
       |    --end if
       |      if stime>600 then
       |      	stime=600
       |      end if
       |
       |  	angle=get_angle_to(mx,my ,autolootbots_list[autoloot_handle][autoloot_lootx],autolootbots_list[autoloot_handle][autoloot_looty])
       |    autolootbots_list[autoloot_handle][autoloot_mx]+=(stime * speed)*sin(degtorad(angle))
       |    autolootbots_list[autoloot_handle][autoloot_my]-=(stime * speed)*cos(degtorad(angle))
       |  else
       |    if autolootbots_list[autoloot_handle][autoloot_enable_move]=0 then
       |      --check stats of loot bag and loot1
       |      puts(1,"looting in new tick function\n")
       |      if autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][ autolootbots_list[autoloot_handle][autoloot_lootbag_id] ]!=0 then
       |      	stats=player_stats_get(autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][ autolootbots_list[autoloot_handle][autoloot_lootbag_id] ])
       |      	for j=9 to 9+7 do
       |      	  if stats[j][2]!=-1 then
       |      	  	if item_index[stats[j][2]][2]=1  then--this means the item is on the auto loot list
       |      	  	  mystats=player_stats_get(autolootbots_list[autoloot_handle][autoloot_object_id_to_player_class][ client_list[client][client_object_id] ])
       |      	  	  for k=13 to 13+7 do
       |      	  	    if mystats[k][2]=-1 then
       |      	  	      inv_swap(mystats[k],stats[j], client_list[client][client_object_id] ,autolootbots_list[autoloot_handle][autoloot_lootbag_id], autolootbots_list[autoloot_handle][3], autolootbots_list[autoloot_handle][4], client )
       |      	  	      exit
       |      	  	    end if
       |              end for
       |              exit
       |            end if
       |          end if
       |        end for
       |      end if
       |    end if
       |    autolootbots_list[autoloot_handle][autoloot_enable_move]=1
       |  end if
       |
       |  autolootbots_list[autoloot_handle][autoloot_px]=mx
       |  autolootbots_list[autoloot_handle][autoloot_py]=my
       |
       |
       |  write=""
       |  write=writeint(write,tick_id) --tick id
       |  ttime=current_time()
       |  write=writeint(write,ttime) --time
       |  client_list[client][client_last_move_time]=ttime
       |  --position
       |  write=writefloat(write,autolootbots_list[client_list[client][client_data]][3])
       |  write=writefloat(write,autolootbots_list[client_list[client][client_data]][4])
       |
       |  write=writeshort(write,0)
       |  --Move = 7;
       |  temp=reverse(int_to_bytes(length(write)+5)) &move_packet
       |  write=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],write)
       |  socket_send_data(client_list[client][client_socket],temp&write)
       |end procedure
     1 |packet_read_id[new_tick_packet+1]=routine_id("new_tick_packet_read")
       |
       |
       |procedure goto_packet_read(integer client,integer inputstream)
       |  object res
       |  integer  autoloot_handle
       |  sequence write,temp
       |
       |
       |
       |  res=input_stream_readint(inputstream)
       |  if client_list[client][client_object_id]=res then
       |    --puts(1,"crapballs\n")
       |    autoloot_handle=client_list[client][client_data]
       |
       |  	res=input_stream_readfloat(inputstream)
       |  	autolootbots_list[autoloot_handle][3]=res
       |    res=input_stream_readfloat(inputstream)
       |    autolootbots_list[autoloot_handle][4]=res
       |    autolootbots_list[autoloot_handle][autoloot_target_id]=-1
       |
       |
       |
       |    remove_loot_bag_id(autolootbots_list[autoloot_handle][autoloot_lootbag_id])
       |    autolootbots_list[autoloot_handle][autoloot_teleport_cooldown]=10 --set this here teleport cool down
       |
       |    puts(1,"teleport\n")
       |    ?get_tick_count()-autolootbots_list[autoloot_handle][autoloot_timing]
       |    autolootbots_list[autoloot_handle][autoloot_timing]=get_tick_count()
       |
       |    move(client,autoloot_handle)
       |
       |  else
       |    res=input_stream_readfloat(inputstream)
       |    res=input_stream_readfloat(inputstream)
       |  end if
       |
       |  write=""
       |  write=writeint(write,current_time()) --time
       |
       |  temp=reverse(int_to_bytes(length(write)+5)) &gotoack_packet
       |  write=rc4_arcfour_encrypt_block(client_list[client][client_rc4_2],write)
       |  socket_send_data(client_list[client][client_socket],temp&write)
       |end procedure
       |
     1 |packet_read_id[goto_packet+1]=routine_id("goto_packet_read")
       |
       |
       |procedure invresult_packet_read(integer client,integer inputstream)
       |  sequence mystats
       |  object res
       |  integer autoloot_handle
       |  res=input_stream_readint(inputstream)
       |  puts(1,"invresult\n")
       |  ?res
       |  autoloot_handle=client_list[client][client_data]
       |  if res=0 then
       |
       |   --stats=player_stats_get(autolootbots_list[client_list[client][client_data]][7][ client_list[client][client_object_id] ])
       |  	--autolootbots_list[client_list[client][client_data]][7][ client_list[client][client_object_id] ]
       |     mystats=player_stats_get(autolootbots_list[autoloot_handle][7][ client_list[client][client_object_id] ])
       |     for k=12 to 12+7 do
       |      	if mystats[k][2]=-1 then
       |      	  mystats[k][2]=autolootbots_list[autoloot_handle][14]	
       |      	  player_stats_set(autolootbots_list[autoloot_handle][7][ client_list[client][client_object_id] ],mystats)
       |      	  if isChecked(checkbox_sound_looted)=1 then
       |           VOID = playSound("button-3.wav")	
       |          end if
       |      	  exit
       |      	end if
       |     end for
       |  end if
       |
       |  ?get_tick_count()-autolootbots_list[autoloot_handle][autoloot_timing]
       |end procedure
       |
     1 |packet_read_id[invresult_packet+1]=routine_id("invresult_packet_read")
       |
       |
       |
       |procedure read_packet(integer client)
       |  sequence data,fail_message
       |  integer inputstream,packet_id,packet_len
       |  object ret
       |
       |  --puts(1,"location class size "&sprint(location_classsize())&"\n")
       |  --puts(1,"object_status class size "&sprint(object_status_classsize())&"\n")
       |  --puts(1,"object_status_data class size "&sprint(object_status_data_classsize())&"\n")
       |  --puts(1,"stat_data class size "&sprint(stat_data_classsize())&"\n")
       |  --puts(1,"tile class size "&sprint(tile_classsize())&"\n")
       |
       |  --puts(1,"size of  player_class_list "&sprint(length(player_class_list))&"\n")
       |
       |  inputstream=client_list[client][client_inputstream]
       |
       |
       |  while 1 do
       |  	
       |
       |  if input_stream_length(inputstream)>=5 and input_stream_length(inputstream)>=bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)} ) then
       |  else
       |    exit
       |  end if
       |
       |  packet_id=input_stream_peek(inputstream,5)
       |  packet_len=bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)} )
       |	
       |  --puts(1,packet_names[packet_id+1]&"\n")
       |
       |  if input_stream_length(inputstream)>=5 then
       |  	data=rc4_arcfour_encrypt_block(client_list[client][client_rc4_1],input_stream_slice(inputstream,6,packet_len))
       |  	
       |  	input_stream_set(inputstream, input_stream_slice(inputstream,packet_len+1, input_stream_length(inputstream) ) )
       |  	if packet_id=update_packet and autolootbots_list[client_list[client][client_data]][2]=0 then
       |  	  autolootbots_list[client_list[client][client_data]][2]=1
       |  	  process_update_packet(client,data)
       |  	else
       |  	   input_stream_set(inputstream, data&input_stream_get(inputstream))	
       |  	end if
       |  	
       |  	
       |  end if
       |
       |  if packet_id=fail_packet then
       |    puts(1,"fail ")
       |  	?input_stream_readint(inputstream)
       |  	fail_message=input_stream_readutf(inputstream)
       |  	puts(1,fail_message&"\n")
       |    WsockCloseSocket(client_list[client][client_socket])
       |  	if length(fail_message)>6 then
       |  	  if fail_message[1]='A' and fail_message[2]='c' then
       |  	  	--account
       |  	  	--puts(1,"accouct in use found \n")
       |  	  	--accounts[client_list[client][client_account_id]][5]=0
       |        --client_list=remove_line(client_list,client)
       |  	  end if	
       |  	end if
       |  	
       |  	input_stream_set(inputstream, "")
       |  	
       |    --if match("Lost connection",fail_message) then
       |  	--  accounts[client_list[client][client_account_id]][5]=0
       |  	--  connect_to_server()
       |  	--end if
       |  	
       |  	exit
       |  end if
       |
       |  if packet_read_id[packet_id+1]!=-1 then
       |    client_set_packet_len(client,packet_len)--new fix mapload packet
       |    if autolootbots_list[client_list[client][client_data]][2]=1 and packet_id=update_packet then
       |     socket_send_data(client_list[client][client_socket],reverse(int_to_bytes(length("")+5)) &updateatt_packet)
       |     autolootbots_list[client_list[client][client_data]][2]=2 --first update logic
       |    else
       |       call_proc(packet_read_id[packet_id+1], {client,inputstream})	
       |    end if
       |
       |  else
       |   puts(1,"read unknow packet with id:"&sprint(packet_id))
       |   WsockCloseSocket(client_list[client][client_socket])
       |   input_stream_set(inputstream, "")
       |   exit
       |  end if
       |
       |  end while
       |end procedure
       |
       |--sequence fd_read,fd_data
       |--fd_read=repeat(0,65536)
       |--fd_data=repeat({},65536)
       |
       |
       |procedure newread(integer sock)
       | atom      index, newsock
       |  integer   action,  iwork,inputstream
       |  object    owork,junk
       |  sequence  newIP,swork,rx,tx
       |  sequence  data
       |
       |
       |    rx = ""
       |    owork = WsockReadData_1024(sock,4096)
       |    while sequence(owork) do
       |      rx = rx & owork
       |      owork = WsockReadData_1024(sock,4096)
       |    end while
       |
       |    if length(rx) > 0 then
       |      --fd_read[sock]+=1
       |
       |      if sockets[sock]=0 then
       |      	return
       |      end if
       |
       |      inputstream=client_list[sockets[sock]][client_inputstream]
       |
       |      input_stream_append(inputstream,rx)
       |
       |      if input_stream_length(inputstream)>=5 then
       |        --puts(1,"packet length "&sprint(bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)})) &"  : actual len:"&sprint(input_stream_length(inputstream)) &"\n" )
       |        --puts(1,"packet id:"&sprint(input_stream_peek(inputstream,5))&"\n")
       |        --fd_data[sock]={input_stream_length(inputstream), bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)} ) }
       |        if input_stream_length(inputstream)>=bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)} ) then
       |          read_packet(sockets[sock])	
       |        end if
       |      end if
       |
       |    end if
       |	
       |end procedure
       |
       |procedure processServerMessage(atom hWnd, atom arg1, atom arg2)
       |  atom      index, newsock
       |  integer   action, sock, iwork,inputstream,target_index
       |  object    owork,junk
       |  sequence  newIP,swork,rx,tx
       |  sequence  data
       |
       |  action = lo_word(arg2)
       |  sock = arg1
       |
       |  if action=FD_CONNECT then
       |  	puts(1,"connected\n")
       |  	
       |    if sockets[sock]=0 then
       |       --target_index=1
       |      for i=1 to length(accounts) do
       |      	if accounts[i][5]=0 then
       |      	  target_index=i
       |      	  accounts[i][5]=1
       |      	  exit	
       |      	end if
       |      end for
       |
       |      index=autolootbot_create()
       |      --autolootbots_list[index][5]=134
       |      --autolootbots_list[index][6]=140
       |      autolootbots_list[index][5]=real(accounts[target_index][3])
       |      autolootbots_list[index][6]=real(accounts[target_index][4])
       |
       |
       |      --fd_data[sock]={0,0}
       |      --fd_read[sock]=1
       |      --
       |      sockets[sock]=client_new(accounts[target_index][1],accounts[target_index][2],"",sock,index,target_index)
       |      --sockets[sock]=client_new("","","",sock,index,1)
       |
       |      iwork=WsockSendData(sock,hello_packet_write(sockets[sock],accounts[target_index][1],accounts[target_index][2]))
       |  	  --socket_send_data(sock,hello_packet_write(sockets[sock],create_random_guild(),""))
       |  	  --socket_send_data(sock,create_packet_write(sockets[sock]))
       |  	  --socket_send_data(sock,create_packet_write(sockets[sock]))
       |      iwork=WsockSendData(sock,load_packet_write(sockets[sock],1))
       |
       |
       |    else
       |
       |      puts(1,"error socket already in use\n")
       |	
       |    end if
       |
       |  	
       |  elsif action = FD_READ then
       |    rx = ""
       |    owork = WsockReadData_1024(sock,4096)
       |    while sequence(owork) do
       |      rx = rx & owork
       |      owork = WsockReadData_1024(sock,4096)
       |    end while
       |
       |    if length(rx) > 0 then
       |
       |      --fd_read[sock]+=1
       |
       |      if sockets[sock]=0 then
       |      	return
       |      end if
       |
       |      inputstream=client_list[sockets[sock]][client_inputstream]
       |
       |      input_stream_append(inputstream,rx)
       |
       |      if input_stream_length(inputstream)>=5 then
       |        --puts(1,"packet length "&sprint(bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)})) &"  : actual len:"&sprint(input_stream_length(inputstream)) &"\n" )
       |        --puts(1,"packet id:"&sprint(input_stream_peek(inputstream,5))&"\n")
       |        --fd_data[sock]={input_stream_length(inputstream), bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)} ) }
       |        if input_stream_length(inputstream)>=bytes_to_int( {input_stream_peek(inputstream,4),input_stream_peek(inputstream,3),input_stream_peek(inputstream,2),input_stream_peek(inputstream,1)} ) then
       |          read_packet(sockets[sock])	
       |        end if
       |      end if
       |
       |    end if
       |  elsif action = FD_CLOSE then
       |     puts(1,"server closed\n")
       |     WsockCloseSocket(sock)
       |
       |
       |     accounts[client_list[sockets[sock]][client_account_id]][5]=0
       |     autolootbots_list=remove_line(autolootbots_list,client_list[sockets[sock]][client_data])
       |     client_list=remove_line(client_list,sockets[sock])
       |     puts(1,"computer \n")
       |     ?length(client_list)
       |
       |     sockets[sock]=0
       |  	 connect_to_server()
       |     -- need to free the client
       |  end if
       |end procedure
       |--------------------------------------------------------------------------------
       |procedure Window1_onClose (integer self, integer event, sequence params)--params is ()
       |  --WsockCloseSocket(Server_sock)
     1 |end procedure
     1 |setHandler( Window1, w32HClose, routine_id("Window1_onClose"))
       |--------------------------------------------------------------------------------
       |procedure Window1_onEvent (integer self, integer event, sequence params)--params is ( int iMsg, atom wParm, atom lParm )
   202 |  if params[1] = SM_ASYNC then
       |	processServerMessage(hWndMainWindow,params[2],params[3])
       |  end if
   202 |end procedure
     1 |setHandler( Window1, w32HEvent, routine_id("Window1_onEvent"))
       |--------------------------------------------------------------------------------
       |procedure Window1_onTimer (integer self, integer event, sequence params)--params is ( int timerId)
       |sequence text,data
     1 |  if params[1]=1001 then
       |    --connect_to_server()
       |  	--killTimer(Window1,1001)
       |  	--text=""
       |  	--data=""
       |  	--repaintWindow(Window1)
       |  	  --for i=1 to 65536 do
       |      	--if fd_read[i]!=0 then
       |      	--  text&=sprint(fd_read[i])&", "
       |      	--end if
       |      	--if length(fd_data[i]) then
       |      	  --data&=sprint(fd_data[i][1])&", "&sprint(fd_data[i][2])&" : "	
       |      	  --data&=sprint(client_list[sockets[i]][client_packet_len])&"  "&sprint(input_stream_length(client_list[sockets[i]][client_inputstream]))&"  "
       |      	--end if
       |      --end for
       |
       |      --wPuts({Window1,1,1},text)
       |      --wPuts({Window1,1,20},data)
     1 |  elsif params[1]=1002  then
     1 |  	for i=1 to length(client_list) do
       |  	  if length(client_list[i]) then
       |  	  	--read_packet(i)
       |  	  	newread(client_list[i][7])
       |  	  end if	
       |  	end for
       |  	
     1 |    for i=1 to length(autolootbots_list) do
       |      autolootbots_list[i][11]-=1	
       |      if autolootbots_list[i][11]<0	then
       |      	autolootbots_list[i][11]=0
       |      end if
       |    end for
       |  elsif params[1]=3000 then
       |    globalcount+=1
       |    --if globalcount>=length(accounts) then
       |    if globalcount>=globallimt then
       |       killTimer(Window1,3000)	
       |    end if
       |    --?globalcount
       |  	connect_to_server()
       |  end if
     1 |end procedure
     1 |setHandler( Window1, w32HTimer, routine_id("Window1_onTimer"))
       |--------------------------------------------------------------------------------
       |procedure PushButton23_onClick (integer self, integer event, sequence params)--params is ()
       |
       |  if getCount( List_accounts )>=globallimt then
       |   return
       |  end if
       |
       |
       |  if length(getText(textbox_email)) and length(getText(textbox_password)) and length(getText(textbox_target_x)) and length(getText(textbox_target_y)) then
       |  	addItem(List_accounts,getText(textbox_email)&":"&getText(textbox_password)&":"&getText(textbox_target_x)&":"&getText(textbox_target_y))
       |  	accounts=append(accounts,{getText(textbox_email),getText(textbox_password),getText(textbox_target_x),getText(textbox_target_y),0})
       |  end if
       |
       |
       |
       |end procedure
     1 |setHandler( PushButton23, w32HClick, routine_id("PushButton23_onClick"))
       |--------------------------------------------------------------------------------
       |procedure PushButton24_onClick (integer self, integer event, sequence params)--params is ()
       |  integer index,ret
       |
       |  index=getIndex(List_accounts)
       |  if index=0 then
       |  	return
       |  end if
       |
       |  ret=deleteItem( List_accounts, index )
       |  setIndex(List_accounts,index)
       |  accounts=remove_line(accounts,index)
       |
       |
       |end procedure
     1 |setHandler( PushButton24, w32HClick, routine_id("PushButton24_onClick"))
       |--------------------------------------------------------------------------------
       |procedure PushButton25_onClick (integer self, integer event, sequence params)--params is ()
       |
       |  integer fn
       |  object ret
       |
       |  ret=0
       |  if file_exsist("accounts.txt") then
       |    ret = message_box("Warning account.txt already exists do you the file to be overwritten?","Warning",MB_YESNO)	
       |  end if
       |
       |  if ret=IDNO then
       |    returnValue(1)
       |    return
       |  end if
       |
       |  fn=open("accounts.txt","w")
       |  for i=1 to length(accounts) do
       |  	puts(fn, accounts[i][1]&"\n" )
       |  	puts(fn, accounts[i][2]&"\n" )
       |  	puts(fn, accounts[i][3]&"\n" )
       |  	puts(fn, accounts[i][4]&"\n" )
       |  end for
       |  close(fn)
       |
       |
       |end procedure
     1 |setHandler( PushButton25, w32HClick, routine_id("PushButton25_onClick"))
       |--------------------------------------------------------------------------------
       |procedure PushButton9_onClick (integer self, integer event, sequence params)--params is ()
       |integer index
       |object ret
       |  index=getIndex(List_items)
       |  if index=0 then
       |  	return
       |  end if
       |  addItem(List_white_items,getItem(List_items,index))
       |  ret=deleteItem( List_items, index )
       |  setIndex(List_items,index)
       |  mark_white_item()
       |end procedure
     1 |setHandler( PushButton9, w32HClick, routine_id("PushButton9_onClick"))
       |--------------------------------------------------------------------------------
       |procedure PushButton10_onClick (integer self, integer event, sequence params)--params is ()
       |  integer index
       |object ret
       |  index=getIndex(List_white_items)
       |  if index=0 then
       |  	return
       |  end if
       |  addItem(List_items,getItem(List_white_items,index))
       |  ret=deleteItem( List_white_items, index )
       |  setIndex(List_white_items,index)
       |
       |  mark_white_item()
       |end procedure
     1 |setHandler( PushButton10, w32HClick, routine_id("PushButton10_onClick"))
       |--------------------------------------------------------------------------------
       |procedure PushButton11_onClick (integer self, integer event, sequence params)--params is ()
       |sequence text
       |integer fn
       |  fn=open("items.txt","w")
       |  for i=1 to getCount( List_white_items ) do
       |  	text = getItem( List_white_items, i )
       |  	puts(fn,text&"\n")
       |  end for
       |  close(fn)
       |end procedure
     1 |setHandler( PushButton11, w32HClick, routine_id("PushButton11_onClick"))
       |--------------------------------------------------------------------------------
       |procedure PushButton14_onClick (integer self, integer event, sequence params)--params is ()
       |
       |if length(accounts) then
       |  setEnable(PushButton14,0)
       |
       |  --for i=1 to length(accounts) do
       |  for i=1 to 30 do
       |  	  --connect_to_server()
       |  end for
       |
       |  globalcount=0
       |  setTimer(Window1,3000,1000)
       |
       |end if
       |
       |
       |end procedure
     1 |setHandler( PushButton14, w32HClick, routine_id("PushButton14_onClick"))
       |
       |
     1 |WinMain( Window1,Normal )
       |--this program has 1506 lines without including this line. If there is a discrepancy please send this file zipped to Judith.

