script_name("������������")
script_version("1.95")
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
		if sampGetCurrentServerAddress() == '91.134.210.2' or sampGetCurrentServerAddress() == '91.134.210.1' then sampAddChatMessage(('[ERROR]: � ���� ���� �� ������ ��� ����� �������.'), 0xFE1312)
			if cegj > 0 then end
		else
			local result, target = getCharPlayerIsTargeting(playerHandle)
			if result then
				result2, playerid = sampGetPlayerIdByCharHandle(target)
				if result2 and playerid > - 1 then
					nick = sampGetPlayerNickname(playerid)
					name, surname = string.match(nick, "(%g+)_(%g+)")
					hp = sampGetPlayerHealth(playerid)
					if hp == 0 then pX, pY, pZ = getCharCoordinates(target) end
					stope = 1
				end
				if nick ~= nil then
					for i = 1, #data.blacklist do
						if data.blacklist[i] == string.upper(nick) then stope = 0 end
					end
				end
				if nick == "James_Bond" or nick == "Phil_Coulson" or nick == "Vittore_Deltoro" or nick == "Set_Johnson" or nick == "Emilie_Rouse" or nick == "Riley_Reid" or nick == "Neax_Wayne" or nick == "Mike_Rein" or nick == "Alex_Rein" or nick == "Francesco_Garsia" then stope = 2 end
			end
			--�������� ������ �������
			if not sampIsChatInputActive() and nick ~= nil and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isKeyDown(whatkeyid(data.options.hotkey)) and stope == 1 then
				myX, myY, myZ = getCharCoordinates(playerPed)
				if getDistanceBetweenCoords3d(pX, pY, pZ, myX, myY, myZ) < 10 then
					wait(100)
					-- ��� �����
					if data.options.pisstype == 0 then peetype = math.random(1, 10) else peetype = data.options.pisstype end
					iwanttopee(peetype, name, surname, nick)
				end
			end
			--������ ������ �������
			donotpee()
		end
	end
end

function donotpee()
	if not sampIsChatInputActive() and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isKeyDown(whatkeyid(data.options.hotkey)) and stope == 2 then
		wait(500)
		sampSendChat("/me ���������� �������, ������� �����, ������ ����������")
		forceWeatherNow(8)
		wait(1100)
		sampSendChat("/do �����, ������ �� ��������, ����� ������� �����, ������� �����.")
		wait(1300)
		sampSendChat("/me ��������� �� �������������, ������")
		wait(1300)
		sampSendChat("/do ��������� ������� �������� �������� ������� �� ������� ����������.")
		wait(10000)
		forceWeatherNow(0)
		stope = 0
	end
end

