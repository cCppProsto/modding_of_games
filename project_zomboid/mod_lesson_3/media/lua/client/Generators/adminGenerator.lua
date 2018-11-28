-- https://projectzomboid.com/modding/zombie/iso/objects/IsoGenerator.html
-----------------------------------------------------------------------------------------
function cppProstoSetAdminGen(items, result, player)
  for i=0, items:size()-1 do
    if(items:get(i):getType() == "AdminGenerator") then
      local NewGenerator = IsoGenerator.new(nil,player:getCell(),player:getCurrentSquare());
      NewGenerator:setConnected(true);
      NewGenerator:setFuel(100);
      NewGenerator:setCondition(100);
      NewGenerator:setActivated(true);
      NewGenerator:setConnected(true);
      NewGenerator:setSurroundingElectricity() ;
      NewGenerator:remove();
      player:getCurrentSquare():AddWorldInventoryItem( "cppProstoMod.AdminGenerator" ,0.5,0.5,0);
      player:Say("Done!");
      break;
    end
  end
end
