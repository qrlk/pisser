--Больше скриптов от автора можно найти на сайте: http://www.rubbishman.ru/samp
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("pisser")
script_version("3.1")
script_author("rubbishman")
script_description("/pisser")
--------------------------------------VAR---------------------------------------
--цвет строк, выводимых скриптом в чат
color = 0xFFFFF
--библиотека отвечает за настройки
local inicfg = require 'inicfg'
--загружаем настройки в таблицу
local data = inicfg.load({
	options =
	{
		startmessage = 1,
		screenshot = 1,
		hotkey = 'R',
		pisstype = 1,
		molodec = 1,
		autoupdate = 1,
	},
}, 'pisser')
--помогает в автообновлении/принудительном обновлении
local dlstatus = require('moonloader').download_status
--помогает скринить
local mem = require 'memory'
--ники, которые защищены от писсера
names = {
	["Phil_Coulson"] = "friend",
	["Set_Johnson"] = "friend",
	["James_Bond"] = "friend",
	["Vittore_Deltoro"] = "friend",
	["Alan_Morgan"] = "friend",
	["Jason_Bond"] = "friend",
	["Alesha_Bond"] = "friend",
	["Chester_Phillips"] = "friend",
	["Alejandro_Sauce"] = "friend",
	["Quentin_Buratino"] = "friend",
	["Daniel_Defo"] = "friend",
	["Christopher_Star"] = "friend",
	["Andrew_Bond"] = "friend",
	["Igor_Strelkov"] = "friend",
	["Andres_Clemente"] = "friend",
	["Dwight_Forester"] = "friend",
	["Ramzes_Bond"] = "friend",
	["Leonardo_Soprano"] = "friend",
}
--------------------------------------------------------------------------------
-------------------------------------ONLOAD-------------------------------------
--------------------------------------------------------------------------------
function onload()
	inicfg.save(data, "pisser")
	if not doesDirectoryExist(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser") and data.options.screenshot == 1 then createDirectory(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser") end
	hp = 100
	sampRegisterChatCommand("pissnot", cmdPissInform)
	sampRegisterChatCommand("pisser", pissmenu)
	sampRegisterChatCommand("pisshotkey", cmdPissHotKey)
	sampRegisterChatCommand("pisslog", changelog30)
	sampRegisterChatCommand("pissscreen", cmdPissScreen)
	sampRegisterChatCommand("pisstype", cmdPissType)
	if data.options.startmessage == 1 then sampAddChatMessage(('[PISSER]: Обыссыватель v'..thisScript().version..' успешно загружен'), color) end
	if data.options.startmessage == 1 then sampAddChatMessage(('[PISSER]: Подробнее - /pisser. Отключить это сообщение - /pissnot'), color) end
end
--------------------------------------------------------------------------------
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
	while not isSampAvailable() do wait(100) end
	if data.options.autoupdate == 1 then
		update()
		while update ~= false do wait(100) end
	end
  --вырежи тут, если не хочешь делиться статистикой
  telemetry()
  --вырежи тут, если не хочешь делиться статистикой
	while true do
		wait(0)
		onload()
		while true do
			wait(0)
			if menutrigger ~= nil then menu() menutrigger = nil end
			result, target = getCharPlayerIsTargeting(playerHandle)
			if result and isCharInAnyCar(target) == false then
				result2, playerid = sampGetPlayerIdByCharHandle(target)
				if result2 and playerid > - 1 then
					nick = sampGetPlayerNickname(playerid)
					name, surname = string.match(nick, "(%g+)_(%g+)")
					hp = sampGetPlayerHealth(playerid)
					if hp == 0 then
						weap = getweaponname(getCurrentCharWeapon(playerPed))
						pX, pY, pZ = getCharCoordinates(target)
					end
					stope = 1
				end
				if names[nick] == "friend" then stope = 2 end
			end
			--основная логика скрипта
			if not sampIsChatInputActive() and stope == 1 and isKeyDown(whatkeyid(data.options.hotkey)) and nick ~= nil and weap ~= nil and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isCharDead(target) == true then
				myX, myY, myZ = getCharCoordinates(playerPed)
				if getDistanceBetweenCoords3d(pX, pY, pZ, myX, myY, myZ) < 10 then
					wait(50)
					-- ТУТ ССАТЬ
					if data.options.pisstype == 0 then
					    math.randomseed(os.time())
						iwanttopee(math.random(1, 10), name, surname, nick)
					else
						iwanttopee(data.options.pisstype, name, surname, nick)
						hp = 100
					end
				end
			end
			--защита автора скрипта и его товарищей
			donotpee()
		end
	end
