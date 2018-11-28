-- https://projectzomboid.com/modding/zombie/iso/objects/IsoGenerator.html

-- tail -f file | grep --line-buffered my_pattern
-- https://theindiestone.com/forums/index.php?/topic/61-robomats-modding-tutorials-updated-12112013/
-- http://pzwiki.net/wiki/Modding:Lua_Event
-- https://theindiestone.com/zomboidjavadocs/constant-values.html#zombie.input.Keys
-- https://theindiestone.com/zomboidjavadocs/zombie/characters/IsoPlayer.html
-- https://theindiestone.com/zomboidjavadocs/zombie/Lua/LuaManager.GlobalObject.html


-- z  - 
-- x  -
-- n  -
-- m  -
-- ,  -
-- .  -         
-- /  -
-- f  -
-- g  -
-- k  -
-- l  -
-- ;  -
-- '  -
-- e  -
-- r  - 19
-- t  -
-- y  -
-- u  -
-- o  -
-- p  -
-- [  -
-- ]  -


--             left shift               |         right shift 
-- z            add Axe                 |
-- x            add Sledgehammer        |
-- n            add PetrolCan           |
-- m            add PropaneTank         |
-- ,            add Chocolate           |
-- .                           
-- /            
-- f            add AdminAxe            | 
-- g  -         add Admin Generator     |     enable/disable ghost mode
-- k            add Auger               |
-- l            add Wooden Ladder       |
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

--             left alt                 |         right alt 
-- z                                    |
-- x                                    |
-- n                                    |
-- m            show/hide map           |
-- ,                                    |
-- .            
-- /
-- f                                    | 
-- g  -                                 |                              
-- k
-- l
-- ;
-- '
-- e
-- r            radar test              |
-- t
-- y
-- u
-- o
-- p
-- [
-- ]

------------------------------------------------------------------------
cppProstoMain = 
{
  log_tag = "cppProsto";
  isDebug = true;

  lShiftIsHold = false;
  rShiftIsHold = false;
  
  lCtrlIsHold  = false;
  rCtrlIsHold  = false;
  
  lAltIsHold   = false;
  rAltIsHold   = false;

  ghostMode    = false;
  mapIsShow    = false;

  player     = nil;
  player_inv = nil;
};
------------------------------------------------------------------------

g_main    = nil;
g_zomboPC = nil
------------------------------------------------------------------------
function cppProstoMain:new()
  local o = {}
  setmetatable(o,self)
  self.__index = self
  return o
end

--------------------- Enable/Disable GHOST Mode ------------------------
function cppProstoMain:enableDisableGhostMode()
  if self.player:isGhostMode() == true 
  then
    self.player:setGhostMode(false);
    self.player:Say("Ghost mode disabled");
  else
    self.player:setGhostMode(true);
    self.player:Say("Ghost mode enabled");
  end 
end
--------------------- Add Auger  to inventory ---------------------------
function cppProstoMain:addAuger()
  self.player_inv:AddItem("Hydrocraft.HCAuger");
end
--------------------- Add Wooden ladder to inventory --------------------
function cppProstoMain:addWoodenladder()
  self.player_inv:AddItem("Hydrocraft.HCWoodenladder");
end
--------------------- Add axe to inventory -----------------------------
function cppProstoMain:addAxe()
  self.player_inv:AddItem("Base.Axe");
end
--------------------- Add Sledgehammer to inventory --------------------
function cppProstoMain:addSledgehammer()
  self.player_inv:AddItem("Base.Sledgehammer");
end
--------------------- Add PetrolCan to inventory -----------------------
function cppProstoMain:addPetrolCan()
  self.player_inv:AddItem("Base.PetrolCan");
end
--------------------- Add PropaneTank to inventory ---------------------
function cppProstoMain:addPropaneTank()
  self.player_inv:AddItem("Base.PropaneTank");
end
--------------------- Add Chocolate to inventory -----------------------
function cppProstoMain:_addChocolate()
  self.player_inv:AddItem("Base.Chocolate");
end
--------------------- Add Admin Axe ------------------------------------
function cppProstoMain:addAdminAxe()
  self.player_inv:AddItem("cppProstoMod.AdminAxe");
end
--------------------- Add Admin Generator ------------------------------
function cppProstoMain:addAdminGenerator()
  self.player_inv:AddItem("cppProstoMod.AdminGenerator");
end
--------------------- Action For Key With Right Shift Holding ----------
function cppProstoMain:RightShiftKeyProcessing( keyCode )
  if keyCode == 34 then self:enableDisableGhostMode()     -- G
  end
