script_name("обыссыватель")
script_version("1.96")
script_author("James_Bond/rubbishman/Coulson")
local LIP = {};
local dlstatus = require('moonloader').download_status
local mem = require 'memory'
function main()
	while not isSampAvailable() do wait(100) end
	lua_thread.create(checkversion)
	while goplay == 0 or goplay == 2 do wait(100) end
	firstload()
	onload()
	while true do
		wait(0)
		if sampGetCurrentServerAddress() == '91.134.210.2' or sampGetCurrentServerAddress() == '91.134.210.1' then sampAddChatMessage(('[ERROR]: У тебя мочи не хватит для этого сервера.'), 0xFE1312)
			if cegj > 0 then end
		else
			result, target = getCharPlayerIsTargeting(playerHandle)
			if result and isCharInAnyCar(target) == false then
				result2, playerid = sampGetPlayerIdByCharHandle(target)
				if result2 and playerid > - 1 then
					nick = sampGetPlayerNickname(playerid)
					name, surname = string.match(nick, "(%g+)_(%g+)")
					if isCharDead(target) == true then pX, pY, pZ = getCharCoordinates(target) end
					stope = 1
				end
				if nick ~= nil then
					for i = 1, #data.blacklist do
						if data.blacklist[i] == string.upper(nick) then stope = 0 end
					end
				end
				if nick == "James_Bond" or nick == "Phil_Coulson" or nick == "Vittore_Deltoro" or nick == "Set_Johnson" or nick == "Riley_Reid" or nick == "Neax_Wayne" or nick == "Mike_Rein" or nick == "Alex_Rein" or nick == "Francesco_Garsia" then stope = 2 end
			end
			--основная логика скрипта
			if not sampIsChatInputActive() and nick ~= nil and isCharDead(target) == true and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isKeyDown(whatkeyid(data.options.hotkey)) and stope == 1 then
				myX, myY, myZ = getCharCoordinates(playerPed)
				if getDistanceBetweenCoords3d(pX, pY, pZ, myX, myY, myZ) < 10 then
					wait(100)
					-- ТУТ ССАТЬ
					if data.options.pisstype == 0 then peetype1 = math.random(1, 10) else peetype1 = data.options.pisstype end
					iwanttopee(peetype1, name, surname, nick)
				end
			end
			--защита автора скрипта
			donotpee()
		end
	end
end

function donotpee()
	if not sampIsChatInputActive() and isCharDead(target) == true and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isKeyDown(whatkeyid(data.options.hotkey)) and stope == 2 then
		wait(500)
		sampSendChat("/me расстегнул ширинку, спустил трусы, достал инструмент")
		forceWeatherNow(8)
		wait(1100)
		sampSendChat("/do Вдруг, откуда не возьмись, подул сильный ветер, начался дождь.")
		wait(1300)
		sampSendChat("/me обосрался от неожиданности, чихнул")
		wait(1300)
		sampSendChat("/do Ароматная золотая жидкость струйкой стекает по штанине неудачника.")
		wait(10000)
		forceWeatherNow(0)
		stope = 0
	end
end

