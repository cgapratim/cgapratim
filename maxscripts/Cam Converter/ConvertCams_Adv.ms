try DestroyDialog ConvertCams catch()
rollout Convertcams "Camera Converter" width:162 height:310
(
	listbox 'listobj' "Objects:" pos:[15,30] width:134 height:10 align:#left
	button 'addsel' "Add Selection" pos:[20,190] width:119 height:23 align:#left
	button 'rmvall' "Remove All" pos:[20,213] width:119 height:23 align:#left
	button 'mainbtn' "Convert!" pos:[20,236] width:119 height:23 align:#left
	button 'bake' "Bake!" pos:[20,259] width:119 height:23 align:#left
	label 'lbl1' "--Cam Converter--" pos:[35,6] width:146 height:17 align:#left
	label 'lbl3' "©AVTOOLS" pos:[50,290] width:57 height:15 align:#left
	
	on listobj selected sel do
	(	
		selected
	)
	
	on addsel pressed do
	(	
		items = listobj.items
		for i in selection do appendifunique items i.name
		listobj.items = sort items
	)
	global ar = #()
	on mainbtn pressed do
	(	 
			for cam in selection do
			(
			newCam = Freecamera()
			newCam.transform = cam.transform
			newCam.parent =cam
			cam.specify_fov = off
			newCam.fov = cam.fov
			newCam.name = cam.name + "_Free"
			append ar newCam
			)
			print ar
		deselect objects
		select ar
		)
fn baking CamSel=
(

	help = point()
	help.name = "Helperman"
	contr=copy $Helperman
	 for i = animationRange.start to animationRange.end do  
     ( 
          animate on 
          ( 
               at time i 
               ( 
                  contr.transform = CamSel.transform  				 
			    )
			)
		)
		 CamSel.parent = undefined
		 CamSel.name = CamSel.name + "_Baked"
		 CamSel.pos.controller = bezier_position ()
		 CamSel.pos.controller = Position_XYZ ()
		 CamSel.rotation.controller = tcb_rotation ()
		 CamSel.rotation.controller = Euler_XYZ ()
		 CamSel.scale.controller = bezier_scale ()
		 CamSel.scale.controller = ScaleXYZ ()
		 
		 for w = animationRange.start to animationRange.end do   
     ( 
		
          animate on 
          ( 
               at time w 
               ( 
                  CamSel.transform = contr.transform  				 
			    )
			)
		)	
	delete help	
	delete contr
	deselect objects
)
	
	on bake pressed do 
	(
		max create mode
		for cam in selection do (baking cam)
	)
	on rmvall pressed do
	(	
		listobj.items = #()
	)
)
CreateDialog Convertcams