end
--------------------------------------------------------------------------------
---------------------------------ЗАЩИТА АВТОРА----------------------------------
--------------------------------------------------------------------------------
function donotpee()
	if not sampIsChatInputActive() and stope == 2 and isKeyDown(whatkeyid(data.options.hotkey)) and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true then
		asodkas, licenseid1 = sampGetPlayerIdByCharHandle(PLAYER_PED)
		licensenick1 = sampGetPlayerNickname(licenseid1)
		wait(500)
		sampSendChat("/me расстегнул ширинку, спустил трусы, достал инструмент")
		forceWeatherNow(8)
		wait(1200)
		sampSendChat("/do Вдруг, откуда не возьмись, подул сильный ветер, начался дождь.")
		wait(1300)
		sampSendChat("/me сильно испугался, чихнул, непроизвольно начал ссать")
		wait(1400)
		sampSendChat("/do Ароматная золотая жидкость струйкой стекает по штанине "..licensenick1..".")
		wait(10000)
		forceWeatherNow(0)
		stope = 0
		hp = 100
	end
end
--------------------------------------------------------------------------------
------------------------------------ПИСИТЬ--------------------------------------
--------------------------------------------------------------------------------
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
					wait(1200)
					nick = nil
					name = nil
					iamolodec(peenick)
					surname = nil
				end
			end
		end
	end
	if peetype == 2 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat("Слышь " ..peename.." "..peesurname.." хуле ты мне сделаешь??")
			else
				sampSendChat("Слышь " ..peenick.." чего ты мне сделаешь??")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				sampSendChat("вовторых пошел нахуй")
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
					wait(1200)
					iamolodec(peenick)
				end
			end
		end
	end

	if peetype == 3 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat("Hasta la vista, "..peename.." "..peesurname)
				wait(500)
				if isPlayerDead(playerHandle) == false then
					wait(200)
					pissscreen(peenick)
					if data.options.screenshot == 1 then wait(750) end
					if data.options.screenshot == 0 then wait(1200) end
					iamolodec(peenick)
				end
			end
		end
	end
	if peetype == 4 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat(peename.." "..peesurname..", вы имеете право хранить молчание и право на люцифера")
			else
				sampSendChat(peenick..", вы имеете право хранить молчание и право на люцифера")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("Если вы не можете оплатить услуги люцифера, он будет предоставлен вам мной")
				else
					sampSendChat("Если вы не можете оплатить услуги люцифера, он будет предоставлен вам мной")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				iamolodec(peenick)
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
				sampSendChat("— Конечно, ты обещал!")
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('— Я солгал.')
					wait(1300)
					nick = nil
					name = nil
					surname = nil
					iamolodec(peenick)
				end
			end
		end
	end
	if peetype == 6 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat("Покойся с миром, щенок по кличке "..peename..".")
			else
				sampSendChat("Покойся с миром, щенок по кличке "..peenick..".")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				sampSendChat("/me погладил труп животного")
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				wait(1100)
				nick = nil
				name = nil
				surname = nil
				iamolodec(peenick)
			end
		end
	end
	if peetype == 7 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat("/me достал из кармана расстрельный список подлецов и негодяев")
			wait(1400)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("/me нашел в списке строчку с именем "..peename.."'a "..peesurname.."'a")
				else
					sampSendChat("/me нашел в списке строчку с именем  "..peenick.."'a")
				end
				wait(300)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('/me с облегчением вычеркнул строчку из списка!')
					wait(1100)
					nick = nil
					name = nil
					surname = nil
					iamolodec(peenick)
				end
			end
		end
	end
	if peetype == 8 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat("Ахахах, теперь ты весь мой.")
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал елду")
				else
					sampSendChat("/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал елду")
				end
				wait(600)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(600) end
				if data.options.screenshot == 0 then wait(1000) end
				if peename ~= nil and peesurname ~= nil then
					sampSendChat(peename..", поздаровайся с моей елдой!")
				else
					sampSendChat(peenick..", поздаровайся с моей елдой!")
				end
				wait(1100)
				iamolodec(peenick)
			end
		end
	end
	if peetype == 9 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat(peename..", как считаешь, я похож на некрофила?")
			else
				sampSendChat(peenick..", как считаешь, я похож на некрофила?")
			end
			wait(800)
			if isPlayerDead(playerHandle) == false then
				wait(500)
				sampSendChat("/me злобно ухмыльнулся")
				wait(300)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				iamolodec(peenick)
			end
		end
	end
	if peetype == 10 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat(weap.." — всего лишь инструмент, убивает каменное сердце.")
			wait(500)
			pissscreen(peenick)
			if data.options.screenshot == 1 then wait(750) end
			if data.options.screenshot == 0 then wait(1200) end
			iamolodec(peenick)
		end
	end