function iwanttopee(peetype, peename, peesurname, peenick)
	if peetype == 1 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat('/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал инструмент')
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("/do Ароматная золотая жидкость струйкой стекает по трупу "..peename.."'a "..peesurname.."'a.")
				else
					sampSendChat("/do Ароматная золотая жидкость струйкой стекает по трупу "..peenick.."'a.")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('/me подтянул джинсы, вздохнул с облегчением, застегнул ширинку')
					wait(1100)
					nick = nil
					name = nil
					surname = nil
				end
			end
		end
	end
	if peetype == 2 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat("Слышь " ..peename.." "..peesurname.." чего ты мне сделаешь??")
			else
				sampSendChat("Слышь " ..peenick.." чего ты мне сделаешь??")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("ва вторых пошел ты нафиг конь питерский")
				else
					sampSendChat("ва вторых пошел ты нафиг конь питерский")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('втетьих что ты мне сделаешь, я в другом городе')
					wait(1100)
					if isPlayerDead(playerHandle) == false then
						sampSendChat('за мат извени')
						nick = nil
						name = nil
						surname = nil
					end
				end
			end
		end
	end
	if peetype == 3 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat("Hasta la vista, baby")
				wait(1300)
				if isPlayerDead(playerHandle) == false then
					wait(200)
					pissscreen(peenick)
					if data.options.screenshot == 1 then wait(750) end
					if data.options.screenshot == 0 then wait(1200) end
				end
			end
		end
	end
	if peetype == 4 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat(peename.." "..peesurname..", вы имеете право хранить молчание, право на люцифера и один телефонный звонок")
			else
				sampSendChat(peenick..", вы имеете право хранить молчание, право на люцифера и один телефонный звонок")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("Если вы не можете оплатить услуги люцифера, он будет предоставлен вам государством")
				else
					sampSendChat("Если вы не можете оплатить услуги люцифера, он будет предоставлен вам государством")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
			end
		end
	end
	if peetype == 5 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat("— Помнишь, "..peename..", я пообещал убить тебя последним?")
			else
				sampSendChat("— Помнишь, "..peenick..", я пообещал убить тебя последним?")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				sampSendChat("— Конечно, Байкер, ты обещал!")
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('— Я солгал.')
					wait(1100)
					nick = nil
					name = nil
					surname = nil
				end
			end
		end
	end
	if peetype == 6 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat("Покойся с миром, щенок.")
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				sampSendChat("/me погладил щенка перед смертью")
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				wait(1100)
				nick = nil
				name = nil
				surname = nil
			end
		end
	end
	if peetype == 7 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat("/s Установим здесь советский порядок.")
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat(peename.." "..peesurname.." приговорен к расстрелу!")
				else
					sampSendChat(peenick.." приговорен к расстрелу!")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('/s Приговор приведён в исполнение!')
					wait(1100)
					nick = nil
					name = nil
					surname = nil
				end
			end
		end
	end
	if peetype == 8 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat("/s Я достиг этого, мам! Я на вершине мира!")
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("/s Я убил этого кожаного ублюдка!")
				else
					sampSendChat("/s Я убил этого кожаного ублюдка!")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
			end
		end
	end
	if peetype == 9 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat("Как считаешь, я похож на убийцу?")
			wait(200)
			pissscreen(peenick)
			if data.options.screenshot == 1 then wait(750) end
			if data.options.screenshot == 0 then wait(1200) end
		end
	end
	if peetype == 10 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat("Винтовка — всего лишь инструмент, убивает каменное сердце.")
			wait(200)
			pissscreen(peenick)
			if data.options.screenshot == 1 then wait(750) end
			if data.options.screenshot == 0 then wait(1200) end
		end
	end
end













function LIP.load(fileName)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.');
	local file = assert(io.open(fileName, 'r'), 'Error loading file : ' .. fileName);
	local data = {};
	local section;
	for line in file:lines() do
		local tempSection = line:match('^%[([^%[%]]+)%]$');
		if(tempSection)then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection;
			data[section] = data[section] or {};
		end
		local param, value = line:match('^([%w|_]+)%s-=%s-(.+)$');
		if(param and value ~= nil)then
			if(tonumber(value))then
				value = tonumber(value);
			elseif(value == 'true')then
				value = true;
			elseif(value == 'false')then
				value = false;
			end
			if(tonumber(param))then
				param = tonumber(param);
			end
			data[section][param] = value;
		end
	end
	file:close();
	return data;
end
function LIP.save(fileName, data)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.');
	assert(type(data) == 'table', 'Parameter "data" must be a table.');
	local file = assert(io.open(fileName, 'w+b'), 'Error loading file :' .. fileName);
	local contents = '';
	for section, param in pairs(data) do
		contents = contents .. ('[%s]\n'):format(section);
		for key, value in pairs(param) do
			contents = contents .. ('%s=%s\n'):format(key, tostring(value));
		end
		contents = contents .. '\n';
	end
	file:write(contents);
	file:close();
end
function cmdPissList()
	sampAddChatMessage(('Чёрный список обыссывателя: '), 0xEFBFB)
	for i = 1, #data.blacklist do
		if data.blacklist[i] ~= nil then
			sampAddChatMessage((i..'. '..data.blacklist[i]), 0xFFFFFF)
		end
	end
end
function cmdPissAdd(newFriend)
	newFriendN = tonumber(newFriend)
	local data = LIP.load('moonloader\\config\\pisser.ini');
	myIndex = 0
	abc = 1
	for i = 1, #data.blacklist do
		if data.blacklist[i] == newFriend then abc = 2 end
	end
	while abc == 1 do
		myIndex = myIndex + 1
		if data.blacklist[myIndex] == nil then abc = 2 end
	end
	data.blacklist[myIndex] = newFriend
	LIP.save('moonloader\\config\\pisser.ini', data);
	local script = thisScript()
	script:reload()