function iwanttopee(peetype, peename, peesurname, peenick)
	if peetype == 1 then
		if isPlayerDead(playerHandle) == false then
			sampSendChat('/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����������')
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("/do ��������� ������� �������� �������� ������� �� ����� "..peename.."'a "..peesurname.."'a.")
				else
					sampSendChat("/do ��������� ������� �������� �������� ������� �� ����� "..peenick.."'a.")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('/me �������� ������, �������� � �����������, ��������� �������')
					wait(1100)
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
				sampSendChat("����� " ..peename.." "..peesurname.." ���� �� ��� ��������??")
			else
				sampSendChat("����� " ..peenick.." ���� �� ��� ��������??")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("�� ������ ����� �� ����� ���� ���������")
				else
					sampSendChat("�� ������ ����� �� ����� ���� ���������")
				end
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('������� ��� �� ��� ��������, � � ������ ������')
					wait(1100)
					if isPlayerDead(playerHandle) == false then
						sampSendChat('�� ��� ������')
						nick = nil
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
				sampSendChat("Hasta la vista, baby")
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
				sampSendChat(peename.." "..peesurname..", �� ������ ����� ������� ��������, ����� �� �������� � ���� ���������� ������")
			else
				sampSendChat(peenick..", �� ������ ����� ������� ��������, ����� �� �������� � ���� ���������� ������")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				if peename ~= nil and peesurname ~= nil then
					sampSendChat("���� �� �� ������ �������� ������ ��������, �� ����� ������������ ��� ������������")
				else
					sampSendChat("���� �� �� ������ �������� ������ ��������, �� ����� ������������ ��� ������������")
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
				sampSendChat("� �������, "..peename..", � �������� ����� ���� ���������?")
			else
				sampSendChat("� �������, "..peenick..", � �������� ����� ���� ���������?")
			end
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				sampSendChat("� �������, ������, �� ������!")
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				if isPlayerDead(playerHandle) == false then
					sampSendChat('� � ������.')
					wait(1100)
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
			sampSendChat("������� � �����, �����.")
			wait(1300)
			if isPlayerDead(playerHandle) == false then
				sampSendChat("/me �������� ����� ����� �������")
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
		end if peetype == 7 then
			if isPlayerDead(playerHandle) == false then
				sampSendChat("/me ������ �� ������� ������������ ������ �������� � ��������.")
				wait(1300)
				if isPlayerDead(playerHandle) == false then
					if peename ~= nil and peesurname ~= nil then
						sampSendChat("/me ����� � ������ ������� � ������ "..peename.."'a "..peesurname.."'a")
					else
						sampSendChat("/me ����� � ������ ������� � ������  "..peenick.."'a")
					end
					wait(200)
					pissscreen(peenick)
					if data.options.screenshot == 1 then wait(750) end
					if data.options.screenshot == 0 then wait(1200) end
					if isPlayerDead(playerHandle) == false then
						sampSendChat('/s �������� ������� � ����������!')
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
				sampSendChat("/s � ������ �����, ���! � �� ������� ����!")
				wait(1300)
				if isPlayerDead(playerHandle) == false then
					if peename ~= nil and peesurname ~= nil then
						sampSendChat("/s � ���� ����� �������� �������!")
					else
						sampSendChat("/s � ���� ����� �������� �������!")
					end
					wait(200)
					pissscreen(peenick)
					if data.options.screenshot == 1 then wait(750) end
					if data.options.screenshot == 0 then wait(1200) end
					iamolodec(peenick)
				end
			end
		end
		if peetype == 9 then
			if isPlayerDead(playerHandle) == false then
				sampSendChat("��� ��������, � ����� �� ������?")
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				iamolodec(peenick)
			end
		end
		if peetype == 10 then
			if isPlayerDead(playerHandle) == false then
				sampSendChat("�������� � ����� ���� ����������, ������� �������� ������.")
				wait(200)
				pissscreen(peenick)
				if data.options.screenshot == 1 then wait(750) end
				if data.options.screenshot == 0 then wait(1200) end
				iamolodec(peenick)
			end
		end
	end


	function cmdPissType(param)
		local newtype = tonumber(param)
		if newtype == nil then
			sampAddChatMessage(('/pisstype [1-10]. 0 ��� ���������� ������.'), 0x348cb2)
		end
		if newtype ~= nil and newtype > - 1 and newtype < 11 and newtype ~= nil then
			data.options.pisstype = newtype
			LIP.save('moonloader\\config\\pisser.ini', data);
			local script = thisScript()
			script:reload()
		end
	end


	function iamolodec(reportnick)
		wait(0)
		sampSendChat('/rb '..reportnick.." �������������.")
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
		sampAddChatMessage(('׸���� ������ ������������: '), 0xEFBFB)
		for i = 1, #data.blacklist do
			if data.blacklist[i] ~= nil then
				sampAddChatMessage((i..'. '..data.blacklist[i]), 0xFFFFFF)
			end
		end
	end
	function cmdPissAdd(newFriend)
		if param == nil then
			sampShowDialog(987, "�������� � ������ ������ pisser'a", string.format("����� �0 \n����� �1 \n����� �2 \n����� �3 \n����� �4 \n���������� �0 \n���������� �1 \n���������� �2 \n��������"), "�������", "�������", 3)
			while sampIsDialogActive() do wait(100) end
			local resultMain, buttonMain, bizid = sampHasDialogRespond(983)
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
		sampShowDialog(983, "/pisshotkey - ������� �������: "..data.options.hotkey, string.format("A\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN\nO\nP\nQ\nR\nS\nT\nU\nV\nW\nX\nY\nZ"), "�������", "�������", 2)
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
			data.options.startmessage = 0 sampAddChatMessage(('����������� ��������� ������������ ��� ������� ���� ���������'), 0x348cb2)
		else
			data.options.startmessage = 1 sampAddChatMessage(('����������� ��������� ������������ ��� ������� ���� ��������'), 0x348cb2)
		end
		LIP.save('moonloader\\config\\pisser.ini', data);
		data = LIP.load('moonloader\\config\\pisser.ini');
		for i = 1, #data.blacklist do
			if data.blacklist[i] ~= nil then data.blacklist[i] = string.upper(data.blacklist[i]) end
		end
	end
	function cmdPissScreen()
		if data.options.screenshot == 1 then
			data.options.screenshot = 0 sampAddChatMessage(('�������� ��� ����������� ��������'), 0x348cb2)
		else
			data.options.screenshot = 1 sampAddChatMessage(('�������� ��� ����������� �������'), 0x348cb2)
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
			sampAddChatMessage(('������ ������ ������������. ��� ������ .ini: moonloader\\config\\pisser.ini'), 0x348cb2)
			sampAddChatMessage(('�������� ���� �� Samp-Rp! � ���������, ����� Samp-Rp Revolution James_Bond!'), 0x348cb2)
		end
		-- ���� � ��� ����� ��������, ��� ������������� ��� �������� �� ������ ������
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
		sampRegisterChatCommand("pisser", cmdPissMenu)
		sampRegisterChatCommand("pisshotkey", cmdPissHotKey)
		sampRegisterChatCommand("pisslist", cmdPissList)
		sampRegisterChatCommand("pisslog", changelog)
		sampRegisterChatCommand("pissscreen", cmdPissScreen)
		sampRegisterChatCommand("pisstype", cmdPissType)
		if data.options.startmessage == 1 and sampGetCurrentServerAddress() ~= '91.134.210.2' and sampGetCurrentServerAddress() ~= '91.134.210.1' then sampAddChatMessage(('������������ �������. v '..thisScript().version), 0x348cb2) end
		if data.options.startmessage == 1 and sampGetCurrentServerAddress() ~= '91.134.210.2' and sampGetCurrentServerAddress() ~= '91.134.210.1' then sampAddChatMessage(('��������� - /pisser. ��������� ��� ��������� - /pissnot'), 0x348cb2) end
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
		sampShowDialog(2342, "{ffbf00}������������. �����: James_Bond/rubbishman/Coulson.", "{ffcc00}��� ���� ���� ������?\n{ffffff}������ �������, ����� �������������� � ������ ���������� ����������� ������ ����.\n�������� ������ �� ������ - ��� ����� � �� ���������, � ������ ��� �� � ��������� ��������������.\n{ffcc00}������ ���� ��� ��� ���������?\n{ffffff}����� ���������� �� ������ ������, ������� +����, ���������� � ��� ���, ������� � �����������,\n������� �������� ������������ ����������, ����� ��������, ���������� ��� ������� (�����),\n���� ���������� �����������.\n����� �� ��������� ��������, � ��� ��� ��� ��������.\n{FF0000}�� ����� ��������� ����� �� ������ �������.\n{ffcc00}��� ��� �������� ������?\n{ffffff}����� ����-�� ��������, ��� ����� ����� ������ � ����������� � ��������� ����� � ��� (10 ������).\n��� ����� ��������� � ����� � ������ ������� �������. ������� ������� - {00ccff}"..data.options.hotkey.."\n{ffffff}���� ����������� /pissscreen, �� ����� ������ �������� � ��������� �����.\n{ffcc00}��������� �������:\n    {00ccff}/pisser {ffffff}- ��� ����\n    {00ccff}/pisslog {ffffff}- changelog �������\n    {00ccff}/pisshotkey {ffffff}- �������� ������� �������\n   {00ccff} /pissnot{ffffff} - ��������/��������� ��������� ��� ����� � �����\n   {00ccff} /pissscreen{ffffff} - ��������/��������� ����� ��� �����������\n{ffcc00}���������� ������ ������ ������������, ����� �������� �� �������� �������� ��� ������.\n   {00ccff}/pisslist {ffffff}- ������ ������ ������������ (� ���)\n   {00ccff}/pissadd [NICK_NAME] {ffffff}- �������� ��� � ������ ������ ������������\n   {00ccff}/pissdel [NICK_NAME] {ffffff}- ������� ��� �� ������� ������ ������������\n", "����")
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
						sampAddChatMessage(('[PISSER]: ���������� ����������. AutoReload ����� �������������. ����������..'), 0x8B0000)
						sampAddChatMessage(('[PISSER]: ������� ������: '..thisScript().version..". ����� ������: "..version), 0x8B0000)
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
		sampAddChatMessage(('[PISSER]: ���������� ���������! ��������� �� ���������� - /pisslog.'), 0x348cb2)
		goplay = 1
		thisScript():reload()
	end
