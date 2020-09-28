/*
ProColor
Author: Mark Hunanyan
Updated on: 27 March 2016
Version: 0.7
Description: Advanced WireColor Management
*/

global rltProColor
try destroyDialog rltProColor catch()

rollout rltProColor "ProColor 0.7"
(
	
	group "                 R A N D O M                "
	(
		radiobuttons RadRan labels:#("Geometry", "Selection", "All") across:2
		Button DoRan "Generate" tooltip:"Assign to objects" width:70 height:40 align:#right
	)
	
	function fn_Random objs =
	(
		for i in objs do
		i.wirecolor = random black white
	)
	
	on DoRan pressed do
	(
		if RadRan.state==1 then
			fn_Random geometry
				else
		if RadRan.state==2 then
			if selection.count < 1
				then messagebox "Please select 1 or more objects first"
				else
			fn_Random selection
				else
			fn_Random objects
	)
	
	
	group "                    G R A Y                     "
	(
		radiobuttons RanGray labels:#("Geometry", "Selection", "All") across:2
		button DoGray "Generate" tooltip:"Assign to objects" width:70 height:40 align:#right
	)
	
	function   fn_Gray objs =
	(
		for i in objs do
		i.wirecolor = white * random 0.2 0.8
	)
	
	on DoGray pressed do
	(
		if RanGray.state==1 then
			fn_Gray geometry
				else
		if RanGray.state==2 then
			if selection.count < 1
				then messagebox "Please select 1 or more objects first"
				else
			fn_Gray selection
				else
			fn_Gray objects
	)  
	

	

	
	
	    group "               G R A D I E N T              " (
        colorpicker gcpl color:[18,68,67] width:77 height:30 align:#left across:2
        colorpicker gcpr color:[59,114,112] width:77 height:30 align:#right
    )
    
    fn apply_gradient = (
        local domain = if selection.count == 0 then objects else selection
        local cnt = domain.count
        
        if cnt >= 2 do (    -- in case there is 0 or 1 object in the scene
            local col1 = gcpl.color
            local col2 = gcpr.color
            
            local step = (col2 - col1) / (cnt - 1)
            
            for i = 1 to cnt do domain[i].wireColor = col1 + (i - 1) * step
        )
    )
    
    on gcpl changed val do apply_gradient()
    on gcpr changed val do apply_gradient()
	
	
	
	group "               R E A L T I M E              "
	(
		colorpicker rtcp "" width:152 height:20 color:[33,50,85] align:#left
	)
	on rtcp changed new_col do
		if selection.count < 1
		then 
			(
				
				for obj in geometry do geometry.wirecolor = new_col
			)
		else
			(
				for obj in selection do selection.wirecolor = new_col
			)
			
			
			
			
	group "              E R A S E   M A T            "
		(
			radiobuttons radErase labels:#("Selection", "All") across:2
			Button btnErase "Erase" tooltip:"Assign to objects" width:70 height:40 align:#right
		)
		on btnErase pressed do
			(
			if radErase.state==1 then
				(
					if selection.count < 1
					then messagebox "Please select 1 or more objects first"
					else
						(
							$.material = undefined
						)
				)
			else	if radErase.state==2 then
				(
					if geometry.count ==0
					then	messagebox "You have no geometry objects"
					else
						(
							geometry.material = undefined
						)
				)
	)  
	
	
			
	group "            C O N V E R T  T O           "
	(
		button convertBtn "Standard Material" tooltip:"Convert WireColor to Standard Material" width:152 height:20 color:[33,50,85] align:#left
	)
	on convertBtn pressed do

	(
		if selection.count == 1
				then (
	
	myColor = $.wireColor
	$.material = standardMaterial showInViewport:true name:("converted_with_ProColor_"+$.name)
	$.material.diffuse = (myColor)
	messagebox "Successfully converted!"
					)
	
				else (messagebox "Please select only 1 object"))

	
	hyperLink author "Mark Hunanyan" address:"http://www.mark.am" color:(color 85 110 110) hovercolor:(color 255 255 255) visitedcolor:(color 85 110 110)  align:#center

)	
createDialog rltProColor 180 403