end
function cmdPissDel(delFriend)
	delFriendN = tonumber(delFriend)
	local data = LIP.load('moonloader\\config\\pisser.ini');
	if delFriend ~= nil then delFriend = string.upper(delFriend) end
	for i = 1, #data.blacklist do
		if data.blacklist[i] == delFriend then data.blacklist[i] = nil end
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	local script = thisScript()
	script:reload()
end
function cmdPissHotKey()
	lua_thread.create(cmdPissHotKey2)
end
function cmdPissHotKey2()
	sampShowDialog(983, "/pisshotkey - текущая клавиша: "..data.options.hotkey, string.format("A\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN\nO\nP\nQ\nR\nS\nT\nU\nV\nW\nX\nY\nZ"), "Выбрать", "Закрыть", 2)
	while sampIsDialogActive() do wait(10) end
	sampCloseCurrentDialogWithButton(0)
	local resultMain, buttonMain, typ, tryyy = sampHasDialogRespond(983)
	if resultMain then
		if buttonMain == 1 then
			data.options.hotkey = whatidkey(typ + 65)
			LIP.save('moonloader\\config\\pisser.ini', data);
		end
	end
end
function cmdPissInform()
	if data.options.startmessage == 1 then
		data.options.startmessage = 0 sampAddChatMessage(('Уведомление активации обыссывателя при запуске игры отключено'), 0x348cb2)
	else
		data.options.startmessage = 1 sampAddChatMessage(('Уведомление активации обыссывателя при запуске игры включено'), 0x348cb2)
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	data = LIP.load('moonloader\\config\\pisser.ini');
	for i = 1, #data.blacklist do
		if data.blacklist[i] ~= nil then data.blacklist[i] = string.upper(data.blacklist[i]) end
	end
end
function cmdPissScreen()
	if data.options.screenshot == 1 then
		data.options.screenshot = 0 sampAddChatMessage(('Скриншот при обыссывании выключен'), 0x348cb2)
	else
		data.options.screenshot = 1 sampAddChatMessage(('Скриншот при обыссывании включен'), 0x348cb2)
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	data = LIP.load('moonloader\\config\\pisser.ini');
	for i = 1, #data.blacklist do
		if data.blacklist[i] ~= nil then data.blacklist[i] = string.upper(data.blacklist[i]) end
	end
end
function firstload()
	if not doesDirectoryExist("moonloader\\config") then createDirectory("moonloader\\config") end
	if not doesFileExist("moonloader\\config\\pisser.ini") then
		local data =
		{
			options =
			{
				startmessage = 1,
				screenshot = 1,
				hotkey = 'R',
				pisstype = 0
			},
			blacklist =
			{
				"ANDREW_SOPRANO",
				"DWIGHT_FORESTER",
				"CHESTER_PHILLIPS",
				"MORGAN_EGOROV",
				"ALAN_MORGAN",
				"ALAN_MORGAN",
				"ALEX_SAVAGE",
				"CHRISTOPHER_STAR",
				"QUENTIN_BURATINO",
				"ALEJANDRO_SAUCE",
				"SAM_ROBERSON",
				"PAVEL_BRATUHA",
				"GARY_BLACK",
			},
		};
		LIP.save('moonloader\\config\\pisser.ini', data);
		sampAddChatMessage(('Первый запуск обыссывателя. Был создан .ini: moonloader\\config\\pisser.ini'), 0x348cb2)
		sampAddChatMessage(('Приятной игры на Samp-Rp! С уважением, игрок Samp-Rp Revolution James_Bond!'), 0x348cb2)
	end
	-- ВВОД В ИНИ НОВЫХ НАСТРОЕК, ДЛЯ СОВМЕСТИМОСТИ ПРИ ПЕРЕХОДЕ СО СТАРЫХ ВЕРСИЙ
	data = LIP.load('moonloader\\config\\pisser.ini');
	if data.options.screenshot == nil then data.options.screenshot = 1 end
	LIP.save('moonloader\\config\\pisser.ini', data);
	data = LIP.load('moonloader\\config\\pisser.ini');
	if data.options.pisstype == nil then data.options.pisstype = 0 end
	LIP.save('moonloader\\config\\pisser.ini', data);
	data = LIP.load('moonloader\\config\\pisser.ini');
	if data.options.content1 ~= nil then data.options.content1 = nil end
	LIP.save('moonloader\\config\\pisser.ini', data);
	data = LIP.load('moonloader\\config\\pisser.ini');
	if data.options.content3 ~= nil then data.options.content3 = nil end
	LIP.save('moonloader\\config\\pisser.ini', data);
	if not doesDirectoryExist(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser") and data.options.screenshot == 1 then createDirectory(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser") end
