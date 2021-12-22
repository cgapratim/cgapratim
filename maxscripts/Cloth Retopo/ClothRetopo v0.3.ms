try DestroyDialog(ClothRetopo) catch()
rollout ClothRetopo "Cloth Retopo" width:162 height:199
(
	button 'btn3' "Create Plane" pos:[17,23] width:128 height:22 align:#left
	label 'lbl2' "Width Segments:" pos:[18,52] width:87 height:22 align:#left
	spinner 'spn2' "" pos:[103,52] width:39 height:16 range:[0,1000,10] type:#integer align:#left
	button 'btn4' "Add Skin Wrap" pos:[19,76] width:122 height:22 align:#left
	button 'btn5' "Add Point Cache" pos:[19,100] width:122 height:22 align:#left
	button 'btn6' "RECORD!" pos:[19,124] width:122 height:22 align:#left
	button 'btn7' "Add Turbosmooth" pos:[19,148] width:122 height:22 align:#left
	global ratio = 1.0
	global pl
	on btn3 pressed do
	(	selcount = selection.count
		if selcount==1 then
		(
			base=getCurrentSelection()
			baseBB=nodeGetBoundingBox $ $.transform
			bb = (baseBB[1] - baseBB[2])
			ratio=bb[2]/bb[1]
			tr=base[1].transform
			pl=plane()
			pl.name = $.name as string + "_Retopo"
			pl.length=bb[2]
			pl.width=bb[1]
			pl.transform=tr
			paramWire.connect pl.baseObject[#Width_Segments] pl.baseObject[#Length_Segments] "Width_Segments*ratio"
		)
		else 
		messageBox "Please Select One Object"
	)
	on spn2 changed val do
		pl.widthsegs = val
	on btn4 pressed do
	(	
		addModifier pl (Skin_Wrap())
		pl.modifiers[#Skin_Wrap].engine = 0
		pl.modifiers[#Skin_Wrap].meshList = selection as Array
	)
	on btn5 pressed do 
	(
			deselect objects
		select pl
		addModifier pl (Point_Cache())
		filepath= maxfilepath
		--pl.modifiers[#Point_Cache].unload()
		pl.modifiers[#Point_Cache].filename = filepath + pl.name as string + "_PC.xml"
		
		)
	on btn6 pressed do
	(
		pl.modifiers[#Point_Cache].record()
		)
	on btn7 pressed do
	(
		addModifier pl (TurboSmooth())
		)
)
CreateDialog ClothRetopo