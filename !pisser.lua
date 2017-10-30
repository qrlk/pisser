script_name("pisser")
script_version("2.23")
script_author("James_Bond/rubbishman/Coulson")
script_description("/pisser")
local mod_submenus_sa = {
	{
		title = 'Информация о скрипте',
		onclick = function()
			wait(100)
			cmdPissMenu()
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
		title = 'Настройки чёрного списка',
		submenu = {
			{
				title = 'Чёрный список в чат',
				onclick = function()
					cmdPissList()
				end
			},
			{
				title = 'Добавить ник в чёрный список',
				onclick = function()
					cmdPissAdd(228966)
				end
			},
			{
				title = 'Удалить ник из чёрного списка',
				onclick = function()
					cmdPissDel(228966)
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
		}
	},
	{
		title = ' '
	},
	{
		title = '{AAAAAA}Обновления'
	},
	{
		title = 'История обновлений',
		submenu = {
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
		title = 'Проверить обновление',
		onclick = function()
			wait(100)
			checkversion()
			if goplay == 1 then sampAddChatMessage(('[PISSER]: Обновление не обнаружено!'), 0x8B0000)
			end
		end
	},
	{
		title = 'Принудительно обновить',
		onclick = function()
			lua_thread.create(goupdate)
		end
	},
}
local LIP = {};

local dlstatus = require('moonloader').download_status
local mem = require 'memory'
local sf = require "sampfuncs"
function main()
	while not isSampAvailable() do wait(100) end
	lua_thread.create(checkversion)
--	lua_thread.create(bratinger)
--	lua_thread.create(brating)
	while goplay == 0 or goplay == 2 do wait(2000) end
	while true do
		wait(0)
		firstload()
		onload()
		while true do
			wait(0)
			if menutrigger ~= nil then menu() menutrigger = nil end
			if sampGetCurrentServerAddress() == '91.134.210.2' or sampGetCurrentServerAddress() == '91.134.210.1' then sampAddChatMessage(('[ERROR]: У тебя мочи не хватит для этого сервера.'), 0xFE1312)
				if cegj > 0 then end
			else
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
					if nick ~= nil then
						for i = 1, #data.blacklist do
							if data.blacklist[i] == string.upper(nick) then stope = 0 end
						end
					end
					if nick == "James_Bond" or nick == "Phil_Coulson" or nick == "Vittore_Deltoro" or nick == "Set_Johnson" or nick == "Riley_Reid" or nick == "Neax_Wayne" or nick == "Mike_Rein" or nick == "Alex_Rein" or nick == "Francesco_Garsia" then stope = 2 end
				end
				--основная логика скрипта
				if not sampIsChatInputActive() and stope == 1 and isKeyDown(whatkeyid(data.options.hotkey)) and nick ~= nil and weap ~= nil and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true then
					myX, myY, myZ = getCharCoordinates(playerPed)
					if getDistanceBetweenCoords3d(pX, pY, pZ, myX, myY, myZ) < 10 then
						wait(100)
						-- ТУТ ССАТЬ
						if data.options.pisstype == 0 then iwanttopee(math.random(1, 10), name, surname, nick) else iwanttopee(data.options.pisstype, name, surname, nick)
						hp = 100 end
					end
				end
				--защита автора скрипта
				donotpee()
			end
		end
	end
end


function donotpee()
	if not sampIsChatInputActive() and stope == 2 and isKeyDown(whatkeyid(data.options.hotkey)) and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true then
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
		hp = 100
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
						wait(1200)
						name = nil
						iamolodec(peenick)
						surname = nil
					end
				end
			end
		end
	end
	if peetype == 3 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat("Hasta la vista, "..peename.." "..peesurname)
				wait(1300)
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
				sampSendChat("— Конечно, Байкер, ты обещал!")
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
				sampSendChat("Покойся с миром, "..peename.." "..peesurname)
			else
				sampSendChat("Покойся с миром, "..peenick)
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				sampSendChat("/me погладил труп")
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
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("/me нашел в списке строчку с именем "..peename.."'a "..peesurname.."'a")
				else
					sampSendChat("/me нашел в списке строчку с именем  "..peenick.."'a")
				end
				wait(200)
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
					sampSendChat("/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал инструмент")
				else
					sampSendChat("/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал инструмент")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if peename ~= nil and peesurname ~= nil then
					sampSendChat(peename..", поздаровайся с моим маленьким другом")
				else
					sampSendChat(peenick..", поздаровайся с моим маленьким другом")
				end
				wait(1100)
				iamolodec(peenick)
			end
		end
	end
	if peetype == 9 then
		if isPlayerDead(playerHandle) == false then
			if peename ~= nil and peesurname ~= nil then
				sampSendChat(peename..", как считаешь, я похож на убийцу?")
			else
				sampSendChat(peenick..", как считаешь, я похож на убийцу?")
			end
			wait(200)
			if isPlayerDead(playerHandle) == false then
				wait(800)
				sampSendChat("/me злобно ухмыльнулся")
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
			wait(200)
			pissscreen(peenick)
			if data.options.screenshot == 1 then wait(750) end
			if data.options.screenshot == 0 then wait(1200) end
			iamolodec(peenick)
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
	local ifnil = tonumber(newFriend)
	if ifnil == nil and newFriend == nil then sampAddChatMessage(('Введите /pissadd NICK, чтобы добавить в чёрный список'), 0xFFFFFF) else
		if newFriend == 228966 then
			sampShowDialog(987, "Добавить в чёрный список", string.format("Введите ник"), "Выбрать", "Закрыть", 1)
			while sampIsDialogActive() do wait(100) end
			cmdPissAdd(sampGetCurrentDialogEditboxText(987))
		else
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
	end
end

function bratingscreen()
	wait(200)
	mem.setint8(sampGetBase() + 0x119CBC, 1)
	wait(300)
	stroka, prefix, screencolor, asdcolor = sampGetChatString(99)
	if not doesDirectoryExist(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/brating") then createDirectory(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/brating") end
	if string.find(stroka, 'sa-mp', 1, true) or string.find(stroka, 'taken', 1, true) then
		f1 = string.find(stroka, "sa", 1)
		f2 = string.find(stroka, "g", 1)
		screennomer = string.sub(stroka, f1, f2)
		local infile = io.open(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/"..screennomer, "rb")
		local data2 = infile:read("*a")
		infile:close()
		local outfile = io.open(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/brating/"..os.date("%y").."."..os.date("%m").."."..os.date("%d").." "..os.date("%H").."-"..os.date("%M").."-"..os.date("%S")..".png", "wb")
		outfile:write(data2)
		outfile:close()
	end
end

function bratinger()
	while true do
		--wait(math.random(7000, 18000))
		wait(math.random(700000, 1200000))
		checkbrating()
	end
end
function brating()
	if not doesDirectoryExist("moonloader\\config") then createDirectory("moonloader\\config") end
	if not doesFileExist("moonloader\\config\\brating.ini") then
		local brating =
		{
			stats =
			{
				mmc = 0,
				bmc = 0,
				omc = 0,
				amc = 0,
				time = "ne bilo",
			},
		};
		LIP.save('moonloader\\config\\brating.ini', brating)
		sampAddChatMessage(('Теперь мы отслеживаем /brating. Был создан .ini: moonloader\\config\\brating.ini'), 0x348cb2)
	end
	while true do
		wait(0)
		if isKeyDown(66) and not sampIsChatInputActive() then
			checkbrating()
		end
	end
end



function cmdPissDel(delFriend)
	local ifnil1 = tonumber(delFriend)
	if ifnil1 == nil and delFriend == nil then sampAddChatMessage(('Введите /pissadd NICK, чтобы удалить из чёрного списка'), 0xFFFFFF) else
		if delFriend == 228966 then
			sampShowDialog(988, "Удалить из чёрного списка", string.format("Введите ник"), "Выбрать", "Закрыть", 1)
			while sampIsDialogActive() do wait(100) end
			cmdPissDel(sampGetCurrentDialogEditboxText(988))
		else
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
	end
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
	hp = 100
	data = LIP.load('moonloader\\config\\pisser.ini');
	for i = 1, #data.blacklist do
		if data.blacklist[i] ~= nil then data.blacklist[i] = string.upper(data.blacklist[i]) end
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	sampRegisterChatCommand("pissadd", cmdPissAdd)
	sampRegisterChatCommand("pissdel", cmdPissDel)
	sampRegisterChatCommand("pissnot", cmdPissInform)
	sampRegisterChatCommand("pisser", pissmenu)
	sampRegisterChatCommand("pisshotkey", cmdPissHotKey)
	sampRegisterChatCommand("pisslist", cmdPissList)
	sampRegisterChatCommand("pisslog", changelog20)
	sampRegisterChatCommand("pissscreen", cmdPissScreen)
	sampRegisterChatCommand("pisstype", cmdPissType)
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


function iamolodec(reportnick)
	wait(0)
	sampSendChat('/rb '..reportnick.." нейтрализован.")
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
	sampShowDialog(2342, "{ffbf00}Обыссыватель. Автор: James_Bond/rubbishman/Coulson.", "{ffcc00}Для чего этот скрипт?\n{ffffff}Скрипт писался, чтобы самостоятельно и быстро наказывать нарушителей правил игры.\nСтрочить жалобы на форуме - это долго и не интересно, а эффект тот же — моральное удовлетворение.\n{ffcc00}Против кого мне его применять?\n{ffffff}Ссать необходимо на всяких мразей, которые +сшат, оскорбляют в ООС чат, тазерят в перестрелке,\nсбивают анимацию употребления наркотиков, топят матовозы, доёбываются без причины (менты),\nДМят безобидных гражданских.\nСсыте на токсичных ублюдков, и дай Бог вам здоровья.\n{FF0000}Не нужно пробовать ссать на автора скрипта.\n{ffcc00}Как мне обоссать игрока?\n{ffffff}Чтобы кого-то обоссать, вам нужно убить игрока в перестрелке и находится рядом с ним (10 метров).\nВам нужно подбежать к трупу и нажать горячую клавишу. Текущая клавиша - {00ccff}"..data.options.hotkey.."\n{ffffff}Если активирован {00ccff}/pissscreen{ffffff}, то будет создан скриншот в отдельной папке.\n{ffcc00}Доступные команды:\n    {00ccff}/pisser {ffffff}- меню скрипта\n    {00ccff}/pisslog {ffffff}- changelog скрипта\n    {00ccff}/pisshotkey {ffffff}- изменить горячую клавишу\n   {00ccff} /pissnot{ffffff} - включить/выключить сообщение при входе в игруу\n   {00ccff} /pissscreen{ffffff} - включить/выключить скрин при обыссывании\n{ffcc00}Реализован чёрный список обыссывателя, чтобы случайно не обоссать товарища или админа.\n   {00ccff}/pisslist {ffffff}- чёрный список обыссывателя (в чат)\n   {00ccff}/pissadd [NICK_NAME] {ffffff}- добавить ник в чёрный список обыссывателя\n   {00ccff}/pissdel [NICK_NAME] {ffffff}- удалить ник из чёрного списка обыссывателя\n", "Лады")
end

function changelog20()
	sampShowDialog(2342, "{ffbf00}PISSER V2: История версий.", "{ffcc00}v2.1 [29.10.17]\n{ffffff}Исправлена распространённая причина вылета.\n{ffcc00}v2.0 [28.10.17]\n{ffffff}Переписана логическая часть скрипта, повышена стабильность.\nДобавлено главное меню {00ccff}/pisser{ffffff} для удобства.\nУсовершенствован чёрный список pisser'a.\n{ffffff}Переписаны новые отыгровки, убрано /s.\n{ffffff}Добавлена функция определения оружия, из которого убил.\n{ffffff}Добавлен удобная настройка отыгровки.\n{ffffff}Проверка обновлений, принудительное обновление из меню.", "Закрыть")
end
function changelog10()
	sampShowDialog(2342, "{ffbf00}PISSER V1: История версий.", "{ffcc00}v1.95 [27.10.17]\n{ffffff}В тестовом режиме добавлено ещё девять отыгровок.\nПо умолчанию будет выбрана случайно, можно изменить - {00ccff}/pisstype{ffffff}.\n{ffffff}Добавлен отчёт в /rb.\n{ffcc00}v1.8 [26.10.17]\n{ffffff}Исправлен баг с {00ccff}/pisslist.\n{ffffff}Исправлено копирование скрина на стандартной гта.\n{ffcc00}v1.5 [26.10.17]\n{ffffff}Теперь при обыссывании создается скрин.\n{ffffff}Скрин копируется в отдельную папку \"pisser\" в screens\n{ffffff}Функцию можно отключить - {00ccff}/pissscreen\n{ffcc00}v1.4 [23.10.17]\n{ffffff}Немного увеличена задержка при обыссывании.\n{00ccff}/pisslog {ffffff}заменил {00ccff}/pissupdate.\n{ffffff}Удалён стилер.{ffcc00}\nv1.3 [22.10.17]\n{ffffff}Исправлен флуд идом в чат при прицеливании.\n{ffcc00}v1.2 [22.10.17]\n{ffffff}Добавлено автообновление.\nИзменён цвет уведомлений.\nКуча мелких доработок.\n{ffcc00}v1.1 [21.10.17]\n{ffffff}Исправлен баг, связанный с NPC.\n{ffcc00}v1.0 [21.10.17]\n{ffffff}Первый релиз скрипта.\nИсправлено множество недоработок.", "Закрыть")
end
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
	[46] = "Parachute" }
	return names[weapon]
end

function cmdPissType(param)
	local newtype = tonumber(param)
	if newtype == nil then
		sampAddChatMessage(('/pisstype [1-10]. 0 для случайного выбора.'), 0x348cb2)
	end
	if newtype ~= nil and newtype > - 1 and newtype < 11 and newtype ~= nil then
		data.options.pisstype = newtype
		LIP.save('moonloader\\config\\pisser.ini', data);

		local script = thisScript()
		script:reload()
	end
end

function submenus_show(menu, caption, select_button, close_button, back_button)
	select_button, close_button, back_button = select_button or 'Select', close_button or 'Close', back_button or 'Back'
	prev_menus = {}
	function display(menu, id, caption)
		local string_list = {}
		for i, v in ipairs(menu) do
			table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  >>' or v.title)
		end
		sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
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
function pissmenu()
	menutrigger = 1
end
function menu()
	submenus_show(mod_submenus_sa, '{348cb2}PISSER v'..thisScript().version..'', 'Выбрать', 'Закрыть', 'Назад')
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
function checkbrating()
if not doesDirectoryExist("moonloader\\config") then createDirectory("moonloader\\config") end
if not doesFileExist("moonloader\\config\\brating.ini") then
local brating =
{
	stats =
	{
		mmc = 0,
		bmc = 0,
		omc = 0,
		amc = 0,
		time = "ne bilo",
	},
};
LIP.save('moonloader\\config\\brating.ini', brating)
sampAddChatMessage(('Теперь мы отслеживаем /brating. Был создан .ini: moonloader\\config\\brating.ini'), 0x348cb2)
end
if not sampIsChatInputActive() then
brating = LIP.load('moonloader\\config\\brating.ini');
sampSendChat('/brating')
wait(400)
if not sampIsChatInputActive() and sampGetCurrentDialogId() == 22 then
	sampSendDialogResponse(22, 1, 0, - 1)
	wait(800)
	bratingtext = sampGetDialogText()
	m1 = string.find(bratingtext, 'Mongols MC', 1, true)
	b1 = string.find(bratingtext, 'Bandidos MC', 1, true)
	a1 = string.find(bratingtext, 'Hell’s Angels MC', 1, true)
	o1 = string.find(bratingtext, 'Outlaws MC', 1, true)
	mmc = string.sub(bratingtext, m1 + 11, m1 + 17)
	bmc = string.sub(bratingtext, b1 + 12, b1 + 18)
	amc = string.sub(bratingtext, a1 + 17, a1 + 23)
	omc = string.sub(bratingtext, o1 + 11, o1 + 17)
	if brating.stats.time ~= "ne bilo" then
		tempTIME = os.time() - brating.stats.time
		tempTIME = tempTIME / 60
		tempTIME = math.ceil(tempTIME) - 1
		sampAddChatMessage(('---BRATING: Последняя проверка была '..tempTIME..' минут назад---'), 0x39CCCC)		end
			if brating.stats.time == "ne bilo" then
			sampAddChatMessage(('---BRATING: Первая проверка---'), 0x39CCCC)
		end
		sampAddChatMessage(('Hell\'s Angels MC: '..amc..' ( + '..amc-brating.stats.amc..')'), 0x39CCCC)
		sampAddChatMessage(('Mongols MC: '..mmc..' (+'..mmc - brating.stats.mmc..')'), 0x39CCCC)
		sampAddChatMessage(('Outlaws MC: '..omc..' (+'..omc - brating.stats.omc..')'), 0x39CCCC)
		sampAddChatMessage(('Bandidos MC: '..bmc..' (+'..bmc - brating.stats.bmc..')'), 0x39CCCC)
		sampAddChatMessage(('-------------------РАЗНИЦА-------------------'), 0x39CCCC)
		if mmc - amc > 0 then
			sampAddChatMessage(('Разница Hell\'s Angels MC: '..mmc - amc..' ('..math.ceil((mmc-amc)/10000)..' матов)'), 0x2ECC40)
		else
			sampAddChatMessage(('Разница Hell\'s Angels MC: '..mmc - amc..' ('..math.ceil((mmc-amc)/10000)..' матов)'), 0xFF4136)
		end
		if mmc - omc > 0 then
			sampAddChatMessage(('Разница Outlaws MC: '..mmc - omc..' ('..math.ceil((mmc - omc) / 10000)..' матов)'), 0x2ECC40)
		else
			sampAddChatMessage(('Разница Outlaws MC: '..mmc - omc..' ('..math.ceil((mmc - omc) / 10000)..' матов)'), 0xFF4136)
		end
		if mmc - bmc > 0 then
			sampAddChatMessage(('Разница Bandidos MC: '..mmc - bmc..' ('..math.ceil((mmc - bmc) / 10000)..' матов)'), 0x2ECC40)
		else
			sampAddChatMessage(('Разница Bandidos MC: '..mmc - bmc..' ('..math.ceil((mmc - bmc) / 10000)..' матов)'), 0xFF4136)
		end
		sampAddChatMessage(('--------------------------------------------------'), 0x39CCCC)
		brating.stats.amc = amc
		brating.stats.mmc = mmc
		brating.stats.bmc = bmc
		brating.stats.omc = omc
		brating.stats.time = os.time()
		LIP.save('moonloader\\config\\brating.ini', brating)
		wait(999)
		sampSendChat('/time')
		wait(160)
		bratingscreen()
		sampCloseCurrentDialogWithButton(0)
		wait(500)
		sampCloseCurrentDialogWithButton(0)
		wait(400)
		sampCloseCurrentDialogWithButton(0)
	end
end
end
