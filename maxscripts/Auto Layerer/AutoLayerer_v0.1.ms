try DestroyDialog(Layerman) catch()

rollout Layerman "Layerman" width:209 height:380
(
	button 'geom_btn' "Geometry" pos:[11,26] width:90 height:25 align:#left
	button 'shape_btn' "Shapes" pos:[106,26] width:90 height:25 align:#left
	button 'light_btn' "Lights" pos:[11,54] width:90 height:25 toolTip:"" align:#left
	button 'cam_btn' "Cameras" pos:[106,54] width:90 height:25 align:#left
	button 'point_btn' "Helpers" pos:[11,82] width:90 height:25 align:#left
	button 'sWarps_btn' "Forces" pos:[106,82] width:90 height:25 align:#left
	label 'class_lbl' "Create by class:" pos:[12,8] width:126 height:15 align:#left
	label 'nLayer_lbl' "New Layer:" pos:[12,139] width:55 height:15 align:#left
	edittext 'edt1' "" pos:[10,154] width:186 height:18 align:#left
	button 'addsel_btn' "Add selection to this layer" pos:[106,299] width:87 height:28 align:#left
	button 'newlay_btn' "Create layer" pos:[25,174] width:80 height:22 align:#left
	listbox 'layer_list' "" pos:[17,199] width:176 height:7 align:#left
	button 'bones_btn' "Bones" pos:[59,110] width:90 height:25 align:#left
	button 'mk_active' "Make this layer active" pos:[15,300] width:87 height:28 align:#left
	button 'clear_btn' "Clear" pos:[106,174] width:80 height:22 align:#left
	label 'mkrlbl' "--AVTOOLS--" pos:[74,360] width:65 height:15 align:#left
	button 'update_btn' "Update" pos:[60,330] width:85 height:22 align:#left
	
	fn buildLayerData =
	(
		global dispData = for i = 0 to LayerManager.count-1 collect #((LayerManager.getLayer i).name)
	)	
	
	fn updateLayerDisplay = 
	(
		layer_list.items = for i in dispData collect (i[1])	
	)
	

		on geom_btn pressed do
		(
			select geometry
			g_lay = LayerManager.newLayerFromName "Geometry"
			for g_geom in (selection as array) do g_lay.addNode g_geom	
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on shape_btn pressed do
		(
			select shapes
			s_lay = LayerManager.newLayerFromName "Shapes"
			for s_shape in (selection as array) do s_lay.addNode s_shape
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on light_btn pressed do
		(
			select lights
			l_lay = LayerManager.newLayerFromName "Lights"
			for l_Lights in (selection as array) do l_lay.addNode l_Lights
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on cam_btn pressed do
		(
			select cameras
			c_lay = LayerManager.newLayerFromName "Cameras"
			for c_cams in (selection as array) do c_lay.addNode c_cams
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on point_btn pressed do
		(
			select helpers
			h_lay = LayerManager.newLayerFromName "Helpers"
			for h_help in (selection as array) do h_lay.addNode h_help
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on sWarps_btn pressed do
		(
			select spacewarps
			w_lay = LayerManager.newLayerFromName "Forces"
			for s_warps in (selection as array) do w_lay.addNode s_warps
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on addsel_btn pressed do
		(  
			selLayer = layer_list.selected
			curLayer = LayerManager.getLayerFromName selLayer 
			for objs in (selection as array) do curlayer.addNode objs
		)
		
		
		on newlay_btn pressed do
		(
			lay_name = edt1.text as string
			global n_Lay = LayerManager.newLayerFromName lay_name
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on bones_btn pressed do
		(
			allBones = for obj in objects where (classof obj == BoneGeometry) collect obj
			select allbones
			b_lay = LayerManager.newLayerFromName "Bones"
			for b_bone in (selection as array) do b_lay.addNode b_bone
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
		on mk_active pressed do
		(
			onLayer = layer_list.selected
			actLayer = LayerManager.getLayerFromName onLayer
			actLayer.current = true
		)
		
		
		on clear_btn pressed do
		(
			edt1.text = ""
		)
		
		
		on update_btn pressed do
		(
			if dispData.count != layerManager.count do buildLayerData()
			updateLayerDisplay()
		)
		
		
)

CreateDialog Layerman