end
--------------------- Show/Hide Map ------------------------------------
function cppProstoMain:showHideMap()
  if self.mapIsShow == true then
    print(self.log_tag, "hide start");
    g_zomboPC:hide_map();
    self.mapIsShow = false;
  else
    print(self.log_tag, "show start");
    g_zomboPC:show_map();
    self.mapIsShow = true;
  end
end
--------------------- Radar test ---------------------------------------
function cppProstoMain:radarTest()
  g_zomboPC:radar_test();
end
--------------------- Actiond For Key With Left Shift Holding ----------
function cppProstoMain:LeftShiftKeyProcessing( keyCode )
  if     keyCode == 44 then self:addAxe();                  -- Z
  elseif keyCode == 45 then self:addSledgehammer();         -- X
  elseif keyCode == 49 then self:addPetrolCan();            -- N
  elseif keyCode == 50 then self:addPropaneTank();          -- M
  elseif keyCode == 51 then self:addChocolate();            -- ,
  elseif keyCode == 33 then self:addAdminAxe();             -- F
  elseif keyCode == 34 then self:addAdminGenerator();       -- G
  elseif keyCode == 37 then self:addAuger();                -- K
  elseif keyCode == 38 then self:addWoodenladder();         -- L
  end
end
--------------------- Actiond For Key With Left Shift Holding ----------
function cppProstoMain:LeftAltKeyProcessing( keyCode )
  if     keyCode == 50 then self:showHideMap();             -- M
  elseif keyCode == 19 then self:radarTest();               -- R
  end
end
------------------------------------------------------------------------
function cppProstoMain:checkModifyKeyDown( keyCode )
  if     keyCode == 42  then self.lShiftIsHold = true;
  elseif keyCode == 54  then self.rShiftIsHold = true;
  elseif keyCode == 26  then self.lCtrlIsHold  = true;
  elseif keyCode == 157 then self.rCtrlIsHold  = true;
  elseif keyCode == 56  then self.lAltIsHold   = true;
  elseif keyCode == 184 then self.rAltIsHold   = true;
  end
end
------------------------------------------------------------------------
function cppProstoMain:checkModifyKeyUp( keyCode )
  if     keyCode == 42  then self.lShiftIsHold = false;
  elseif keyCode == 54  then self.rShiftIsHold = false;
  elseif keyCode == 26  then self.lCtrlIsHold  = false;
  elseif keyCode == 157 then self.rCtrlIsHold  = false;
  elseif keyCode == 56  then self.lAltIsHold   = false;
  elseif keyCode == 184 then self.rAltIsHold   = false;
  end
end
------------------------------------------------------------------------
function cppProstoMain:keyDown( keyCode )
  self:checkModifyKeyDown( keyCode );
end
------------------------------------------------------------------------
function cppProstoMain:keyUp( keyCode )
--  if self.isDebug == true then
--    print(self.log_tag, "keyUp", "key = ", keyCode);
--  end

  if     self.lShiftIsHold == true then self:LeftShiftKeyProcessing( keyCode ); 
  elseif self.rShiftIsHold == true then self:RightShiftKeyProcessing( keyCode );
  elseif self.lAltIsHold   == true then self:LeftAltKeyProcessing( keyCode );
 
  end

  self:checkModifyKeyUp( keyCode );
end
------------------------------------------------------------------------
function cppProstoMain:init_global()
  self.player     = getPlayer();
  self.player_inv = self.player:getInventory();

  if not self.player_inv:contains("cppPInfiniteCarryweight") then
    self.player_inv:AddItem("cppProstoMod.cppPInfiniteCarryweight")
    getPlayer():setMaxWeightBase( 999999 );
  end

  -- self.player:setMaxWeight(2000);
  -- self.player:setMaxWeightBase(2000);
  -- self.player:setMaxWeightDelta(200);
  print(self.log_tag, "global inited.");
end
------------------------------------------------------------------------
function cppProstoMain:main()
  print(self.log_tag, "cppProsto mod was loaded.");
end
------------------------------------------------------------------------


------------------------------------------------------------------------
-------------------------- GLOBAL FUNCTIONS ----------------------------
------------------------------------------------------------------------
function globalGameStart()
  g_main = cppProstoMain:new();
  g_main:main();
  g_main:init_global();
  
  ZomboPCWindowCreate();
end
------------------------------------------------------------------------
function globalKeyDown( keyCode )
  g_main:keyDown( keyCode );
  
  --g_zomboPC:update();
end
------------------------------------------------------------------------
function globalKeyUp( keyCode )
  g_main:keyUp( keyCode );
end



---------------------- EVENTS ------------------------------------------
--Events.OnGameBoot.Add(g_main.main);

Events.OnGameStart.      Add( globalGameStart );
Events.OnKeyStartPressed.Add( globalKeyDown );
Events.OnKeyPressed.     Add( globalKeyUp );
------------------------------------------------------------------------




