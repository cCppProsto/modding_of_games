require "ISUI/ISCollapsableWindow"

ZomboPC = 
{
  title = "";
};

ZomboPC = ISCollapsableWindow:derive("ZomboPC");

g_zomboPC = nil;

------------------------------------------------------------------------
function ZomboPC:initialize()
  ISCollapsableWindow.initialise(self);
end
------------------------------------------------------------------------
function ZomboPC:new(x, y, width, height)
  local o = ISCollapsableWindow:new(x, y, width, height);
  setmetatable(o, self)
  self.__index          = self
  o.title               = "Zombo PC";
  o.pin                 = true;
  o.resizable           = false;
  o.backgroundColor     = {r=0, g=0, b=0, a=0.8};
  print(g_main.log_tag, "ZomboPC:new()");
 return o;
end
------------------------------------------------------------------------
function ZomboPC:createChildren()
  print(g_main.log_tag, "ZomboPC:createChildren()");

  ISCollapsableWindow.createChildren(self);

  --self.height = 130;
  self.CoordsBody = ISRichTextPanel:new(0, 16, 150, 200);
  self.CoordsBody:initialise();
  self.CoordsBody.marginTop = 3;
  self.CoordsBody.marginLeft = 25;
  self.CoordsBody.marginBottom = 0;
  self.CoordsBody.marginRight = 0;
  self:addChild(self.CoordsBody);
  
  local th = self:titleBarHeight()
  self.closeButton = ISButton:new(3, 0, th, th, "", self, self.close);
  self.closeButton:initialise();
  self.closeButton.borderColor.a = 0.0;
  self.closeButton.backgroundColor.a = 0;
  self.closeButton.backgroundColorMouseOver.a = 0;
  self.closeButton:setImage(self.closeButtonTexture);
  self:addChild(self.closeButton);
end
------------------------------------------------------------------------
function ZomboPC:close()
  print(g_main.log_tag, "ZomboPC:close()");
  self:setVisible(false);
end
------------------------------------------------------------------------
--function ZomboPC:update()
--  print(g_main.log_tag, "ZomboPC:update()");
--  local pos = 20 .. ", " .. 20;
--  self.CoordsBody.text = pos;
--  self.CoordsBody:paginate();
--  self:setVisible(true);
--end
------------------------------------------------------------------------
function ZomboPC:show_map()
  print(g_main.log_tag, "ZomboPC:show()");
  if g_zomboPC then
  
    local pos = 20 .. ", " .. 20;
    -- local Temp = pos .. ":" .. " <LINE> " .. "Test";
    
    local tmpstr = "count of zombies : " .. self:getZombieCount(30) .. " <LINE> " .. "end";
    
    self.CoordsBody.text = tmpstr;
  
    g_zomboPC.CoordsBody.textDirty = true;
    g_zomboPC.CoordsBody:paginate();
    g_zomboPC:setVisible(true);
  end
end
------------------------------------------------------------------------
function ZomboPC:hide_map()
  print(g_main.log_tag, "ZomboPC:hide()");
  if g_zomboPC then
    g_zomboPC:setVisible(false);
  end
end
------------------------------------------------------------------------
function ZomboPC:getZombieCount(radius)
  print(g_main.log_tag, "ZomboPC:getZombieCount()");

  local x                     = round(g_main.player:getX());
  local y                     = round(g_main.player:getY());
  local z                     = round(g_main.player:getZ());
  local cell                  = getCell();
  local cell_iso_grid_square  = cell:getGridSquare(x, y, z);

  local wcell = getWorld():getCell();
  local cobjects = wcell:getLuaObjectList();
  local zombie_count = 0;
  for k,v in ipairs(cobjects) do
    if cell_iso_grid_square:DistTo(v) < radius then 
      if v:isZombie() then
        zombie_count = zombie_count + 1;
      end
    end
  end
  return zombie_count;
  -- print(g_main.log_tag, "zombie count = ", zombie_count);
end
------------------------------------------------------------------------
function ZomboPC:radar_test()
  print(g_main.log_tag, "ZomboPC:radar_test()");

  local x          = round(g_main.player:getX());
  local y          = round(g_main.player:getY());
  local z          = round(g_main.player:getZ());
  local cell                  = getCell();
  local cell_iso_grid_square  = cell:getGridSquare(x, y, z);

  local wcell = getWorld():getCell();
  local cobjects = wcell:getLuaObjectList();
  local radius = 30;
  local zombie_count = 0;
  for k,v in ipairs(cobjects) do
    -- print(g_main.log_tag, "v = ", v);
    if cell_iso_grid_square:DistTo(v) < radius then 
      -- if v:isCharacter() then
      --   print(g_main.log_tag, "character!");
      -- end
      if v:isZombie() then
        zombie_count = zombie_count + 1;
        -- print(g_main.log_tag, "zombie!");
      end
    end
  end
  print(g_main.log_tag, "zombie count = ", zombie_count);
end

------------------------------------------------------------------------
function ZomboPCWindowCreate()
  print(g_main.log_tag, "ZomboPCWindowCreate()");

  g_zomboPC = ZomboPC:new(60, 0, 150, 200);

  print(g_main.log_tag, "ZomboPCWindowCreate()", g_zomboPC);

  g_zomboPC:addToUIManager();
  g_zomboPC:setVisible(false);
  g_zomboPC.pin = true;
  g_zomboPC.resizable = false;
end




------------------------------------------------------------------------
function CoordsUpdate()
  print(g_main.log_tag, "CoordsUpdate()");

  local player = getSpecificPlayer(0);
  if player then
    local x = round(player:getX());
    local y = round(player:getY());

    local room = player:getCurrentSquare():getRoom();
    local zone = player:getCurrentSquare():getZone();
    local Temperature = round(getWorld():getGlobalTemperature(),1) .. "";
    local roomTxt;
    local zoneTxt;
    local zoneDesc;
    if room then
      local roomName = player:getCurrentSquare():getRoom():getName();
      roomTxt = roomName;
    else
      roomTxt = getText("IGUI_outsideString");
    end

    if g_zomboPC then
      g_zomboPC.CoordsBody.textDirty = true;
      g_zomboPC.CoordsBody:paginate();
      g_zomboPC:setVisible(true)
    end
  end
end

------------------------------------------------------------------------
--Events.OnGameStart.Add(CoordsWindowCreate);
--Events.OnPlayerUpdate.Add(CoordsUpdate);
------------------------------------------------------------------------
------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------
