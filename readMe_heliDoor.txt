[b]Move to helicopter door and fire (Version 0.3)[/b]
Practical uses of the AttachTo command Part 4
© MARCH 2010 - norrin (norrin@iinet.net.au)

[i]Description[/i]
A script that allows you to move from the seat position within a chopper to the door way so that you can fire outside while the chopper is moving.  

[i]To implement in your own missions[/i]
1. Copy the heliDoor folder from the test mission into your mission file.
2. Create a UH-1 or a UH-60 in the editor and name it, then in the chopper’s init box put:[code]nul = [this] execVM "heliDoor\heliDoor_init.sqf";[/code]
3. Create a player in the editor and name it.

[i]To use:[/i]
1. Get in the chopper once inside you should get an action that allows you to move to the left or right door
2. To aim: bring up the iron sights and hold the alt key to move your aim point around
3. Press "R" to reload
4  Press "INSERT" to move back to your seat - NB you will need to do this to disembark the chopper, you may also need a pilot to get the script to work.

[i]Limitations[/i]
If the chopper is accelerating or decelerating hard you may bob around a bit inside while at the doors and may not be able to shoot - unfortunately this is a limitation of the attachTo command. When in level flight it seems to work really nicely.

[i]Test Mission[/i] 
Get in the back of the chopper and then move to the door (you can also do this while in flight).  Order the pilot to move to a position on the map.  Try moving to each door and back again.

[i]Tested[/i]
On a dedicated server by myself 