end
function pissscreen(screennick)
	if data.options.screenshot == 1 then
		mem.setint8(sampGetBase() + 0x119CBC, 1)
		wait(300)
		stroka, prefix, screencolor, asdcolor = sampGetChatString(99)
		if string.find(stroka, 'sa-mp', 1, true) or string.find(stroka, 'taken', 1, true) then
			f1 = string.find(stroka, "sa", 1)
			f2 = string.find(stroka, "g", 1)
			screennomer = string.sub(stroka, f1, f2)
			local infile = io.open(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/"..screennomer, "rb")
			local data1 = infile:read("*a")
			infile:close()
			local outfile = io.open(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser/"..screennick.."-"..os.date("%y").."."..os.date("%m").."."..os.date("%d").."-"..os.date("%H").."-"..os.date("%M").."-"..os.date("%S")..".png", "wb")
			outfile:write(data1)
			outfile:close()
		end
	end
end
function onload()
	data = LIP.load('moonloader\\config\\pisser.ini');
	for i = 1, #data.blacklist do
		if data.blacklist[i] ~= nil then data.blacklist[i] = string.upper(data.blacklist[i]) end
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	sampRegisterChatCommand("pissadd", cmdPissAdd)
	sampRegisterChatCommand("pissdel", cmdPissDel)
	sampRegisterChatCommand("pissnot", cmdPissInform)
	sampRegisterChatCommand("pisser", cmdPissMenu)
	sampRegisterChatCommand("pisshotkey", cmdPissHotKey)
	sampRegisterChatCommand("pisslist", cmdPissList)
	sampRegisterChatCommand("pisslog", changelog)
	sampRegisterChatCommand("pissscreen", cmdPissScreen)
	if data.options.startmessage == 1 and sampGetCurrentServerAddress() ~= '91.134.210.2' and sampGetCurrentServerAddress() ~= '91.134.210.1' then sampAddChatMessage(('Обыссыватель запущен. v '..thisScript().version), 0x348cb2) end
	if data.options.startmessage == 1 and sampGetCurrentServerAddress() ~= '91.134.210.2' and sampGetCurrentServerAddress() ~= '91.134.210.1' then sampAddChatMessage(('Подробнее - /pisser. Отключить это сообщение - /pissnot'), 0x348cb2) end
end
function whatkeyid(checkkeyid)
	local keyids = {
		["A"] = 65,
		["B"] = 66,
		["C"] = 67,
		["D"] = 68,
		["E"] = 69,
		["F"] = 70,
		["G"] = 71,
		["H"] = 72,
		["I"] = 73,
		["J"] = 74,
		["K"] = 75,
		["L"] = 76,
		["M"] = 77,
		["N"] = 78,
		["O"] = 79,
		["P"] = 80,
		["Q"] = 81,
		["R"] = 82,
		["S"] = 83,
		["T"] = 84,
		["U"] = 85,
		["V"] = 86,
		["W"] = 87,
		["X"] = 88,
		["Y"] = 89,
		["Z"] = 90,
		["["] = 91,
		["]"] = 93,
	}
	return keyids[checkkeyid]
end
function whatidkey(checkkeyid)
	local keykey = {
		[65] = "A",
		[66] = "B",
		[67] = "C",
		[68] = "D",
		[69] = "E",
		[70] = "F",
		[71] = "G",
		[72] = "H",
		[73] = "I",
		[74] = "J",
		[75] = "K",
		[76] = "L",
		[77] = "M",
		[78] = "N",
		[79] = "O",
		[80] = "P",
		[81] = "Q",
		[82] = "R",
		[83] = "S",
		[84] = "T",
		[85] = "U",
		[86] = "V",
		[87] = "W",
		[88] = "X",
		[89] = "Y",
		[90] = "Z",
	}
	return keykey[checkkeyid]
end
function cmdPissMenu()
	sampShowDialog(2342, "{ffbf00}Обыссыватель. Автор: James_Bond/rubbishman/Coulson.", "{ffcc00}Для чего этот скрипт?\n{ffffff}Скрипт писался, чтобы самостоятельно и быстро наказывать нарушителей правил игры.\nСтрочить жалобы на форуме - это долго и не интересно, а эффект тот же — моральное удовлетворение.\n{ffcc00}Против кого мне его применять?\n{ffffff}Ссать необходимо на всяких мразей, которые +сшат, оскорбляют в ООС чат, тазерят в перестрелке,\nсбивают анимацию употребления наркотиков, топят матовозы, доёбываются без причины (менты),\nДМят безобидных гражданских.\nСсыте на токсичных ублюдков, и дай Бог вам здоровья.\n{FF0000}Не нужно пробовать ссать на автора скрипта.\n{ffcc00}Как мне обоссать игрока?\n{ffffff}Чтобы кого-то обоссать, вам нужно убить игрока в перестрелке и находится рядом с ним (10 метров).\nВам нужно подбежать к трупу и нажать горячую клавишу. Текущая клавиша - {00ccff}"..data.options.hotkey.."\n{ffffff}Если активирован /pissscreen, то будет создан скриншот в отдельной папке.\n{ffcc00}Доступные команды:\n    {00ccff}/pisser {ffffff}- это окно\n    {00ccff}/pisslog {ffffff}- changelog скрипта\n    {00ccff}/pisshotkey {ffffff}- изменить горячую клавишу\n   {00ccff} /pissnot{ffffff} - включить/выключить сообщение при входе в игруу\n   {00ccff} /pissscreen{ffffff} - включить/выключить скрин при обыссывании\n{ffcc00}Реализован чёрный список обыссывателя, чтобы случайно не обоссать товарища или админа.\n   {00ccff}/pisslist {ffffff}- чёрный список обыссывателя (в чат)\n   {00ccff}/pissadd [NICK_NAME] {ffffff}- добавить ник в чёрный список обыссывателя\n   {00ccff}/pissdel [NICK_NAME] {ffffff}- удалить ник из чёрного списка обыссывателя\n", "Лады")
end
function checkversion()
	goplay = 0
	local fpath = os.getenv('TEMP') .. '\\pisser-version.json'
	downloadUrlToFile('http://rubbishman.ru/dev/samp/pisser/version.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
		local f = io.open(fpath, 'r')
		if f then
			local info = decodeJson(f:read('*a'))
			updatelink = info.updateurl
			if info and info.latest then
				version = tonumber(info.latest)
				if version > tonumber(thisScript().version) then
					sampAddChatMessage(('[PISSER]: Обнаружено обновление. AutoReload может конфликтовать. Обновляюсь..'), 0x348cb2)
					sampAddChatMessage(('[PISSER]: Текущая версия: '..thisScript().version..". Новая версия: "..version), 0x348cb2)
					goplay = 2
					lua_thread.create(goupdate)
				end
			end
		end
	end
end)
wait(1000)
if goplay ~= 2 then goplay = 1 end
end
function goupdate()
wait(300)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
	if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
	sampAddChatMessage(('[PISSER]: Обновление завершено! Подробнее об обновлении - /pisslog.'), 0x348cb2)
	goplay = 1
	thisScript():reload()
end
end)
end
function changelog()
sampShowDialog(2342, "{ffbf00}PISSER: История версий.", "{ffcc00}v1.8 [26.10.17]\n{ffffff}Исправлен баг с {00ccff}/pisslist.\n{ffffff}Исправлено копирование скрина на стандартной гта.\n{ffcc00}v1.5 [26.10.17]\n{ffffff}Теперь при обыссывании создается скрин.\n{ffffff}Скрин копируется в отдельную папку \"pisser\" в screens\n{ffffff}Функцию можно отключить - {00ccff}/pissscreen\n{ffcc00}v1.4 [23.10.17]\n{ffffff}Немного увеличена задержка при обыссывании.\n{00ccff}/pisslog заменил {00ccff}/pissupdate.\nУдалён стилер.{ffcc00}\nv1.3 [22.10.17]\n{ffffff}Исправлен флуд идом в чат при прицеливании.\n{ffcc00}v1.2 [22.10.17]\n{ffffff}Добавлено автообновление.\nИзменён цвет уведомлений.\nКуча мелких доработок.\n{ffcc00}v1.1 [21.10.17]\n{ffffff}Исправлен баг, связанный с NPC.\n{ffcc00}v1.0 [21.10.17]\n{ffffff}Первый релиз скрипта.\nИсправлено множество недоработок.", "Закрыть")
end