end)
end
function changelog()
sampShowDialog(2342, "{ffbf00}PISSER: ������� ������.", "{ffcc00}v1.95 [27.10.17]\n{ffffff}� �������� ������ ��������� ��� ������ ���������.\n�� ��������� ����� ������� ��������, ����� �������� - {00ccff}/pisstype.\n{ffffff}�������� ����� � /rb.\n{ffcc00}v1.8 [26.10.17]\n{ffffff}��������� ��� � {00ccff}/pisslist.\n{ffffff}���������� ����������� ������ �� ����������� ���.\n{ffcc00}v1.5 [26.10.17]\n{ffffff}������ ��� ����������� ��������� �����.\n{ffffff}����� ���������� � ��������� ����� \"pisser\" � screens\n{ffffff}������� ����� ��������� - {00ccff}/pissscreen\n{ffcc00}v1.4 [23.10.17]\n{ffffff}������� ��������� �������� ��� �����������.\n{00ccff}/pisslog ������� {00ccff}/pissupdate.\n����� ������.{ffcc00}\nv1.3 [22.10.17]\n{ffffff}��������� ���� ���� � ��� ��� ������������.\n{ffcc00}v1.2 [22.10.17]\n{ffffff}��������� ��������������.\n������� ���� �����������.\n���� ������ ���������.\n{ffcc00}v1.1 [21.10.17]\n{ffffff}��������� ���, ��������� � NPC.\n{ffcc00}v1.0 [21.10.17]\n{ffffff}������ ����� �������.\n���������� ��������� �����������.", "�������")
end
