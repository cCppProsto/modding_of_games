--Solar Generator
--By Nolan Ritchie

-----------------------------------------------------------------------------------------
function cppProstoSetAdminGen(items, result, player)
  if(player:isOutside()) then
    for i=0, items:size()-1 do
      if(items:get(i):getType() == "AdminGenerator") then
        local NewGenerator = IsoGenerator.new(nil,player:getCell(),player:getCurrentSquare());
        NewGenerator:setConnected(true);
        NewGenerator:setFuel(100);
        NewGenerator:setCondition(100);
        NewGenerator:setActivated(true);
        NewGenerator:setSurroundingElectricity() ;
        NewGenerator:remove();
        player:getCurrentSquare():AddWorldInventoryItem( "cppProstoMod.AdminGenerator" ,0.5,0.5,0);
        break;
      end
    end
  else
    player:Say("Must set Outside");
    player:getInventory():AddItem("cppProstoMod.AdminGenerator");
  end
end
 