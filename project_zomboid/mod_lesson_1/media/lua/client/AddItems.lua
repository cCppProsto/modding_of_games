-- tail -f file | grep --line-buffered my_pattern
-- https://theindiestone.com/forums/index.php?/topic/61-robomats-modding-tutorials-updated-12112013/
-- http://pzwiki.net/wiki/Modding:Lua_Event
-- https://theindiestone.com/zomboidjavadocs/constant-values.html#zombie.input.Keys
-- https://theindiestone.com/zomboidjavadocs/zombie/characters/IsoPlayer.html
-- https://theindiestone.com/zomboidjavadocs/zombie/Lua/LuaManager.GlobalObject.html

--             left shift               |         right shift 
-- z            add Axe                 |
-- x            add Sledgehammer        |
-- n            add PetrolCan           |
-- m            add PropaneTank         |
-- ,            add Chocolate           |
-- .
-- /
-- f
-- g  -                                 |     enable/disable ghost mode
-- k
-- l
-- ;
-- '
-- e
-- r
-- t
-- y
-- u
-- o
-- p
-- [
-- ]

local log_tag = "cppProsto";

local L_shiftIsHold = false;
local R_shiftIsHold = false;
local L_ctrlIsHold  = false;
local R_ctrlIsHold  = false;
local L_altIsHold   = false;
local R_altIsHold   = false;

local g_player     = nil;
local g_player_inv = nil;

--------------------- init global variables ------------------------------------
local function _init_globals()
  g_player     = getPlayer();
  g_player_inv = g_player:getInventory();
end

--------------------- Enable/Disable GHOST Mode --------------------------------
local function _enable_disable_ghost_mode()
  if g_player:isGhostMode() == true 
  then
    g_player:setGhostMode(false);
    g_player:Say("Ghost mode disabled");
  else
    g_player:setGhostMode(true);
    g_player:Say("Ghost mode enabled");
  end 
end
--------------------- Add axe to inventory -------------------------------------
local function _add_axe()
  g_player_inv:AddItem("Base.Axe");
end
--------------------- Add Sledgehammer to inventory ----------------------------
local function _add_Sledgehammer()
  g_player_inv:AddItem("Base.Sledgehammer");
end
--------------------- Add PetrolCan to inventory -------------------------------
local function _add_PetrolCan()
  g_player_inv:AddItem("Base.PetrolCan");
end
--------------------- Add PropaneTank to inventory -----------------------------
local function _add_PropaneTank()
  g_player_inv:AddItem("Base.PropaneTank");
end
--------------------- Add Chocolate to inventory -------------------------------
local function _add_Chocolate()
  g_player_inv:AddItem("Base.Chocolate");
end

--------------------- Actiond For Key With Right Shift Holding ------------------
local function _right_shift_key_processing(aKey)
  if aKey == 34 then _enable_disable_ghost_mode()     -- G
  end
end
--------------------- Actiond For Key With Left Shift Holding ------------------
local function _left_shift_key_processing(aKey)
  -- print(log_tag, "_left_shift_key_processing", aKey);
  if     aKey == 44 then _add_axe()                   -- Z
  elseif aKey == 45 then _add_Sledgehammer()          -- X
  elseif aKey == 49 then _add_PetrolCan()             -- N
  elseif aKey == 50 then _add_PropaneTank()           -- M
  elseif aKey == 51 then _add_Chocolate()             -- ,
  end
end
--------------------- Check Modify Key Start Press -----------------------------
local function _check_modify_key_start_press(aKey)
  if     aKey == 42  then L_shiftIsHold = true;
  elseif aKey == 54  then R_shiftIsHold = true;
  elseif aKey == 26  then L_ctrlIsHold  = true;
  elseif aKey == 157 then R_ctrlIsHold  = true;
  elseif aKey == 56  then L_altIsHold   = true;
  elseif aKey == 184 then R_altIsHold   = true;
  end
end
--------------------- Check Modify Key Pressed ---------------------------------
local function _check_modify_key_pressed(aKey)
  if     aKey == 42  then L_shiftIsHold = false;
  elseif aKey == 54  then R_shiftIsHold = false;
  elseif aKey == 26  then L_ctrlIsHold  = false;
  elseif aKey == 157 then R_ctrlIsHold  = false;
  elseif aKey == 56  then L_altIsHold   = false;
  elseif aKey == 184 then R_altIsHold   = false;
  end
end



--------------------- Key Start Pressed ----------------------------------------
local function keyStartPressed(_keyStartPressed)
  -- print(log_tag, "keyStartPressed", _keyStartPressed);

  _check_modify_key_start_press(_keyStartPressed);
end
--------------------- Key Pressed ----------------------------------------------
local function keyPressed(_keyPressed)
  -- print(log_tag, "keyPressed", _keyPressed);
  if     L_shiftIsHold == true then _left_shift_key_processing(_keyPressed); 
  elseif R_shiftIsHold == true then _right_shift_key_processing(_keyPressed);
  end
  
  _check_modify_key_pressed(_keyPressed);
end
--------------------- Add Items ------------------------------------------------
local function addItems(_keyPressed)
  local key    = _keyPressed; -- Store the parameter in a local variable.
  local player = getSpecificPlayer(0);    -- Java: get player one
  local inv    = player:getInventory();   -- Java: access player inv
    
  -- Java: add the actual items to the inventory
  -- inv:AddItem("Base.Axe");
  -- inv:AddItem("Base.RippedSheets");
  -- inv:AddItem("camping.TentPeg");
end
--------------------------------------------------------------------------------
local function load() 
  -- print("Load!!");
end
--------------------------------------------------------------------------------
local function tick() 
  -- print("tick!!");
end
--------------------------------------------------------------------------------
local function update(_isoPlayer) 
  -- print("update!!");
end
--------------------------------------------------------------------------------
local function gameStart() 
  _init_globals();
  
  if g_player:isGhostMode() == true then print(log_tag, "gameStart", "ghost mode enabled");
                                    else print(log_tag, "gameStart", "ghost mode disabled");
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Events.OnKeyStartPressed.Add(keyStartPressed);
Events.OnKeyPressed.Add(keyPressed);
Events.OnGameStart.Add(gameStart);



-- Events.OnLoad.Add(load);
-- Events.OnTick.Add(tick);
-- Events.OnPlayerUpdate.Add(update);