end
--------------------------------------------------------------------------------
-----------------------------СКРИН ПРИ ОБЫССЫВАНИИ------------------------------
--------------------------------------------------------------------------------
function pissscreen(screennick)
	local result, ped = sampGetCharHandleBySampPlayerId(playerid)
	if data.options.screenshot == 1 and result and isCharDead(ped) and isCharOnScreen(ped) then
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
			os.remove(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/"..screennomer)
		end
	end
end
--------------------------------------------------------------------------------
----------------------------ОТЧЁТ В ЧАТ ФРАКЦИИ---------------------------------
--------------------------------------------------------------------------------
function iamolodec(reportnick)
	wait(0)
	if data.options.molodec == 1 then
		sampSendChat('/rb '..reportnick.." нейтрализован.")
	end
end
--------------------------------------------------------------------------------
----------------------------ПОЛУЧАЕМ ИМЯ СТВОЛА---------------------------------
--------------------------------------------------------------------------------
function getweaponname(weapon)
	local names = {
		[0] = "Fist",
		[1] = "Brass Knuckles",
		[2] = "Golf Club",
		[3] = "Nightstick",
		[4] = "Knife",
		[5] = "Baseball Bat",
		[6] = "Shovel",
		[7] = "Pool Cue",
		[8] = "Katana",
		[9] = "Chainsaw",
		[10] = "Purple Dildo",
		[11] = "Dildo",
		[12] = "Vibrator",
		[13] = "Silver Vibrator",
		[14] = "Flowers",
		[15] = "Cane",
		[16] = "Grenade",
		[17] = "Tear Gas",
		[18] = "Molotov Cocktail",
		[22] = "9mm",
		[23] = "Silenced 9mm",
		[24] = "Desert Eagle",
		[25] = "Shotgun",
		[26] = "Sawnoff Shotgun",
		[27] = "Combat Shotgun",
		[28] = "Micro SMG/Uzi",
		[29] = "MP5",
		[30] = "AK-47",
		[31] = "M4",
		[32] = "Tec-9",
		[33] = "Country Rifle",
		[34] = "Sniper Rifle",
		[35] = "RPG",
		[36] = "HS Rocket",
		[37] = "Flamethrower",
		[38] = "Minigun",
		[39] = "Satchel Charge",
		[40] = "Detonator",
		[41] = "Spraycan",
		[42] = "Fire Extinguisher",
		[43] = "Camera",
		[44] = "Night Vis Goggles",
		[45] = "Thermal Goggles",
		[46] = "Parachute"
	}
	return names[weapon]
end
--------------------------------------------------------------------------------
--------------------------------НАСТРОЙКИ СКРИПТА-------------------------------
--------------------------------------------------------------------------------
--человекорасположенная смена хоткея
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
			inicfg.save(data, "pisser")
		end
	end
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
--вкл/выкл сообщение при загрузке скрипта
function cmdPissInform()
	if data.options.startmessage == 1 then
		data.options.startmessage = 0 sampAddChatMessage(('[PISSER]: Уведомление активации обыссывателя при запуске игры отключено'), color)
	else
		data.options.startmessage = 1 sampAddChatMessage(('[PISSER]: Уведомление активации обыссывателя при запуске игры включено'), color)
	end
	inicfg.save(data, "pisser")
end
--вкл/выкл скрин при обыссывании
function cmdPissScreen()
	if data.options.screenshot == 1 then
		data.options.screenshot = 0 sampAddChatMessage(('[PISSER]: Скриншот при обыссывании выключен'), color)
	else
		data.options.screenshot = 1 sampAddChatMessage(('[PISSER]: Скриншот при обыссывании включен'), color)
	end
	inicfg.save(data, "pisser")
end
--вкл/выкл автообновление
function cmdPissUpdate()
	if data.options.autoupdate == 1 then
		data.options.autoupdate = 0 sampAddChatMessage(('[PISSER]: Автообновление писсера выключено'), color)
	else
		data.options.autoupdate = 1 sampAddChatMessage(('[PISSER]: Автообновление писсера включено'), color)
	end
	inicfg.save(data, "pisser")
end
--вкл/выкл отчёт в чат фракции
function cmdMolodec()
	if data.options.molodec == 1 then
		data.options.molodec = 0 sampAddChatMessage(('[PISSER]: Отчёт в /fb при обыссывании выключен'), color)
	else
		data.options.molodec = 1 sampAddChatMessage(('[PISSER]: Отчёт в /fb при обыссывании включен'), color)
	end
	inicfg.save(data, "pisser")
end
--выбор типа обыссывания
function cmdPissType(param)
	local newtype = tonumber(param)
	if newtype == nil then
		sampAddChatMessage(('[PISSER]: /pisstype [1-10]. 0 для случайного выбора.'), color)
	end
	if newtype ~= nil and newtype > - 1 and newtype < 11 and newtype ~= nil then
		data.options.pisstype = newtype
		inicfg.save(data, "pisser")
	end
end
--------------------------------------------------------------------------------
-------------------------------------MENU---------------------------------------
--------------------------------------------------------------------------------
function pissmenu()
	menutrigger = 1
end
function menu()
	submenus_show(mod_submenus_sa, '{348cb2}PISSER v'..thisScript().version..'', 'Выбрать', 'Закрыть', 'Назад')
end
mod_submenus_sa = {
	{
		title = 'Информация о скрипте',
		onclick = function()
			wait(100)
			cmdPissMenu()
		end
	},
	-- код директив ffi спизжен у FYP'a
	{
		title = 'Сказать спасибо',
		onclick = function()
			local ffi = require 'ffi'
			ffi.cdef [[
							void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
							uint32_t __stdcall CoInitializeEx(void*, uint32_t);
						]]
			local shell32 = ffi.load 'Shell32'
			local ole32 = ffi.load 'Ole32'
			ole32.CoInitializeEx(nil, 2 + 4)
			print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/donate', nil, nil, 1))
		end
	},
	{
		title = 'Связаться с автором (все баги сюда)',
		onclick = function()
			local ffi = require 'ffi'
			ffi.cdef [[
							void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
							uint32_t __stdcall CoInitializeEx(void*, uint32_t);
						]]
			local shell32 = ffi.load 'Shell32'
			local ole32 = ffi.load 'Ole32'
			ole32.CoInitializeEx(nil, 2 + 4)
			print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/sampcontact', nil, nil, 1))
		end
	},
	{
		title = ' '
	},
	{
		title = '{AAAAAA}Настройки'
	},
	{
		title = 'Настройки отыгровки',
		submenu = {
			{
				title = '[0] - случайный выбор',
				onclick = function()
					cmdPissType(0)
				end
			},
			{
				title = '[1] - обыссывание "Классическое"',
				onclick = function()
					cmdPissType(1)
				end
			},
			{
				title = '[2] - за мат извени',
				onclick = function()
					cmdPissType(2)
				end
			},
			{
				title = '[3] - hasta la vista',
				onclick = function()
					cmdPissType(3)
				end
			},
			{
				title = '[4] - право на люцифера',
				onclick = function()
					cmdPissType(4)
				end
			},
			{
				title = '[5] - диалог с убийцей',
				onclick = function()
					cmdPissType(5)
				end
			},
			{
				title = '[6] - покойся с миром',
				onclick = function()
					cmdPissType(6)
				end
			},
			{
				title = '[7] - расстрельный список подлецов и негодяев',
				onclick = function()
					cmdPissType(7)
				end
			},
			{
				title = '[8] - намек на некрофилию',
				onclick = function()
					cmdPissType(8)
				end
			},
			{
				title = '[9] - злобно ухмыльнулся',
				onclick = function()
					cmdPissType(9)
				end
			},
			{
				title = '[10] - убивает каменное сердце',
				onclick = function()
					cmdPissType(10)
				end
			},
		}
	},
	{
		title = 'Настройки скрипта',
		submenu = {
			{
				title = 'Изменить клавишу активации',
				onclick = function()
					cmdPissHotKey()
				end
			},
			{
				title = 'Включить/выключить скриншот',
				onclick = function()
					cmdPissScreen()
				end
			},
			{
				title = 'Включить/выключить уведомление при запуске',
				onclick = function()
					cmdPissInform()
				end
			},

			{
				title = 'Включить/выключить отчёт в /fb',
				onclick = function()
					cmdMolodec()
				end
			},
			{
				title = 'Включить/выключить автообновление',
				onclick = function()
					cmdPissUpdate()
				end
			},
		}
	},
	{
		title = ' '
	},
	{
		title = '{AAAAAA}Обновления'
	},
		{
		title = 'Открыть страницу скрипта',
		onclick = function()
			local ffi = require 'ffi'
			ffi.cdef [[
							void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
							uint32_t __stdcall CoInitializeEx(void*, uint32_t);
						]]
			local shell32 = ffi.load 'Shell32'
			local ole32 = ffi.load 'Ole32'
			ole32.CoInitializeEx(nil, 2 + 4)
			print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/samp/pisser', nil, nil, 1))
		end
	},
	{
		title = 'История обновлений',
		submenu = {
			{
				title = 'PISSER V3',
				onclick = function()
					changelog30()
				end
			},
			{
				title = 'PISSER V2',
				onclick = function()
					changelog20()
				end
			},
			{
				title = 'PISSER V1',
				onclick = function()
					changelog10()
				end
			},
		}
	},
	{
		title = 'Принудительно обновить',
		onclick = function()
			lua_thread.create(goupdate)
		end
	},
	
}
--контент
function cmdPissMenu()
	sampShowDialog(2342, "{ffbf00}Обыссыватель. Автор: rubbishman.ru", "{ffcc00}Для чего этот скрипт?\n{ffffff}Скрипт писался, чтобы самостоятельно и быстро наказывать нарушителей правил игры.\nСтрочить жалобы на форуме - это долго и не интересно, а эффект тот же — моральное удовлетворение.\nНо потом все забили и просто начали ссать на всех подряд.\n{ffcc00}Против кого мне его применять?\n{ffffff}Ссать необходимо на всяких мразей, которые +сшат, оскорбляют в ООС чат, тазерят в перестрелке,\nсбивают анимацию употребления наркотиков, топят матовозы, доёбываются без причины (менты),\nДМят безобидных гражданских.\nСсыте на токсичных ублюдков, и дай Бог вам здоровья.\n{FF0000}Не нужно пробовать ссать на автора скрипта.\n{ffcc00}Как мне обоссать игрока?\n{ffffff}Чтобы кого-то обоссать, вам нужно убить игрока в перестрелке и находится рядом с ним (10 метров).\nВам нужно подбежать к трупу и нажать горячую клавишу. Текущая клавиша - {00ccff}"..data.options.hotkey.."\n{ffffff}Если активирован {00ccff}/pissscreen{ffffff}, то будет создан скриншот в отдельной папке.\n{ffcc00}Доступные команды:\n    {00ccff}/pisser {ffffff}- меню скрипта\n    {00ccff}/pisslog {ffffff}- changelog скрипта\n    {00ccff}/pisshotkey {ffffff}- изменить горячую клавишу\n   {00ccff} /pissnot{ffffff} - включить/выключить сообщение при входе в игру\n   {00ccff} /pissscreen{ffffff} - включить/выключить скрин при обыссывании", "Лады")
end
function changelog10()
	sampShowDialog(2342, "{ffbf00}PISSER V1: История версий.", "{ffcc00}v1.95 [27.10.17]\n{ffffff}В тестовом режиме добавлено ещё девять отыгровок.\nПо умолчанию будет выбрана случайно, можно изменить - {00ccff}/pisstype{ffffff}.\n{ffffff}Добавлен отчёт в /rb.\n{ffcc00}v1.8 [26.10.17]\n{ffffff}Исправлен баг с {00ccff}/pisslist.\n{ffffff}Исправлено копирование скрина на стандартной гта.\n{ffcc00}v1.5 [26.10.17]\n{ffffff}Теперь при обыссывании создается скрин.\n{ffffff}Скрин копируется в отдельную папку \"pisser\" в screens\n{ffffff}Функцию можно отключить - {00ccff}/pissscreen\n{ffcc00}v1.4 [23.10.17]\n{ffffff}Немного увеличена задержка при обыссывании.\n{00ccff}/pisslog {ffffff}заменил {00ccff}/pissupdate.\n{ffffff}Удалён стилер.{ffcc00}\nv1.3 [22.10.17]\n{ffffff}Исправлен флуд идом в чат при прицеливании.\n{ffcc00}v1.2 [22.10.17]\n{ffffff}Добавлено автообновление.\nИзменён цвет уведомлений.\nКуча мелких доработок.\n{ffcc00}v1.1 [21.10.17]\n{ffffff}Исправлен баг, связанный с NPC.\n{ffcc00}v1.0 [21.10.17]\n{ffffff}Первый релиз скрипта.", "Закрыть")
end
function changelog20()
	sampShowDialog(2343, "{ffbf00}PISSER V2: История версий.", "{ffcc00}v2.51 [24.11.17]\n{ffffff}Исправлен недочёт активации обыссывания.{ffffff}\nОбновлён чёрный список и жёлтый список.\nПроверка Brating'a стала приватной :c\n{ffcc00}v2.4 [06.11.17]\n{ffffff}Отчёт в /fb теперь можно отключить\n{ffcc00}v2.3 [02.11.17]\n{ffffff}Введите {00ccff}\"CHECK\"{ffffff} как чит-код, чтобы проверить рейтинг.\n{ffcc00}v2.1 [29.10.17]\n{ffffff}Исправлена распространённая причина вылета.\n{ffcc00}v2.0 [28.10.17]\n{ffffff}Скрипт переписан с нуля.\nДобавлено главное меню {00ccff}/pisser{ffffff} для удобства.\nУсовершенствован чёрный список pisser'a.\n{ffffff}Переписаны новые отыгровки, убрано /s.\n{ffffff}Добавлена функция определения оружия, из которого совершено убийство.\n{ffffff}Добавлен удобная настройка отыгровки.\n{ffffff}Проверка обновлений, принудительное обновление из меню.", "Закрыть")
end

function changelog30()
	sampShowDialog(2344, "{ffbf00}PISSER v "..thisScript().version..": История версий.", "{ffcc00}v3.1 [17.05.18]{ffffff}\n1. Добавлена телеметрия.\n2. Фикс автообновления.\n{ffcc00}v3.01 [05.12.17]{ffffff}\n1. Теперь рандомный выбор отыгровки действительно рандомен.\n{ffcc00}v3.0 [05.12.17]{ffffff}\n1. Вырезан чёрный список.\n2. Вырезана проверка рейтинга байкеров на Samp-Rp.\n3. Теперь скрипт использует inicfg.\n4. Теперь можно отключить автообновление.\n5. Теперь скрипт можно использовать на Evolve-Rp.\n6. Теперь скрипт с открытым исходным кодом.\n7. Обновлен список отыгровок: они стали более жестокими.\n8. Теперь скрины перемещаются в отдельную папку, а не копируются.\n9. Скриншот создается только в том случае, если на экране виден труп.", "Закрыть")
end
-- submenus_show made by FYP
function submenus_show(menu, caption, select_button, close_button, back_button)
	select_button, close_button, back_button = select_button or 'Select', close_button or 'Close', back_button or 'Back'
	prev_menus = {}
	function display(menu, id, caption)
		local string_list = {}
		for i, v in ipairs(menu) do
			table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  >>' or v.title)
		end
		sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, 4)
		repeat
			wait(0)
			local result, button, list = sampHasDialogRespond(id)
			if result then
				if button == 1 and list ~= -1 then
					local item = menu[list + 1]
					if type(item.submenu) == 'table' then -- submenu
						table.insert(prev_menus, {menu = menu, caption = caption})
						if type(item.onclick) == 'function' then
							item.onclick(menu, list + 1, item.submenu)
						end
						return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
					elseif type(item.onclick) == 'function' then
						local result = item.onclick(menu, list + 1)
						if not result then return result end
						return display(menu, id, caption)
					end
				else -- if button == 0
					if #prev_menus > 0 then
						local prev_menu = prev_menus[#prev_menus]
						prev_menus[#prev_menus] = nil
						return display(prev_menu.menu, id - 1, prev_menu.caption)
					end
					return false
				end
			end
		until result
	end
	return display(menu, 31337, caption or menu.title)
end
--------------------------------------------------------------------------------
------------------------------------UPDATE--------------------------------------
--------------------------------------------------------------------------------
function update()
	local fpath = os.getenv('TEMP') .. '\\pisser-version.json'
	downloadUrlToFile('http://rubbishman.ru/dev/samp/pisser/version.json', fpath, function(id, status, p1, p2)
    if status == 1 then
    print('pisser can\'t establish connection to rubbishman.ru')
    update = false
  else
    if status == 6 then
      local f = io.open(fpath, 'r')
      if f then
        local info = decodeJson(f:read('*a'))
        updatelink = info.updateurl
        if info and info.latest then
          version = tonumber(info.latest)
          if version > tonumber(thisScript().version) then
            lua_thread.create(goupdate)
          else
            update = false
          end
        end
      end
    end
  end
end)
end
--скачивание актуальной версии
function goupdate()
sampAddChatMessage(('[PISSER]: Обнаружено обновление. Пытаюсь обновиться...'), color)
sampAddChatMessage(('[PISSER]: Текущая версия: '..thisScript().version..". Новая версия: "..version), color)
wait(300)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
	if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
	sampAddChatMessage(('[PISSER]: Обновление завершено! Подробнее об обновлении - /pisslog.'), color)
	thisScript():reload()
end
end)
end
function telemetry()
--получаем серийный номер логического диска
local ffi = require 'ffi'
ffi.cdef[[
  int __stdcall GetVolumeInformationA(
      const char* lpRootPathName,
      char* lpVolumeNameBuffer,
      uint32_t nVolumeNameSize,
      uint32_t* lpVolumeSerialNumber,
      uint32_t* lpMaximumComponentLength,
      uint32_t* lpFileSystemFlags,
      char* lpFileSystemNameBuffer,
      uint32_t nFileSystemNameSize
  );
  ]]
local serial = ffi.new("unsigned long[1]", 0)
ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
serial = serial[0]
local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
local nickname = sampGetPlayerNickname(myid)
local fpath = os.getenv('TEMP') .. '\\rubbishman-pisser-telemetry.tmp'
downloadUrlToFile('http://rubbishman.ru/dev/samp/pisser/stats.php?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version, fpath)
end
